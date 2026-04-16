extension DateFormatterExtension on String? {
  String toMonthYear() {
    if (this == null || this!.isEmpty) {
      return 'N/A';
    }

    try {
      final List<String> parts = this!.split('-');
      if (parts.length >= 2) {
        final String year = parts[0];
        final String month = parts[1];
        return '$month/$year';
      }
      return this!;
    } catch (_) {
      return 'N/A';
    }
  }
}
