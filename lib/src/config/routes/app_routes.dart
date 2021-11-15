import 'package:flutter/material.dart';
import 'package:jify_assignment/src/domain/entities/image.dart' as im;
import 'package:jify_assignment/src/presentation/views/gallery_view.dart';
import 'package:jify_assignment/src/presentation/views/image_view.dart';

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(GalleryView());
      case '/ImageDetailView':
        return _materialRoute(ImageView(image: settings.arguments as im.Image));
      default:
        return null;
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
