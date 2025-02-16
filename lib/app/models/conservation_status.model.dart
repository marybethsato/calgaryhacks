class ConservationStatusModel {
  final String status;
  final String authority;

  ConservationStatusModel({
    required this.status,
    required this.authority,
  });

  factory ConservationStatusModel.fromJson(Map<String, dynamic> json) {
    return ConservationStatusModel(
      status: json["status"],
      authority: json["authority"] ?? "Unknown Authority",
    );
  }
}
