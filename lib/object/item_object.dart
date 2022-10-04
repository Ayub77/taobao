class Item {
  String id;
  String image;
  String name;
  String productName;
  String status;
  String date;
  String price;

  Item(this.id, this.image, this.name, this.productName, this.status, this.date,
      this.price);

  Item.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        image = json["image"],
        name = json["name"],
        productName = json["product"],
        status = json["status"],
        date = json["date"],
        price = json["price"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "product": productName,
        "status": status,
        "date": date,
        "price": price
      };
}
