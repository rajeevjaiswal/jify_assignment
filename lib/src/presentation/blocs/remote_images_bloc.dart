import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:jify_assignment/src/core/params/image_request.dart';
import 'package:jify_assignment/src/core/resources/data_state.dart';
import 'package:jify_assignment/src/domain/entities/image.dart';
import 'package:jify_assignment/src/domain/usecases/get_images_usecase.dart';

import '../../core/bloc/bloc_with_state.dart';

part 'remote_images_event.dart';
part 'remote_images_state.dart';

class RemoteImagesBloc
    extends BlocWithState<RemoteImagesEvent, RemoteImagesState> {
  final GetImagesUseCase _getImagesUseCase;

  RemoteImagesBloc(this._getImagesUseCase) : super(const RemoteImagesLoading());

  final List<Image> _images = [];
  int _page = 1;
  static const int _pageSize = 20;

  @override
  Stream<RemoteImagesState> mapEventToState(RemoteImagesEvent event) async* {
    if (event is GetImages) yield* _getRemoteImages(event);
  }

  Stream<RemoteImagesState> _getRemoteImages(RemoteImagesEvent event) async* {
    yield* runBlocProcess(() async* {
      final dataState =
          await _getImagesUseCase(params: ImagesRequestParams(page: _page));

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        final images = dataState.data;
        final noMoreData = images!.length < _pageSize;
        _images.addAll(images);
        _page++;

        yield RemoteImagesDone(_images, noMoreData: noMoreData);
      }
      if (dataState is DataFailed) {
        yield RemoteImagesError(dataState.error!);
      }
    });
  }
}
