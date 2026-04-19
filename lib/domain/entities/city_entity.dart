// Saved city for search results and favorites
class CityEntity {
  final String name;
  final String country;
  final String? state;
  final double lat;
  final double lon;

  const CityEntity({
    required this.name,
    required this.country,
    this.state,
    required this.lat,
    required this.lon,
  });

  // Pretty display name for the city
  String get displayName {
    if (state != null && state!.isNotEmpty) {
      return '$name, $state, $country';
    }
    return '$name, $country';
  }

  // For JSON serialization (favorites storage)
  Map<String, dynamic> toJson() => {
    'name': name,
    'country': country,
    'state': state,
    'lat': lat,
    'lon': lon,
  };

  factory CityEntity.fromJson(Map<String, dynamic> json) => CityEntity(
    name: json['name'] as String,
    country: json['country'] as String,
    state: json['state'] as String?,
    lat: (json['lat'] as num).toDouble(),
    lon: (json['lon'] as num).toDouble(),
  );

  @override
  bool operator ==(Object other) =>
      other is CityEntity &&
      other.name == name &&
      other.country == country &&
      other.lat == lat &&
      other.lon == lon;

  @override
  int get hashCode => Object.hash(name, country, lat, lon);
}
