class User {
  User({
    this.id,
    this.email,
    this.phone,
    this.role,
    this.token
  });

  String? id;
  String? email;
  String? phone;
  String? role;
  String? token;
  

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] ?? json["id"],
        email: json["correo"] ?? json["email"],
        phone: json["telefono"] ?? json["phone"],
        role: json["rol"] ?? json["role"],
        token: json["token"] ,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "role": role,
        "token": token,
      };
}
