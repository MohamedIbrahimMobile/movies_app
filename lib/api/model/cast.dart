class Cast {
  final String? name;
  final String? characterName;
  final String? urlSmallImage;
  final String? imdbCode;

  const Cast({
    this.name,
    this.characterName,
    this.urlSmallImage,
    this.imdbCode,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'],
      characterName: json['character_name'],
      urlSmallImage: json['url_small_image'],
      imdbCode: json['imdb_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'character_name': characterName,
      'url_small_image': urlSmallImage,
      'imdb_code': imdbCode,
    };
  }
}
