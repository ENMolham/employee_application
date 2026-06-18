class FilterOptionsData {
  FilterOptionsData._();
  static const Map<String, String> statusOptions = {
    'الكل': 'الكل',
    '1': 'جديدة',
    '2': 'قيد الدراسة',
    '3': 'معلقة',
    '4': 'محولة',
    '5': 'محولة استثنائياً',
    '6': 'مرفوضة',
    '7': 'منتهية',
  };
  static Map<String, String> get dayOptions => {
    'الكل': 'الكل',
    for (int i = 1; i <= 31; i++) '$i': i.toString().padLeft(2, '0'),
  };

  static const Map<String, String> monthOptions = {
    'الكل': 'الكل',
    '1': 'كانون الثاني',
    '2': 'شباط',
    '3': 'آذار',
    '4': 'نيسان',
    '5': 'أيار',
    '6': 'حزيران',
    '7': 'تموز',
    '8': 'آب',
    '9': 'أيلول',
    '10': 'تشرين الأول',
    '11': 'تشرين الثاني',
    '12': 'كانون الأول',
  };

  static Map<String, String> yearOptions({int yearsCount = 101}) {
    final currentYear = DateTime.now().year;
    return {
      'الكل': 'الكل',
      for (int y = currentYear; y > currentYear - yearsCount; y--) '$y': '$y',
    };
  }
}
