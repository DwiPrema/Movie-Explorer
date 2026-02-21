class ProductionCountriesModel {
  String iso;
  String name;

  ProductionCountriesModel({required this.iso, required this.name});

  factory ProductionCountriesModel.fromJson(Map<String, dynamic> json) {
    return ProductionCountriesModel(
      iso: json["iso_3166_1"],
      name: json["name"],
    );
  }
}
