import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jify_assignment/src/core/params/image_request.dart';
import 'package:jify_assignment/src/core/resources/data_state.dart';
import 'package:jify_assignment/src/data/datasources/remote/images_api_service.dart';
import 'package:jify_assignment/src/domain/entities/image.dart';
import 'package:jify_assignment/src/domain/repositories/images_repository.dart';

class ImagesRepositoryImpl implements ImagesRepository {
  final ImagesApiService _imagesApiService;

  const ImagesRepositoryImpl(this._imagesApiService);

  @override
  Future<DataState<List<Image>>> getImages({
    required ImagesRequestParams params,
  }) async {
    try {
      final httpResponse = await _imagesApiService.getImagesArticles(
        apiKey: params.apiKey!,
        query: params.query!,
        page: params.page,
        pageSize: params.pageSize,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.images);
      }
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioErrorType.response,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioError catch (e) {
      print("error ${e.toString()}");
      return DataFailed(e);
    }
  }
}
