class MovieDetailsApiResModel {
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieDetailsApiResModel({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  MovieDetailsApiResModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    backdropPath = json['backdrop_path'] as String?;
    belongsToCollection = json['belongs_to_collection'] != null
        ? BelongsToCollection.fromJson(
            json['belongs_to_collection'] as Map<String, dynamic>,
          )
        : null;
    budget = json['budget'] != null ? (json['budget'] as num).toInt() : null;

    if (json['genres'] != null) {
      genres = <Genre>[];
      (json['genres'] as List).forEach((v) {
        genres!.add(Genre.fromJson(v as Map<String, dynamic>));
      });
    }

    homepage = json['homepage'] as String?;
    id = json['id'] != null ? (json['id'] as num).toInt() : null;
    imdbId = json['imdb_id'] as String?;

    if (json['origin_country'] != null) {
      originCountry = List<String>.from(json['origin_country'] as List);
    }

    originalLanguage = json['original_language'] as String?;
    originalTitle = json['original_title'] as String?;
    overview = json['overview'] as String?;
    popularity = json['popularity'] != null
        ? (json['popularity'] as num).toDouble()
        : null;
    posterPath = json['poster_path'] as String?;

    if (json['production_companies'] != null) {
      productionCompanies = <ProductionCompany>[];
      (json['production_companies'] as List).forEach((v) {
        productionCompanies!.add(
          ProductionCompany.fromJson(v as Map<String, dynamic>),
        );
      });
    }

    if (json['production_countries'] != null) {
      productionCountries = <ProductionCountry>[];
      (json['production_countries'] as List).forEach((v) {
        productionCountries!.add(
          ProductionCountry.fromJson(v as Map<String, dynamic>),
        );
      });
    }

    releaseDate = json['release_date'] as String?;
    revenue = json['revenue'] != null ? (json['revenue'] as num).toInt() : null;
    runtime = json['runtime'] != null ? (json['runtime'] as num).toInt() : null;

    if (json['spoken_languages'] != null) {
      spokenLanguages = <SpokenLanguage>[];
      (json['spoken_languages'] as List).forEach((v) {
        spokenLanguages!.add(
          SpokenLanguage.fromJson(v as Map<String, dynamic>),
        );
      });
    }

    status = json['status'] as String?;
    tagline = json['tagline'] as String?;
    title = json['title'] as String?;
    video = json['video'] as bool?;
    voteAverage = json['vote_average'] != null
        ? (json['vote_average'] as num).toDouble()
        : null;
    voteCount = json['vote_count'] != null
        ? (json['vote_count'] as num).toInt()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    if (belongsToCollection != null) {
      data['belongs_to_collection'] = belongsToCollection!.toJson();
    }
    data['budget'] = budget;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    if (productionCompanies != null) {
      data['production_companies'] = productionCompanies!
          .map((v) => v.toJson())
          .toList();
    }
    if (productionCountries != null) {
      data['production_countries'] = productionCountries!
          .map((v) => v.toJson())
          .toList();
    }
    data['release_date'] = releaseDate;
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    if (spokenLanguages != null) {
      data['spoken_languages'] = spokenLanguages!
          .map((v) => v.toJson())
          .toList();
    }
    data['status'] = status;
    data['tagline'] = tagline;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class BelongsToCollection {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? (json['id'] as num).toInt() : null;
    name = json['name'] as String?;
    posterPath = json['poster_path'] as String?;
    backdropPath = json['backdrop_path'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['poster_path'] = posterPath;
    data['backdrop_path'] = backdropPath;
    return data;
  }
}

class Genre {
  int? id;
  String? name;

  Genre({this.id, this.name});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? (json['id'] as num).toInt() : null;
    name = json['name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ProductionCompany {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompany({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? (json['id'] as num).toInt() : null;
    logoPath = json['logo_path'] as String?;
    name = json['name'] as String?;
    originCountry = json['origin_country'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }
}

class ProductionCountry {
  String? iso31661;
  String? name;

  ProductionCountry({this.iso31661, this.name});

  ProductionCountry.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'] as String?;
    name = json['name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    return data;
  }
}

class SpokenLanguage {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguage({this.englishName, this.iso6391, this.name});

  SpokenLanguage.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'] as String?;
    iso6391 = json['iso_639_1'] as String?;
    name = json['name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['english_name'] = englishName;
    data['iso_639_1'] = iso6391;
    data['name'] = name;
    return data;
  }
}
