class Validators {
  static String? requiredField(String? value, {String message = 'Required'}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone is required';
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10) return 'Enter a valid phone number';
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.trim().isEmpty) return 'OTP is required';
    if (!RegExp(r'^\d{6}
?$').hasMatch(value.trim())) return 'Enter 6 digit OTP';
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value);
    if (!ok) return 'Invalid email';
    return null;
  }
}

