import 'dart:convert';

class ClimateChangeImpacts {
  final Species species;
  final List<String> threats;
  final HumanSolutions humanSolutions;

  ClimateChangeImpacts({
    required this.species,
    required this.threats,
    required this.humanSolutions,
  });

  factory ClimateChangeImpacts.fromJson(Map<String, dynamic> json) {
    return ClimateChangeImpacts(
      species: Species.fromJson(json['species']),
      threats: List<String>.from(json['threats']),
      humanSolutions: HumanSolutions.fromJson(json['human_solutions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'species': species.toJson(),
      'threats': threats,
      'human_solutions': humanSolutions.toJson(),
    };
  }
}

class Species {
  final String name;

  Species({required this.name});

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

class HumanSolutions {
  final List<String> individualActions;
  final List<String> communityInitiatives;
  final List<String> policyLegislation;

  HumanSolutions({
    required this.individualActions,
    required this.communityInitiatives,
    required this.policyLegislation,
  });

  factory HumanSolutions.fromJson(Map<String, dynamic> json) {
    return HumanSolutions(
      individualActions: List<String>.from(json['individual_actions']),
      communityInitiatives: List<String>.from(json['community_initiatives']),
      policyLegislation: List<String>.from(json['policy_legislation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'individual_actions': individualActions,
      'community_initiatives': communityInitiatives,
      'policy_legislation': policyLegislation,
    };
  }
}
