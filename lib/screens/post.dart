import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.name,
    required this.price,
    required this.url,
    required this.qty,
  });

  String name;
  int price;
  String url;
  int qty;

  static int getQty = 0;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        name: json["name"],
        price: json["price"],
        url: json["url"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "url": url,
        "qty": qty,
      };
}
