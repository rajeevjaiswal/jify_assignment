import '../../core/params/image_request.dart';
import '../../core/resources/data_state.dart';
import '../entities/image.dart';

abstract class ImagesRepository {
  Future<DataState<List<Image>>> getImages(
      {required ImagesRequestParams params});
}
