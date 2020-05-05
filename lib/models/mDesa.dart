class Desaku {
  String nokant;
  String iddesa;
  String nmdesa;

  Desaku({
    this.nokant,
    this.iddesa,
    this.nmdesa,
  });
  factory Desaku.fromJson(Map<String, dynamic> json) {
    return new Desaku(
      nokant: json['nokant'],
      iddesa: json["iddesa"],
      nmdesa: json["nmdesa"],
    );
  }
}
