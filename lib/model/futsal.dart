class AllFutsals {
  bool? success;
  List<Futsal>? futsal;
  String? message;

  AllFutsals({this.success, this.futsal, this.message});

  AllFutsals.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      futsal = <Futsal>[];
      json['data'].forEach((v) {
        futsal!.add(Futsal.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (futsal != null) {
      data['data'] = futsal!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Futsal {
  String? id;
  String? name;
  String? address;
  String? contact;
  String? side;
  String? description;
  String? image;
  String? price;

  Futsal(
      {this.id,
      this.name,
      this.address,
      this.contact,
      this.side,
      this.price,
      this.description,
      this.image});

  Futsal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    side = json['side'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['contact'] = contact;
    data['side'] = side;
    data['description'] = description;
    data['image'] = image;
    data['price'] = price;
    return data;
  }
}
