import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jify_assignment/src/core/params/image_request.dart';
import 'package:jify_assignment/src/core/resources/data_state.dart';
import 'package:jify_assignment/src/domain/entities/image.dart';
import 'package:jify_assignment/src/domain/usecases/get_images_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/bloc/bloc_with_state.dart';

part 'remote_images_event.dart';
part 'remote_images_state.dart';

class RemoteImagesBloc
    extends BlocWithState<RemoteImagesEvent, RemoteImagesState> {
  final GetImagesUseCase _getImagesUseCase;

  RemoteImagesBloc(this._getImagesUseCase) : super(const RemoteImagesInitial());

  final List<Image> _images = [];
  int _page = 1;
  static const int _pageSize = 20;

  @override
  Stream<Transition<RemoteImagesEvent, RemoteImagesState>> transformEvents(
    Stream<RemoteImagesEvent> events,
    Stream<Transition<RemoteImagesEvent, RemoteImagesState>> Function(
      RemoteImagesEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(transitionFn);
  }

  @override
  Stream<RemoteImagesState> mapEventToState(RemoteImagesEvent event) async* {
    if (event is GetImages) yield* _getRemoteImages(event);
  }

  Stream<RemoteImagesState> _getRemoteImages(GetImages event) async* {
    yield* runBlocProcess(() async* {
      if (event.query.isEmpty) {
        _images.clear();
        _page = 1;
        yield (const RemoteImagesInitial());
      } else {
        if (!event.isLoadMore) {
          yield (RemoteImagesLoading());
        } else {
          yield RemoteImagesDone(_images, false);
        }

        final dataState = await _getImagesUseCase(
            params: ImagesRequestParams(
          page: _page,
          query: event.query,
        ));
        if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
          final images = dataState.data;
          // final noMoreData = event.isLoadMore ? true : images!.length < _pageSize;

          final hasReachedEnd = true;
          if (event.isLoadMore) {
            _page++;
          } else {
            _images.clear();
            _page = 1;
          }

          if (!event.isLoadMore && images!.isEmpty) {
            yield RemoteImagesEmpty("No data found");
          } else {
            _images.addAll(images!);
            yield RemoteImagesDone(_images, hasReachedEnd);
          }
        } else {
          yield RemoteImagesEmpty("No data found");
        }
        if (dataState is DataFailed) {
          yield RemoteImagesError(dataState.error!);
        }
      }
    });
  }
}
