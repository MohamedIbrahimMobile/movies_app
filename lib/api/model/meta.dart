class Meta {
  final int? apiVersion;
  final String? executionTime;

  const Meta({this.apiVersion, this.executionTime});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      apiVersion: json['api_version'],
      executionTime: json['execution_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'api_version': apiVersion, 'execution_time': executionTime};
  }
}
