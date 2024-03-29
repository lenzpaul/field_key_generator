import 'package:example/person.dart';

void main(List<String> arguments) {
  final person = Person(
    firstName: 'John',
    lastName: 'Doe',
    age: 30,
  );

  print(
      "${$PersonFieldKeys.firstName}: ${person.firstName}"); // firstName: John
  print("${$PersonFieldKeys.lastName}: ${person.lastName}"); // lastName: Doe
  print("${$PersonFieldKeys.age}: ${person.age}"); // age: 30

  // "fullName" excluded from generated field keys
  // print("${$PersonFieldKeys.fullName}: ${person.fullName}");
}
