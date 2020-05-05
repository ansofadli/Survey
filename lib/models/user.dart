class User {
  String iduser;
  String nama;
  String username;
  String password;
  String email;
  String nokant;
  String status;

  User({
    this.iduser,
    this.nama,
    this.username,
    this.password,
    this.email,
    this.nokant,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        iduser: json["iduser"],
        nama: json["nama"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        nokant: json["nokant"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "iduser": iduser,
        "nama": nama,
        "username": username,
        "password": password,
        "email": email,
        "nokant": nokant,
        "status": status,
      };
}
