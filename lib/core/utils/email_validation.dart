String? emailValidation(String? value) {
  if (value == null) {
    return 'Mandatory';
  } else if (value.trim() == '') {
    return 'Please enter email Id';
  } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return 'Enter a Valid Email Id';
  }
  return null;
}
