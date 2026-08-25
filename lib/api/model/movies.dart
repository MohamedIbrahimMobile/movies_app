import 'Torrents.dart';

/// id : 664
/// url : "https://yts.gg/movies/chaos-2005"
/// imdb_code : "tt0402910"
/// title : "Chaos"
/// title_english : "Chaos"
/// title_long : "Chaos (2005)"
/// slug : "chaos-2005"
/// year : 2005
/// rating : 6.4
/// runtime : 106
/// genres : ["Action","Crime","Drama","Thriller"]
/// summary : "Two cops; a rookie and a grizzled vet, pursue an accomplished bank robber."
/// description_full : "Two cops; a rookie and a grizzled vet, pursue an accomplished bank robber."
/// synopsis : "Two cops; a rookie and a grizzled vet, pursue an accomplished bank robber."
/// yt_trailer_code : "IzWbjvuIgAc"
/// language : "en"
/// mpa_rating : "R"
/// background_image : "https://yts.gg/assets/images/movies/Chaos_2005/background.jpg"
/// background_image_original : "https://yts.gg/assets/images/movies/Chaos_2005/background.jpg"
/// small_cover_image : "https://yts.gg/assets/images/movies/Chaos_2005/small-cover.jpg"
/// medium_cover_image : "https://yts.gg/assets/images/movies/Chaos_2005/medium-cover.jpg"
/// state : "ok"
/// torrents : [{"url":"https://yts.gg/torrent/download/CDED33F7FBF3E4E073778848FAD17674C0A35B82","hash":"CDED33F7FBF3E4E073778848FAD17674C0A35B82","quality":"720p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":16,"peers":0,"size":"809.06 MB","size_bytes":848360899,"date_uploaded":"2015-10-31 22:22:51","date_uploaded_unix":1446326571},{"url":"https://yts.gg/torrent/download/7569B45EA7F070575F44874F9BE259D4549FC50B","hash":"7569B45EA7F070575F44874F9BE259D4549FC50B","quality":"1080p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":28,"peers":6,"size":"1.96 GB","size_bytes":2104533975,"date_uploaded":"2022-05-07 14:38:18","date_uploaded_unix":1651927098}]
/// date_uploaded : "2015-10-31 22:22:51"
/// date_uploaded_unix : 1446326571

class Movies {
  Movies({
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
      this.summary, 
      this.descriptionFull, 
      this.synopsis, 
      this.ytTrailerCode, 
      this.language, 
      this.mpaRating, 
      this.backgroundImage, 
      this.backgroundImageOriginal, 
      this.smallCoverImage, 
      this.mediumCoverImage, 
      this.state, 
      this.torrents, 
      this.dateUploaded, 
      this.dateUploadedUnix,});

  Movies.fromJson(dynamic json) {
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
    summary = json['summary'];
    descriptionFull = json['description_full'];
    synopsis = json['synopsis'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    state = json['state'];
    if (json['torrents'] != null) {
      torrents = [];
      json['torrents'].forEach((v) {
        torrents?.add(Torrents.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? state;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

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
    map['summary'] = summary;
    map['description_full'] = descriptionFull;
    map['synopsis'] = synopsis;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['state'] = state;
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

}