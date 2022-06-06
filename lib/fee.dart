class Details {
  final String title, price, description;

  const Details({
    required this.title,
    required this.price,
    this.description = ""
  });
}

class Fee {
  final String title, subtitle, price, description;
  final List<Details> details;

  const Fee({
    required this.title,
    required this.subtitle,
    this.details = const [],
    this.description = "",
    this.price = ""
  });
}

class Clinic {
  final String name;
  final List<int> availableDays;
  final int openHour, closeHour;
  final int openMinute, closeMinute;

  const Clinic({
    required this.name,
    required this.availableDays,
    required this.openHour,
    required this.closeHour,
    this.openMinute = 0,
    this.closeMinute = 0
  });
}