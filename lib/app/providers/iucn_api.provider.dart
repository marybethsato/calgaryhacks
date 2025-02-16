import 'dart:convert';

import 'package:calgaryhacks/app/models/climate_change.model.dart';
import 'package:http/http.dart';

class ClimateChangeImpactProvider {
  static Future<ClimateChangeImpacts?> getClimateChangeImpact(
      String species) async {
    try {
      final res = await post(
          Uri.parse(
              "https://us-central1-calgaryhacks2025.cloudfunctions.net/get-climate-change-info"),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: json.encode({"species": species}));

      print(res.body);

      return ClimateChangeImpacts.fromJson(json.decode(res.body));
    } catch (e) {
      print(e);
      return null;
    }
  }
}
