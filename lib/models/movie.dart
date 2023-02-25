class Movie {
  String name;
  String time;
  double iMDb;
  int yearOfManufacture;
  String urlPhoto;
  List<String>? categories;
  bool isLiked;

  Movie(
      {required this.name,
      required this.time,
      this.iMDb = 0,
      this.yearOfManufacture = 0,
      this.urlPhoto = '',
        this.isLiked = false,
        this.categories});
  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    return Movie(
        name: parsedJson['name'] ?? '',
        time: parsedJson['time'] ?? '',
        iMDb: parsedJson['IMDb'] ?? '',
        yearOfManufacture: parsedJson['yearOfManufacture'] ?? '',
        urlPhoto: parsedJson['urlPhoto'] ?? '',
        categories: List<String>.from(parsedJson['favorite'] ?? ['']),
        isLiked: parsedJson['isLiked'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
      'IMDb': iMDb,
      'yearOfManufacture': yearOfManufacture,
      'urlPhoto': urlPhoto,
      'categories': categories,
      'isLiked': isLiked,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          time == other.time &&
          yearOfManufacture == other.yearOfManufacture;

  @override
  int get hashCode =>
      name.hashCode ^ time.hashCode ^ yearOfManufacture.hashCode;
}