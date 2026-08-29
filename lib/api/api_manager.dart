import 'package:dio/dio.dart';
import 'package:movies_app/api/api_constants.dart';
import 'package:movies_app/api/end_point.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/api/model/movie_details_response.dart';
import 'package:movies_app/api/model/suggestions.dart';

class ApiManager {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  static Future<List<Movie>> getMovies({
    int limit = 10,
    String? genre,
    String? sortBy,
    String orderBy = 'desc',
  }) async {
    try {
      final response = await dio.get(
        EndPoint.moviesApi,
        queryParameters: {
          'limit': limit,
          if (genre != null) 'genre': genre,
          if (sortBy != null) 'sort_by': sortBy,
          'order_by': orderBy,
        },
      );

      final movies = response.data['data']['movies'] as List;

      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } on DioException catch (e) {
      throw Exception(handleDioError(e));
    } catch (e) {
      rethrow;
    }
  }

  static Future<MovieDetailsResponse?> getMovieDetails(int movieId) async {
    try {
      final response = await dio.get(
        EndPoint.moviesDetailsApi,
        queryParameters: {
          'movie_id': movieId,
          'with_images': true,
          'with_cast': true,
        },
      );

      if (response.statusCode == 200) {
        return MovieDetailsResponse.fromJson(response.data);
      }

      return null;
    } on DioException catch (e) {
      throw Exception(handleDioError(e));
    } catch (e) {
      rethrow;
    }
  }

  static Future<Suggestions?> getSuggestionMovies(int movieId) async {
    try {
      final response = await dio.get(
        EndPoint.suggestionApi,
        queryParameters: {'movie_id': movieId},
      );

      return Suggestions.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(handleDioError(e));
    } catch (e) {
      rethrow;
    }
  }

  static String handleDioError(DioException error) {
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

   static Future<List<Movie>> searchMovie(String query) async {
    try {
      final response = await dio.get(
        EndPoint.moviesApi,
        queryParameters: {
          'query_term': query.trim(),
          'sort_by': 'download_count',
          'limit': 30,
        },
      );

      final List moviesList = response.data?['data']?['movies'] ?? [];
      return moviesList.map((e) => Movie.fromJson(e)).toList();

    } on DioException catch (e) {
      throw Exception(handleDioError(e));
    } catch (e) {
      rethrow;
    }
  }

}
