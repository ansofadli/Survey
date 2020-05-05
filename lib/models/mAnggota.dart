  
class AngRembug {
  String idanggota;
  String nmanggota;
  String idrembug;
  String status;

  AngRembug({
    this.idanggota,
    this.nmanggota,
    this.idrembug,
    this.status,
  });

  factory AngRembug.fromJson(Map<String, dynamic> json) => AngRembug(
        idanggota: json["idanggota"],
        nmanggota: json["nmanggota"],
        idrembug: json["idrembug"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "idanggota": idanggota,
        "nmanggota": nmanggota,
        "idrembug": idrembug,
        "status": status,
      };
}
