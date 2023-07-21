class Market {
  int id;
  String name;
  String address;
  String image;

  Market(this.id, this.name, this.address, this.image);

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(json['id'], json['name'], json['address'], json['image']);
  }
}
