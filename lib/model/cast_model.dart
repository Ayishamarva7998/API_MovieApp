class CastModel {
  String? name;
  String? originalName;
  String? profilePath;
  String? character;
  String? department;
  CastModel(
      {required this.name,
      required this.originalName,
      required this.character,
      required this.department,
      required this.profilePath});

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? "NO Data",
      originalName: json['original_name'] ?? "NO Data",
      character: json['character'] ?? "NO Data",
      department: json['known_for_department'] ?? "NO Data",
      profilePath: json['profile_path'] ?? "NO Data",
    );
  }
}