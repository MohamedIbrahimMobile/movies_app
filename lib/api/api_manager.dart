import 'package:dio/dio.dart';
import 'package:movies_app/api/model/api_constants.dart';
import 'package:movies_app/api/model/movie_details/Movie_details_response.dart';

class ApiManager {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://movies-api.accel.li/api/v2',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    )
  );
  static Future<MovieDetailsResponse?> getMovieDetails(int movieId) async {
    try {
      final response =await dio.get(
        '/movie_details.json',
        queryParameters: {
          'movie_id': movieId,
          'with_images': true,
          'with_cast': true,
        },
      );
      if(response.statusCode==200){
        return MovieDetailsResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('Dio error: $e');
      return null;
    }
  }
}
