enum Order {
  byNameAsc(property: "name", direction: "ASC"),
  byNameDesc(property: "name", direction: "DESC"),
  byPriceAsc(property: "price", direction: "ASC"),
  byPriceDesc(property: "price", direction: "DESC");

  final String property;
  final String direction;

  const Order({required this.property, required this.direction});
}
