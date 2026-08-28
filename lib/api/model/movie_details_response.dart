import 'meta.dart';
import 'movie_details_data.dart';

class MovieDetailsResponse {
  final String? status;
  final String? statusMessage;
  final MovieDetailsData? data;
  final Meta? meta;

  const MovieDetailsResponse({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailsResponse(
      status: json['status'],
      statusMessage: json['status_message'],
      data: json['data'] != null
          ? MovieDetailsData.fromJson(json['data'])
          : null,
      meta: json['@meta'] != null ? Meta.fromJson(json['@meta']) : null,
    );
  }
}
