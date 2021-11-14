import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final int id;
  final String tags;
  final int views;
  final int downloads;
  final int likes;
  final int comments;
  final String previewUrl;
  final String imageUrl;

  const Image({
    required this.id,
    required this.tags,
    required this.views,
    required this.downloads,
    required this.likes,
    required this.comments,
    required this.previewUrl,
    required this.imageUrl,
  });

  @override
  List<Object> get props {
    return [
      id,
      tags,
      views,
      downloads,
      likes,
      comments,
      previewUrl,
      imageUrl,
    ];
  }

  @override
  bool get stringify => true;
}
