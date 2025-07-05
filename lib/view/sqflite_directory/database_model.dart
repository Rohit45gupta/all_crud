class DetailModel {
  int? id;
  String name;
  String email;
  String? image;

  DetailModel({
    this.id,
    required this.name,
    required this.email,
     this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "image": image,
    };
  }

  factory DetailModel.fromMap(Map<String, dynamic> map) {
    return DetailModel(
      id: map['id'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
