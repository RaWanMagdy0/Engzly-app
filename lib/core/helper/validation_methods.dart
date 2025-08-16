String? nameValidator(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter your $fieldName';
  }

  if (!RegExp(r"^[a-zA-Z0-9\s'-]+$").hasMatch(value.trim())) {
    return '$fieldName can only contain letters, numbers, spaces, or dashes';
  }

  return null;
}
