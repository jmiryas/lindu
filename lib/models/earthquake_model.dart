class EarthquakeModel {
  EarthquakeModel({
    this.tanggal = "",
    this.jam = "",
    this.dateTime,
    this.coordinates = "",
    this.lintang = "",
    this.bujur = "",
    this.magnitude = "",
    this.kedalaman = "",
    this.wilayah = "",
    this.potensi = "",
    this.dirasakan = "",
    this.shakemap = "",
  });

  String tanggal;
  String jam;
  DateTime? dateTime;
  String coordinates;
  String lintang;
  String bujur;
  String magnitude;
  String kedalaman;
  String wilayah;
  String potensi;
  String dirasakan;
  String shakemap;

  factory EarthquakeModel.fromJson(Map<String, dynamic> json) =>
      EarthquakeModel(
        tanggal: json["Tanggal"] ?? "",
        jam: json["Jam"] ?? "",
        dateTime: DateTime.parse(json["DateTime"]),
        coordinates: json["Coordinates"] ?? "",
        lintang: json["Lintang"] ?? "",
        bujur: json["Bujur"] ?? "",
        magnitude: json["Magnitude"] ?? "",
        kedalaman: json["Kedalaman"] ?? "",
        wilayah: json["Wilayah"] ?? "",
        potensi: json["Potensi"] ?? "",
        dirasakan: json["Dirasakan"] ?? "",
        shakemap: json["Shakemap"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Tanggal": tanggal,
        "Jam": jam,
        "DateTime": dateTime!.toIso8601String(),
        "Coordinates": coordinates,
        "Lintang": lintang,
        "Bujur": bujur,
        "Magnitude": magnitude,
        "Kedalaman": kedalaman,
        "Wilayah": wilayah,
        "Potensi": potensi,
        "Dirasakan": dirasakan,
        "Shakemap": shakemap,
      };
}
