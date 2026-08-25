import 'package:dio/dio.dart';
import 'package:movies_app/api/end_point.dart';
import 'package:movies_app/api/model/movies.dart';
import 'package:movies_app/api/model/Suggestions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioManager {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://movies-api.accel.li',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )
    ..interceptors.add(
      PrettyDioLogger(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );

/*
  https://movies-api.accel.li/api/v2/movie_details.json?movie_id=15&with_images=true
*/

  Future<Movies> getMovies(int movieId) async {
    try {
      final response = await dio.get(
        EndPoint.moviesApi,
        queryParameters: {
          'movie_id': movieId,
          'with_images': 'true',
        },
      );

      if (response.data is Map<String, dynamic>) {
        return Movies.fromJson(response.data);
      } else {
        throw Exception('Invalid response from the server.');
      }
    } on DioException catch (e) {
      throw Exception(handleDioError(e));
    } catch (e) {
      rethrow;
    }
  }

  // https://movies-api.accel.li/api/v2/movie_suggestions.json?movie_id=10

  Future<Suggestions?> getSuggestionMovies(int movieId) async {
    try {
      final response = await dio.get(
        'https://movies-api.accel.li/api/v2/movie_suggestions.json',
        queryParameters: {
          'movie_id': movieId,
        },
      );

      return Suggestions.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(handleDioError(e));
    } catch (e) {
      rethrow;
    }
  }

  String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The connection to the server timed out.';

      case DioExceptionType.connectionError:
        return 'No internet connection.';

      case DioExceptionType.badResponse:
        return 'Server response error (${error.response?.statusCode})';

      case DioExceptionType.cancel:
        return 'Request to API server was cancelled.';

      default:
        return 'A network connection error occurred.';
    }
  }
}