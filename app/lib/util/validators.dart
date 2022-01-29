String? validateEmail(String? value) {
  if (value != null && value.isEmpty ||
      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value!)) {
    return 'Enter a valid email!';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value != null && value.length < 8) {
    return 'Password must have atleast 8 characters!';
  }
  return null;
}

String? validateName(String? value) {
  if (value != null && value.length < 8) {
    return 'Name must have atleast 8 characters!';
  }
  return null;
}
