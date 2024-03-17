 # Field Key Generator
 The Field Key Generator library provides a mechanism to generate type-safe
 access to field names in Dart classes. By using annotations, it automates
 the creation of a companion class containing static constants for field
 names.

 The Field Key Generator simplifies code maintenance and helps prevent runtime
 errors when accessing field names.

 ## Usage

 To use the Field Key Generator, follow these steps:

 1. Import the library:

 ```dart
 import 'package:field_key_generator/field_key_generator.dart';
 ```

 2. Annotate your class with `@GenerateFieldKeys()` to indicate that you want
    field keys generated for it. Then, annotate the fields for which you want
    keys generated with `@FieldKey()`.

 ```dart
 @GenerateFieldKeys()
 class Person {
   @FieldKey()
   final String name;

   @FieldKey()
   final int age;

   // Will not be included in the generated class.
   String get description => '$name is $age years old';

   Person(this.name, this.age);
 }
 ```

 3. Run the code generation step. Depending on your build tool or setup,
    this step might vary. The generator will create a companion class
    (e.g., `_PersonFieldKeys`) with static constants for the annotated fields.

 ```dart
 class $PersonFieldKeys {
   static const name = 'name';
   static const age = 'age';
 }
 ```

 4. Now, you can use these generated constants for type-safe access to field
    names without the risk of typos:

 ```dart
 final person = Person('John', 30);
 print(person[$PersonFieldKeys.name]); // Outputs 'John'
 print(person[$PersonFieldKeys.age]);  // Outputs 30
 ```

