/// Common validation functions used across the app
/// These functions provide consistent validation logic for forms

/// Email validation using regex
bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email) && email.contains('@');
}

/// Phone number validation using regex
bool isValidPhoneNumber(String phone) {
  final phoneRegex = RegExp(r'^[\d\s\+\-\(\)]{10,15}$');
  return phoneRegex.hasMatch(phone) &&
      phone.replaceAll(RegExp(r'[^\d]'), '').length >= 10;
}

/// Password strength validation
bool isValidPassword(String password) {
  return password.length >= 6;
}

/// Name validation
bool isValidName(String name) {
  return name.length >= 2;
}

/// Check if field is empty
bool isFieldEmpty(String value) {
  return value.trim().isEmpty;
}
