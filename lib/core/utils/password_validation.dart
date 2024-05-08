String? passwordValidation(String? value) {
  if (value == null) {
    return 'Mandatory';
  } else if (value.trim() == '') {
    return 'Enter Your Password';
  } else if (value.length < 6) {
    return 'Password is too small';
  }
  return null;
}
