import 'package:jify_assignment/src/core/params/image_request.dart';
import 'package:jify_assignment/src/core/resources/data_state.dart';
import 'package:jify_assignment/src/core/usecase/usecase.dart';
import 'package:jify_assignment/src/domain/entities/image.dart';
import 'package:jify_assignment/src/domain/repositories/images_repository.dart';

class GetImagesUseCase
    implements UseCase<DataState<List<Image>>, ImagesRequestParams> {
  final ImagesRepository _imagesRepository;

  GetImagesUseCase(this._imagesRepository);

  @override
  Future<DataState<List<Image>>> call({ImagesRequestParams? params}) {
    return _imagesRepository.getImages(params: params!);
  }
}
