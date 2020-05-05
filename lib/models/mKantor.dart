class Kantors {
  final String nokant;
  final String nmkant;

  Kantors({this.nokant, this.nmkant});

  factory Kantors.fromJson(Map<String, dynamic> json) {
    return new Kantors(
      nokant: json['nokant'],
      nmkant: json['nmkant'],
    );
  }
}
