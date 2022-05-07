class Coin {
  final String id, name, logoUrl;
  final double price;

  const Coin({
    required this.id,
    required this.name,
    required this.price,
    required this.logoUrl
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['symbol'],
      name: json['name'],
      price: double.parse(json['price']),
      logoUrl: json['logo_url']
    );
  }
}