import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jify_assignment/src/domain/entities/image.dart' as im;
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  final im.Image image;

  const ImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(
          image.imageUrl,
        ),
      ),
    );
  }
}
