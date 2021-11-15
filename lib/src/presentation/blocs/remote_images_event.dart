part of 'remote_images_bloc.dart';

abstract class RemoteImagesEvent extends Equatable {
  const RemoteImagesEvent();

  @override
  List<Object> get props => [];
}

class GetImages extends RemoteImagesEvent {
  final String query;
  final bool isLoadMore;
  const GetImages(this.query, {this.isLoadMore = false});

  @override
  List<Object> get props => [query, isLoadMore];
}
