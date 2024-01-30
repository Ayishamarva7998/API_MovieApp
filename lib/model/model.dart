class MovieModel {
  String? title;
  String? backDropPath;
  String? originalTitle;
  String? overView;

  String? posterPath;
  String? releaseDate;
  double? voteAverage;
  int? id;

  MovieModel(
      {required this.title,
      required this.backDropPath,
      required this.originalTitle,
      required this.overView,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage,
      required this.id});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        title: json["title"] ?? 'No Data',
        backDropPath: json["backdrop_path"] ?? 'No Data',
        originalTitle: json["original_title"] ?? 'No Data',
        overView: json["overview"] ?? 'No Data',
        posterPath: json["poster_path"] ?? 'No Data',
        releaseDate: json["release_date"] ?? 'No Data',
        voteAverage: json["vote_average"].toDouble() ?? 'No Data',
        id: json['id'] ?? 'No Data');
  }
}