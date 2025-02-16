import 'dart:convert';

class Observation {
  final int id;
  final double? latitude;
  final double? longitude;
  final String observedOn;
  final String? speciesGuess;
  final String? placeGuess;

  Observation({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.observedOn,
    this.speciesGuess,
    this.placeGuess,
  });

  factory Observation.fromJson(Map<String, dynamic> json) {
    return Observation(
      id: json['id'],
      latitude: json['geojson'] != null
          ? (json['geojson']['coordinates'][1] as num).toDouble()
          : null,
      longitude: json['geojson'] != null
          ? (json['geojson']['coordinates'][0] as num).toDouble()
          : null,
      observedOn: json['observed_on'] ?? '',
      speciesGuess: json['species_guess'],
      placeGuess: json['place_guess'],
    );
  }
}
