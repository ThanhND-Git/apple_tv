class Channel {
  String name;
  String describe;
  int numberOfChannels;
  String imageUrl;
  bool isLiked;

  Channel(
      {required this.name,
      required this.describe,
         this.imageUrl = '',
       this.numberOfChannels = 0,
        this.isLiked = false,
      });
  factory Channel.fromJson(Map<String, dynamic> parsedJson) {
    return Channel(
        name: parsedJson['name'] ?? '',
        describe: parsedJson['describe'] ?? '',
        numberOfChannels: parsedJson['numberOfChannels'] ?? '',
      imageUrl: parsedJson['imageUrl'] ?? '',
        isLiked: parsedJson['isLiked'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'describe': describe,
      'numberOfChannels': numberOfChannels,
      'imageUrl': imageUrl,
      'isLiked': isLiked,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Channel &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}