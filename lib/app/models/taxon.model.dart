class TaxonModel {
  final int totalResults;
  final int page;
  final int perPage;
  final List<Result> results;

  TaxonModel({
    required this.totalResults,
    required this.page,
    required this.perPage,
    required this.results,
  });

  factory TaxonModel.fromJson(Map<String, dynamic> json) {
    return TaxonModel(
      totalResults: json['total_results'],
      page: json['page'],
      perPage: json['per_page'],
      results:
          (json['results'] as List).map((e) => Result.fromJson(e)).toList(),
    );
  }
}

class Result {
  final double combinedScore;
  final double visionScore;
  final Taxon taxon;

  Result({
    required this.combinedScore,
    required this.visionScore,
    required this.taxon,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      combinedScore: json['combined_score'].toDouble(),
      visionScore: json['vision_score'].toDouble(),
      taxon: Taxon.fromJson(json['taxon']),
    );
  }
}

class Taxon {
  final int id;
  final String rank;
  final String name;
  final String iconicTaxonName;
  final String? preferredCommonName;
  final String? wikipediaUrl;
  final DefaultPhoto defaultPhoto;

  Taxon({
    required this.id,
    required this.rank,
    required this.name,
    required this.iconicTaxonName,
    required this.defaultPhoto,
    this.preferredCommonName,
    this.wikipediaUrl,
  });

  factory Taxon.fromJson(Map<String, dynamic> json) {
    return Taxon(
      id: json['id'],
      rank: json['rank'],
      name: json['name'],
      iconicTaxonName: json['iconic_taxon_name'],
      preferredCommonName: json['preferred_common_name'],
      wikipediaUrl: json['wikipedia_url'],
      defaultPhoto: DefaultPhoto.fromJson(json['default_photo']),
    );
  }
}

class DefaultPhoto {
  final int id;
  final String url;
  final String squareUrl;
  final String mediumUrl;

  DefaultPhoto({
    required this.id,
    required this.url,
    required this.squareUrl,
    required this.mediumUrl,
  });

  factory DefaultPhoto.fromJson(Map<String, dynamic> json) {
    return DefaultPhoto(
      id: json['id'],
      url: json['url'],
      squareUrl: json['square_url'],
      mediumUrl: json['medium_url'],
    );
  }
}

// Example usage:
// final model = TaxonModel.fromJson(jsonDecode(yourJsonString));
