class Validators {
  static String? requiredField(String? value, {String message = 'Required'}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Mobile is required';
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length != 10) return 'Enter 10 digit mobile';
    return null;
  }
}

