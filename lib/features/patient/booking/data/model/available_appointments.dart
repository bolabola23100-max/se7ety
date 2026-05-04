List<int> getAvailableAppointments(
  DateTime selectedDate,
  String start,
  String end,
) {
  int _extractHour(String time) {
    try {
      // Normalize Arabic digits to English digits
      String normalizedTime = time;
      const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
      const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
      for (int i = 0; i < 10; i++) {
        normalizedTime = normalizedTime.replaceAll(arabicDigits[i], englishDigits[i]);
      }

      if (normalizedTime.contains(':')) {
        var parts = normalizedTime.split(':');
        var hourPart = parts[0].replaceAll(RegExp(r'[^0-9]'), '');
        var hour = int.parse(hourPart);
        
        // Handle AM/PM if present
        String lowTime = normalizedTime.toLowerCase();
        if ((lowTime.contains('pm') || lowTime.contains('م')) && hour != 12) {
          hour += 12;
        } else if ((lowTime.contains('am') || lowTime.contains('ص')) && hour == 12) {
          hour = 0;
        }
        return hour;
      } else {
        return int.parse(normalizedTime.replaceAll(RegExp(r'[^0-9]'), ''));
      }
    } catch (e) {
      return 0;
    }
  }

  int startHour = _extractHour(start);
  int endHour = _extractHour(end);

  List<int> availableHours = [];
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  int diffInDays = selectedDate.difference(today).inDays;

  for (int i = startHour; i < endHour; i++) {
    if (diffInDays > 0) {
      availableHours.add(i);
    } else if (diffInDays == 0) {
      if (i > now.hour) {
        availableHours.add(i);
      }
    }
  }

  return availableHours;
}
