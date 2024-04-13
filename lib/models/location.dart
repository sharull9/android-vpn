class Location {
  late final String id;
  late final String cityName;
  late final String cityCode;
  late final String countryName;
  late final String countryCode;
  late final String category;

  Location({
    required this.id,
    required this.cityName,
    required this.cityCode,
    required this.countryName,
    required this.countryCode,
    required this.category,
  });

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    cityName = json['city_name'] ?? '';
    cityCode = json['city_code'] ?? '';
    countryName = json['country_name'] ?? '';
    countryCode = json['country_code'] ?? '';
    category = json['category'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['city_name'] = cityName;
    data['city_code'] = cityCode;
    data['country_name'] = countryName;
    data['country_code'] = countryCode;
    data['category'] = category;
    return data;
  }
}
