import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

class FieldKeysGenerator extends GeneratorForAnnotation<GenerateFieldKeys> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '$GenerateFieldKeys can only be used on classes.',
        element: element,
      );
    }

    // Ensure that the GenerateFieldKeys does not have both include and exclude
    // specified.

    // Convert DartObject list to a list of strings
    List<String> convertToStringList(ConstantReader reader) {
      return reader.listValue
          .map((dartObject) => dartObject.toStringValue())
          .whereType<String>()
          .toList();
    }

    // Then use this function to get your include and exclude lists
    final List<String> include =
        convertToStringList(annotation.read('include'));
    final List<String> exclude =
        convertToStringList(annotation.read('exclude'));

    if (include.isNotEmpty && exclude.isNotEmpty) {
      throw InvalidGenerationSourceError(
        'Cannot specify both `include` and `exclude` on $GenerateFieldKeys annotation.',
        element: element,
      );
    }

    // ignore: unnecessary_cast
    final classElement = element as ClassElement;
    final className = classElement.displayName;
    final buffer = StringBuffer();

    buffer.writeln('class \$${className}FieldKeys {');

    // For each of the fields, generate a static constant with the same name
    // as the field, and the value of the field name.
    //
    // If the include list is not empty, only include fields that are in the
    // include list.
    //
    // If the exclude list is not empty, only include fields that are not in
    // the exclude list.
    for (final field in classElement.fields) {
      final fieldName = field.name;
      if (field.getter == null) {
        throw InvalidGenerationSourceError(
          'Field $fieldName does not have a getter.',
          element: field,
        );
      }

      if (include.isNotEmpty && !include.contains(fieldName)) {
        continue;
      }

      if (exclude.isNotEmpty && exclude.contains(fieldName)) {
        continue;
      }

      buffer.writeln('  static const String $fieldName = \'$fieldName\';');
    }

    buffer.writeln('}');
    return buffer.toString();
  }
}
