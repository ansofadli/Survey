class RembugPusat {
  String idrembug;
  String nmrembug;
  String iddesa;

  RembugPusat({
    this.idrembug,
    this.nmrembug,
    this.iddesa,
  });

  factory RembugPusat.fromJson(Map<String, dynamic> json) => RembugPusat(
        idrembug: json["idrembug"],
        nmrembug: json["nmrembug"],
        iddesa: json["iddesa"],
      );

  Map<String, dynamic> toJson() => {
        "idrembug": idrembug,
        "nmrembug": nmrembug,
        "iddesa": iddesa,
      };
}
