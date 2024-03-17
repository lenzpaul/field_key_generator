import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'generator.dart';

Builder fieldKeyBuilder(BuilderOptions options) =>
    SharedPartBuilder([FieldKeysGenerator()], 'field_name');
