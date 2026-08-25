import 'Data.dart';
import 'meta.dart';

/// status : "ok"
/// status_message : "Query was successful"
/// data : {"movie":{"id":10,"url":"https://yts.gg/movies/13-2010","imdb_code":"tt0798817","title":"13","title_english":"13","title_long":"13 (2010)","slug":"13-2010","year":2010,"rating":6,"runtime":91,"genres":["Action","Crime","Drama","Thriller"],"like_count":79,"description_intro":"A desperate man takes part in an underworld game of Russian roulette.","description_full":"A desperate man takes part in an underworld game of Russian roulette.","yt_trailer_code":"Y41fFj-P4jI","language":"en","mpa_rating":"R","background_image":"https://yts.gg/assets/images/movies/13_2010/background.jpg","background_image_original":"https://yts.gg/assets/images/movies/13_2010/background.jpg","small_cover_image":"https://yts.gg/assets/images/movies/13_2010/small-cover.jpg","medium_cover_image":"https://yts.gg/assets/images/movies/13_2010/medium-cover.jpg","large_cover_image":"https://yts.gg/assets/images/movies/13_2010/large-cover.jpg","medium_screenshot_image1":"https://yts.gg/assets/images/movies/13_2010/medium-screenshot1.jpg","medium_screenshot_image2":"https://yts.gg/assets/images/movies/13_2010/medium-screenshot2.jpg","medium_screenshot_image3":"https://yts.gg/assets/images/movies/13_2010/medium-screenshot3.jpg","large_screenshot_image1":"https://yts.gg/assets/images/movies/13_2010/large-screenshot1.jpg","large_screenshot_image2":"https://yts.gg/assets/images/movies/13_2010/large-screenshot2.jpg","large_screenshot_image3":"https://yts.gg/assets/images/movies/13_2010/large-screenshot3.jpg","cast":[{"name":"Jason Statham","character_name":"Jasper","url_small_image":"https://yts.gg/assets/images/actors/thumb/nm0005458.jpg","imdb_code":"0005458"},{"name":"Emmanuelle Chriqui","character_name":"Aileen","url_small_image":"https://yts.gg/assets/images/actors/thumb/nm0004825.jpg","imdb_code":"0004825"},{"name":"Charles Pendelton","character_name":"Gambler","url_small_image":"https://yts.gg/assets/images/actors/thumb/nm1154281.jpg","imdb_code":"1154281"},{"name":"Michael Shannon","character_name":"Henry","url_small_image":"https://yts.gg/assets/images/actors/thumb/nm0788335.jpg","imdb_code":"0788335"}],"torrents":[{"url":"https://yts.gg/torrent/download/BE046ED20B048C4FB86E15838DD69DADB27C5E8A","hash":"BE046ED20B048C4FB86E15838DD69DADB27C5E8A","quality":"720p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":6,"peers":3,"size":"946.49 MB","size_bytes":992466698,"date_uploaded":"2015-10-31 20:46:37","date_uploaded_unix":1446320797},{"url":"https://yts.gg/torrent/download/FEE33A702158CD451220BD4F23FC46AD7BC65C4D","hash":"FEE33A702158CD451220BD4F23FC46AD7BC65C4D","quality":"1080p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":28,"peers":9,"size":"1.79 GB","size_bytes":1921997865,"date_uploaded":"2022-01-19 00:57:56","date_uploaded_unix":1642550276}],"date_uploaded":"2015-10-31 20:46:37","date_uploaded_unix":1446320797}}
/// @meta : {"api_version":2,"execution_time":"0 ms"}

class MovieDetailsResponse {
  MovieDetailsResponse({
      this.status, 
      this.statusMessage, 
      this.data, 
      this.meta,});

  MovieDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? Meta.fromJson(json['@meta']) : null;
  }
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (meta != null) {
      map['@meta'] = meta?.toJson();
    }
    return map;
  }

}