import 'Cast.dart';
import 'Torrents.dart';

/// id : 10
/// url : "https://yts.gg/movies/13-2010"
/// imdb_code : "tt0798817"
/// title : "13"
/// title_english : "13"
/// title_long : "13 (2010)"
/// slug : "13-2010"
/// year : 2010
/// rating : 6
/// runtime : 91
/// genres : ["Action","Crime","Drama","Thriller"]
/// like_count : 79
/// description_intro : "A desperate man takes part in an underworld game of Russian roulette."
/// description_full : "A desperate man takes part in an underworld game of Russian roulette."
/// yt_trailer_code : "Y41fFj-P4jI"
/// language : "en"
/// mpa_rating : "R"
/// background_image : "https://yts.gg/assets/images/movies/13_2010/background.jpg"
/// background_image_original : "https://yts.gg/assets/images/movies/13_2010/background.jpg"
/// small_cover_image : "https://yts.gg/assets/images/movies/13_2010/small-cover.jpg"
/// medium_cover_image : "https://yts.gg/assets/images/movies/13_2010/medium-cover.jpg"
/// large_cover_image : "https://yts.gg/assets/images/movies/13_2010/large-cover.jpg"
/// medium_screenshot_image1 : "https://yts.gg/assets/images/movies/13_2010/medium-screenshot1.jpg"
/// medium_screenshot_image2 : "https://yts.gg/assets/images/movies/13_2010/medium-screenshot2.jpg"
/// medium_screenshot_image3 : "https://yts.gg/assets/images/movies/13_2010/medium-screenshot3.jpg"
/// large_screenshot_image1 : "https://yts.gg/assets/images/movies/13_2010/large-screenshot1.jpg"
/// large_screenshot_image2 : "https://yts.gg/assets/images/movies/13_2010/large-screenshot2.jpg"
/// large_screenshot_image3 : "https://yts.gg/assets/images/movies/13_2010/large-screenshot3.jpg"
/// cast : [{"name":"Jason Statham","character_name":"Jasper","url_small_image":"https://yts.gg/assets/images/actors/thumb/nm0005458.jpg","imdb_code":"0005458"},{"name":"Emmanuelle Chriqui","character_name":"Aileen","url_small_image":"https://yts.gg/assets/images/actors/thumb/nm0004825.jpg","imdb_code":"0004825"},{"name":"Charles Pendelton","character_name":"Gambler","url_small_image":"https://yts.gg/assets/images/actors/thumb/nm1154281.jpg","imdb_code":"1154281"},{"name":"Michael Shannon","character_name":"Henry","url_small_image":"https://yts.gg/assets/images/actors/thumb/nm0788335.jpg","imdb_code":"0788335"}]
/// torrents : [{"url":"https://yts.gg/torrent/download/BE046ED20B048C4FB86E15838DD69DADB27C5E8A","hash":"BE046ED20B048C4FB86E15838DD69DADB27C5E8A","quality":"720p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":6,"peers":3,"size":"946.49 MB","size_bytes":992466698,"date_uploaded":"2015-10-31 20:46:37","date_uploaded_unix":1446320797},{"url":"https://yts.gg/torrent/download/FEE33A702158CD451220BD4F23FC46AD7BC65C4D","hash":"FEE33A702158CD451220BD4F23FC46AD7BC65C4D","quality":"1080p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":28,"peers":9,"size":"1.79 GB","size_bytes":1921997865,"date_uploaded":"2022-01-19 00:57:56","date_uploaded_unix":1642550276}]
/// date_uploaded : "2015-10-31 20:46:37"
/// date_uploaded_unix : 1446320797

class Movie {
  Movie({
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
      this.genres, 
      this.likeCount, 
      this.descriptionIntro, 
      this.descriptionFull, 
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
      this.cast, 
      this.torrents, 
      this.dateUploaded, 
      this.dateUploadedUnix,});

  Movie.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating = json['rating'];
    runtime = json['runtime'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    likeCount = json['like_count'];
    descriptionIntro = json['description_intro'];
    descriptionFull = json['description_full'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    mediumScreenshotImage1 = json['medium_screenshot_image1'];
    mediumScreenshotImage2 = json['medium_screenshot_image2'];
    mediumScreenshotImage3 = json['medium_screenshot_image3'];
    largeScreenshotImage1 = json['large_screenshot_image1'];
    largeScreenshotImage2 = json['large_screenshot_image2'];
    largeScreenshotImage3 = json['large_screenshot_image3'];
    if (json['cast'] != null) {
      cast = [];
      json['cast'].forEach((v) {
        cast?.add(Cast.fromJson(v));
      });
    }
    if (json['torrents'] != null) {
      torrents = [];
      json['torrents'].forEach((v) {
        torrents?.add(Torrents.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  num? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  num? year;
  num? rating;
  num? runtime;
  List<String>? genres;
  num? likeCount;
  String? descriptionIntro;
  String? descriptionFull;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? mediumScreenshotImage1;
  String? mediumScreenshotImage2;
  String? mediumScreenshotImage3;
  String? largeScreenshotImage1;
  String? largeScreenshotImage2;
  String? largeScreenshotImage3;
  List<Cast>? cast;
  List<Torrents>? torrents;
  String? dateUploaded;
  num? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['like_count'] = likeCount;
    map['description_intro'] = descriptionIntro;
    map['description_full'] = descriptionFull;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['medium_screenshot_image1'] = mediumScreenshotImage1;
    map['medium_screenshot_image2'] = mediumScreenshotImage2;
    map['medium_screenshot_image3'] = mediumScreenshotImage3;
    map['large_screenshot_image1'] = largeScreenshotImage1;
    map['large_screenshot_image2'] = largeScreenshotImage2;
    map['large_screenshot_image3'] = largeScreenshotImage3;
    if (cast != null) {
      map['cast'] = cast?.map((v) => v.toJson()).toList();
    }
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

}