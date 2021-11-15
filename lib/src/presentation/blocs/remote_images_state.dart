part of 'remote_images_bloc.dart';

abstract class RemoteImagesState extends Equatable {
  const RemoteImagesState();

  @override
  List<Object> get props => [];
}

class RemoteImagesLoading extends RemoteImagesState {
  const RemoteImagesLoading() : super();
}

class RemoteImagesInitial extends RemoteImagesState {
  const RemoteImagesInitial() : super();
}

class RemoteImagesDone extends RemoteImagesState {
  final List<Image> images;
  final bool noMoreData;
  const RemoteImagesDone(this.images, this.noMoreData);

  @override
  List<Object> get props => [images, noMoreData];

  @override
  String toString() => 'SearchStateSuccess { items: ${images.length} }';
}

class RemoteImagesError extends RemoteImagesState {
  final DioError error;

  const RemoteImagesError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Search Error  ${error.message}';
}

class RemoteImagesEmpty extends RemoteImagesState {
  final String message;

  const RemoteImagesEmpty(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'message  ${message}';
}
