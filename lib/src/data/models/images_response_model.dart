import 'package:jify_assignment/src/data/models/image_model.dart';

class ImagesResponseModel {
  final int total;
  final int totalHits;
  final List<ImageModel> images;

  ImagesResponseModel({
    required this.total,
    required this.totalHits,
    required this.images,
  });

  factory ImagesResponseModel.fromJson(Map<String, dynamic> json) {
    return ImagesResponseModel(
      total: json['total'] as int,
      totalHits: json['totalHits'] as int,
      images: List<ImageModel>.from(
        (json['hits'] as List<dynamic>).map(
          (e) => ImageModel.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );
  }
}
