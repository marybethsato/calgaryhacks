import 'dart:convert';
import 'package:calgaryhacks/app/models/observation.model.dart';
import 'package:http/http.dart' as http;

class INaturalistAPI {
  static const String baseUrl = "https://api.inaturalist.org/v1";

  /// 🦁 **1. Get Species Details (Description, Photo, Wikipedia)**
  static Future<Map<String, dynamic>?> getSpeciesDetails(int taxonId) async {
    final url = Uri.parse("$baseUrl/taxa/$taxonId");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data["results"].isNotEmpty) {
          return data["results"][0]; // Return species details
        }
      }
    } catch (e) {
      print("Error fetching species details: $e");
    }
    return null;
  }

  /// 📍 **2. Get Map Range (Observations of the Species)**
  static Future<List<Observation>> getObservations(int taxonId) async {
    final url =
        Uri.parse("$baseUrl/observations?taxon_id=$taxonId&per_page=50");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return List.from(data["results"])
            .map((e) => Observation.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("Error fetching observations: $e");
    }
    return [];
  }

  /// 🛡 **3. Get Conservation Status**
  static Future<String?> getConservationStatus(int taxonId) async {
    final url = Uri.parse("$baseUrl/taxa/$taxonId");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data["results"].isNotEmpty &&
            data["results"][0]["conservation_status"] != null) {
          return data["results"][0]["conservation_status"]["status"];
        }
      }
    } catch (e) {
      print("Error fetching conservation status: $e");
    }
    return "Unknown";
  }

  /// 📖 **4. Get Wikipedia Description**
  static Future<String?> getWikipediaDescription(String speciesName) async {
    final url = Uri.parse(
        "https://en.wikipedia.org/api/rest_v1/page/summary/$speciesName");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data["extract"] ?? "No description available.";
      }
    } catch (e) {
      print("Error fetching Wikipedia description: $e");
    }
    return "No description found.";
  }
}
