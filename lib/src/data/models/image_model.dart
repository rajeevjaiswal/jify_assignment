import 'package:jify_assignment/src/domain/entities/image.dart';

class ImageModel extends Image {
  const ImageModel({
    required int id,
    required String tags,
    required int views,
    required int downloads,
    required int likes,
    required int comments,
    required String previewUrl,
    required String imageUrl,
  }) : super(
            id: id,
            tags: tags,
            views: views,
            downloads: downloads,
            likes: likes,
            comments: comments,
            previewUrl: previewUrl,
            imageUrl: imageUrl);

  factory ImageModel.fromJson(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] as int,
      tags: map['tags'] as String,
      views: map['views'] as int,
      downloads: map['downloads'] as int,
      likes: map['likes'] as int,
      comments: map['comments'] as int,
      previewUrl: map['previewUrl'] as String,
      imageUrl: map['largeImageURL'] as String,
    );
  }
}
