import 'package:dio/dio.dart';
import 'package:movies_app/api/model/Suggestions.dart';

class DioManager {
  static final Dio dio = Dio();

  // https://movies-api.accel.li/api/v2/movie_suggestions.json?movie_id=10


   static Future<Suggestions?> getSuggestionMovies(int movieId) async {
     try{
       var response = await dio.get('https://movies-api.accel.li/api/v2/movie_suggestions.json',
           queryParameters: {
             'movie_id' : '50'
           }
       );
       return Suggestions.fromJson(response.data);
     }
     on DioException catch(e) {
       String errorMessage = "Something went wrong";
       switch (e.type) {

         case DioExceptionType.connectionTimeout:
           errorMessage = 'Connection timeout. Server took too long to respond.';
           break;

         case DioExceptionType.sendTimeout:
           errorMessage = 'Send timeout in connection with API server.';
           break;

         case DioExceptionType.receiveTimeout:
           errorMessage = 'Receive timeout in connection with API server.';
           break;
         case DioExceptionType.badResponse:
           errorMessage ='Bad response status code: ${e.response?.statusCode}';
           break;
         case DioExceptionType.connectionError:
           errorMessage = 'No internet connection or network unavailable.';
           break;
         case DioExceptionType.cancel:
           errorMessage = 'Request to API server was cancelled.';
           break;
         default:
           errorMessage = 'Unexpected error occurred: ${e.message}';
           break;
       }
     throw errorMessage ;
   }

   }
}