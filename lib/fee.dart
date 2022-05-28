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