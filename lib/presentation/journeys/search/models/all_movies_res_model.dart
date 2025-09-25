// Model classes for the "all movies" API response.
// Generated to match the example JSON response provided to the assistant.

class AllMoviesResModel {
  AllMoviesResModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<MovieResult>? results;
  int? totalPages;
  int? totalResults;

  factory AllMoviesResModel.fromJson(Map<String, dynamic> json) =>
      AllMoviesResModel(
        page: json['page'] as int?,
        results: json['results'] != null
            ? List<MovieResult>.from(
                (json['results'] as List).map(
                  (x) => MovieResult.fromJson(x as Map<String, dynamic>),
                ),
              )
            : null,
        totalPages: json['total_pages'] as int?,
        totalResults: json['total_results'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'page': page,
    'results': results?.map((e) => e.toJson()).toList(),
    'total_pages': totalPages,
    'total_results': totalResults,
  };
}

class MovieResult {
  MovieResult({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  factory MovieResult.fromJson(Map<String, dynamic> json) => MovieResult(
    adult: json['adult'] as bool?,
    backdropPath: json['backdrop_path'] as String?,
    genreIds: json['genre_ids'] != null
        ? List<int>.from((json['genre_ids'] as List).map((x) => x as int))
        : null,
    id: json['id'] as int?,
    originalLanguage: json['original_language'] as String?,
    originalTitle: json['original_title'] as String?,
    overview: json['overview'] as String?,
    popularity: _toDouble(json['popularity']),
    posterPath: json['poster_path'] as String?,
    releaseDate: json['release_date'] as String?,
    title: json['title'] as String?,
    video: json['video'] as bool?,
    voteAverage: _toDouble(json['vote_average']),
    voteCount: json['vote_count'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'adult': adult,
    'backdrop_path': backdropPath,
    'genre_ids': genreIds,
    'id': id,
    'original_language': originalLanguage,
    'original_title': originalTitle,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'release_date': releaseDate,
    'title': title,
    'video': video,
    'vote_average': voteAverage,
    'vote_count': voteCount,
  };

  // Helper to safely convert numeric values that may come as int or double or strings.
  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    if (value is num) return value.toDouble();
    return null;
  }
}
