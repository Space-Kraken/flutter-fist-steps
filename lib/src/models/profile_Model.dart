class ProfileModel {
  int? id;
  String? name;
  String? aPaterno;
  String? aMaterno;
  int? phoneNumber;
  String? email;
  String? image;

  ProfileModel(
      {this.id,
      this.name,
      this.aPaterno,
      this.aMaterno,
      this.phoneNumber,
      this.email,
      this.image});

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as int,
      name: map['name'] as String,
      aPaterno: map['aPaterno'] as String,
      aMaterno: map['aMaterno'] as String,
      phoneNumber: map['phoneNumber'] as int,
      email: map['email'] as String,
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'aPaterno': aPaterno,
      'aMaterno': aMaterno,
      'phoneNumber': phoneNumber,
      'email': email,
      'image': image,
    };
  }
}
