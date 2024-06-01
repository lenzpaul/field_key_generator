 # Field Key Generator

Static reflection for Flutter. Similar to [dart:mirrors](https://api.dart.dev/stable/3.4.2/dart-mirrors/dart-mirrors-library.html), but uses compile time code generation.

The package will create a companion class that holds static constants representing each field in the original class.

## Example

https://github.com/lenzpaul/field_key_generator/assets/34327253/c795d522-9cfb-4b75-804f-ab264c821274

To run the example, follow these steps:
- Run build_runner to generate the field keys: `dart run build_runner build`
- Run the example: `dart run bin/person.dart`


 ## Usage

 To use the Field Key Generator, follow these steps:

 1. Import the library and add the part directive to the file where you want
    to generate field keys.

 ```dart
 // person.dart
 import 'package:field_key_generator/field_key_generator.dart';
 part 'person.g.dart';
 ```

 2. Annotate your class with `@GenerateFieldKeys()` to indicate that you want
    field keys generated for it. 
    
    You can exclude specific fields by providing their names in the `exclude`
      parameter. You can also include only specific fields by providing their
      names in the `include` parameter. Only one of `exclude` or `include` can
      be used at a time.

 ```dart
@GenerateFieldKeys(exclude: ['fullName'])
class Person {
  final String firstName;
  final String lastName;
  final int age;

  String get fullName => '$firstName $lastName';

  Person({
    required this.firstName,
    required this.lastName,
    required this.age,
  });
}
 ```

 3. Run the code generation step. The generator will create a companion class
    (e.g., `$PersonFieldKeys`) with static constants for the annotated fields.  
    
    Using the `build_runner` package: `dart run build_runner build`.  

    The generated file will be named `person.g.dart` and will look like this: 


 ```dart
 class $PersonFieldKeys {
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String age = 'age';
}

 ```

 4. Now, you can use these generated constants for type-safe access to field
    names in your code, the risk of typos. If the field name changes, you will
     get a compile-time error and you can easily update the field key. 

 ```dart
void main(List<String> arguments) {
   // Use the generated field keys in a database operation
   deleteDatabaseRecord(
    'persons',
    where: $PersonFieldKeys.firstName,
    whereArgs: ['John'],
   );
}
 ```


