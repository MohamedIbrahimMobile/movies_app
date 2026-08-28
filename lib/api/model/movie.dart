import 'cast.dart';
import 'torrents.dart';

class Movie {
  final int? id;
  final String? url;
  final String? imdbCode;
  final String? title;
  final String? titleEnglish;
  final String? titleLong;
  final String? slug;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String> genres;

  // Details
  final int? likeCount;
  final String? descriptionIntro;
  final String? descriptionFull;
  final String? summary;
  final String? synopsis;

  final String? ytTrailerCode;
  final String? language;
  final String? mpaRating;

  // Images
  final String? backgroundImage;
  final String? backgroundImageOriginal;
  final String? smallCoverImage;
  final String? mediumCoverImage;
  final String? largeCoverImage;

  final String? mediumScreenshotImage1;
  final String? mediumScreenshotImage2;
  final String? mediumScreenshotImage3;

  final String? largeScreenshotImage1;
  final String? largeScreenshotImage2;
  final String? largeScreenshotImage3;

  // Details
  final List<Cast> cast;
  final List<Torrents> torrents;

  final String? state;
  final String? dateUploaded;
  final int? dateUploadedUnix;

  const Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres = const [],
    this.likeCount,
    this.descriptionIntro,
    this.descriptionFull,
    this.summary,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.mediumScreenshotImage1,
    this.mediumScreenshotImage2,
    this.mediumScreenshotImage3,
    this.largeScreenshotImage1,
    this.largeScreenshotImage2,
    this.largeScreenshotImage3,
    this.cast = const [],
    this.torrents = const [],
    this.state,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      url: json['url'],
      imdbCode: json['imdb_code'],
      title: json['title'],
      titleEnglish: json['title_english'],
      titleLong: json['title_long'],
      slug: json['slug'],
      year: json['year'],
      rating: (json['rating'] as num?)?.toDouble(),
      runtime: json['runtime'],

      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],

      likeCount: json['like_count'],
      descriptionIntro: json['description_intro'],
      descriptionFull: json['description_full'],
      summary: json['summary'],
      synopsis: json['synopsis'],

      ytTrailerCode: json['yt_trailer_code'],
      language: json['language'],
      mpaRating: json['mpa_rating'],

      backgroundImage: json['background_image'],
      backgroundImageOriginal: json['background_image_original'],
      smallCoverImage: json['small_cover_image'],
      mediumCoverImage: json['medium_cover_image'],
      largeCoverImage: json['large_cover_image'],

      mediumScreenshotImage1: json['medium_screenshot_image1'],
      mediumScreenshotImage2: json['medium_screenshot_image2'],
      mediumScreenshotImage3: json['medium_screenshot_image3'],

      largeScreenshotImage1: json['large_screenshot_image1'],
      largeScreenshotImage2: json['large_screenshot_image2'],
      largeScreenshotImage3: json['large_screenshot_image3'],

      cast: json['cast'] != null
          ? (json['cast'] as List).map((e) => Cast.fromJson(e)).toList()
          : [],

      torrents: json['torrents'] != null
          ? (json['torrents'] as List).map((e) => Torrents.fromJson(e)).toList()
          : [],

      state: json['state'],
      dateUploaded: json['date_uploaded'],
      dateUploadedUnix: json['date_uploaded_unix'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'imdb_code': imdbCode,
      'title': title,
      'title_english': titleEnglish,
      'title_long': titleLong,
      'slug': slug,
      'year': year,
      'rating': rating,
      'runtime': runtime,
      'genres': genres,
      'like_count': likeCount,
      'description_intro': descriptionIntro,
      'description_full': descriptionFull,
      'summary': summary,
      'synopsis': synopsis,
      'yt_trailer_code': ytTrailerCode,
      'language': language,
      'mpa_rating': mpaRating,
      'background_image': backgroundImage,
      'background_image_original': backgroundImageOriginal,
      'small_cover_image': smallCoverImage,
      'medium_cover_image': mediumCoverImage,
      'large_cover_image': largeCoverImage,
      'medium_screenshot_image1': mediumScreenshotImage1,
      'medium_screenshot_image2': mediumScreenshotImage2,
      'medium_screenshot_image3': mediumScreenshotImage3,
      'large_screenshot_image1': largeScreenshotImage1,
      'large_screenshot_image2': largeScreenshotImage2,
      'large_screenshot_image3': largeScreenshotImage3,
      'cast': cast.map((e) => e.toJson()).toList(),
      'torrents': torrents.map((e) => e.toJson()).toList(),
      'state': state,
      'date_uploaded': dateUploaded,
      'date_uploaded_unix': dateUploadedUnix,
    };
  }
}
