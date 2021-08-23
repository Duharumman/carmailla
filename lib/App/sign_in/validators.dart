abstract class StringValidator {
  bool isVaild(String vlaue);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isVaild(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidator {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}
