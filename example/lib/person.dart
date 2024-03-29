import 'package:field_key_generator/field_key_generator.dart';

part 'person.g.dart';

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
