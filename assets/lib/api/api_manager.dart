import 'package:dio/dio.dart';
import 'package:movies_app/api/api_constants.dart';
import 'package:movies_app/api/end_point.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/api/model/movies_response.dart';

class ApiManager {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  static Future<Response> _retryRequest(
    Future<Response> Function() request,
  ) async {
    int retries = 3;

    while (true) {
      try {
        return await request();
      } on DioException catch (e) {
        if (e.type != DioExceptionType.connectionTimeout &&
            e.type != DioExceptionType.sendTimeout &&
            e.type != DioExceptionType.receiveTimeout &&
            e.type != DioExceptionType.connectionError) {
          throw Exception(handleDioError(e));
        }

        retries--;

        if (retries == 0) {
          throw Exception(handleDioError(e));
        }

        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  static Future<MoviesResponse> getMovies({
    int limit = 10,
    int page = 1,
    String? genre,
    String? sortBy,
    String orderBy = 'desc',
  }) async {
    final response = await _retryRequest(
      () => dio.get(
        EndPoint.moviesApi,
        queryParameters: {
          'limit': limit,
          'page': page,
          if (genre != null) 'genre': genre,
          if (sortBy != null) 'sort_by': sortBy,
          'order_by': orderBy,
        },
      ),
    );

    return MoviesResponse.fromJson(response.data['data']);
  }

  static Future<List<String>> getGenres() async {
    try {
      final Set<String> genres = {};

      const int limit = 20;
      const int maxPages = 20;

      for (int page = 1; page <= maxPages; page++) {
        final response = await getMovies(limit: limit, page: page);

        for (final movie in response.movies) {
          genres.addAll(movie.genres);
        }

        final totalPages = ((response.movieCount) / limit).ceil();

        if (page >= totalPages) {
          break;
        }
      }

      final List<String> genreList = genres.toList();
      genreList.sort();

      return genreList;
    } on DioException catch (e) {
      throw Exception(handleDioError(e));
    } catch (e) {
      rethrow;
    }
  }

  static Future<Movie> getMovieDetails(int movieId) async {
    final response = await _retryRequest(
      () => dio.get(
        EndPoint.moviesDetailsApi,
        queryParameters: {
          'movie_id': movieId,
          'with_images': true,
          'with_cast': true,
        },
      ),
    );

    return Movie.fromJson(response.data['data']['movie']);
  }

  static Future<List<Movie>> getSuggestionMovies(int movieId) async {
    final response = await _retryRequest(
      () => dio.get(
        EndPoint.suggestionApi,
        queryParameters: {'movie_id': movieId},
      ),
    );

    final movies = response.data['data']['movies'] as List;

    return movies.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<List<Movie>> searchMovie(String query) async {
    final response = await _retryRequest(
      () => dio.get(
        EndPoint.moviesApi,
        queryParameters: {
          'query_term': query.trim(),
          'sort_by': 'download_count',
          'limit': 30,
        },
      ),
    );

    final List moviesList = response.data['data']['movies'] ?? [];

    return moviesList.map((e) => Movie.fromJson(e)).toList();
  }

  static String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'connection_timeout';

      case DioExceptionType.connectionError:
        return 'no_internet_connection';

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;

        if (statusCode == 404) {
          return 'data_not_found';
        }

        if (statusCode != null && statusCode >= 500) {
          return 'server_error';
        }

        return 'server_response_error';

      case DioExceptionType.cancel:
        return 'request_cancelled';

      default:
        return 'network_error';
    }
  }
}
