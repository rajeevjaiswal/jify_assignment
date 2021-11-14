part of 'remote_images_bloc.dart';

abstract class RemoteImagesState extends Equatable {
  final List<Image>? images;
  final bool? noMoreData;

  final DioError? error;

  const RemoteImagesState({this.images, this.noMoreData, this.error});

  @override
  List<Object> get props => [images!, noMoreData!, error!];
}

class RemoteImagesLoading extends RemoteImagesState {
  const RemoteImagesLoading() : super();
}

class RemoteImagesDone extends RemoteImagesState {
  const RemoteImagesDone(List<Image> images, {bool? noMoreData})
      : super(images: images, noMoreData: noMoreData);
}

class RemoteImagesError extends RemoteImagesState {
  const RemoteImagesError(DioError error) : super(error: error);
}
