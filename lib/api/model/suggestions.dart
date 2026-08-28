import 'meta.dart';
import 'suggestions_data.dart';

class Suggestions {
  final String? status;
  final String? statusMessage;
  final SuggestionsData? data;
  final Meta? meta;

  const Suggestions({this.status, this.statusMessage, this.data, this.meta});

  factory Suggestions.fromJson(Map<String, dynamic> json) {
    return Suggestions(
      status: json['status'],
      statusMessage: json['status_message'],
      data: json['data'] != null
          ? SuggestionsData.fromJson(json['data'])
          : null,
      meta: json['@meta'] != null ? Meta.fromJson(json['@meta']) : null,
    );
  }
}
