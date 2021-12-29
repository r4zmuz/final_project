

class ImageModel {
  final String id;
  final String author;
  final String thumb;
  final String url;

  ImageModel(
      {required this.id,
        required this.author,
        required this.thumb,
        required this.url});

  factory ImageModel.fromJSON(Map<String, dynamic> json) {
    return ImageModel(
        id: json['id'],
        author: json['user']['name'],
        thumb: json['urls']['thumb'],
        url: json['urls']['raw']);
  }

  @override
  String toString() {
    return 'ImageModel{id: $id, author: $author, thumb: $thumb, url: $url}';
  }
}
