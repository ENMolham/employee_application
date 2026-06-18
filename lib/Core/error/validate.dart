String? validateRequiredField(String? value) {
  if (value == null || value.isEmpty) {
    return "هذا الحقل مطلوب";
  }
  return null;
}
