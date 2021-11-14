import 'package:dio/dio.dart';
import 'package:jify_assignment/src/data/models/images_response_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/constants.dart';

part 'images_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class ImagesApiService {
  factory ImagesApiService(Dio dio, {String baseUrl}) = _ImagesApiService;

  @GET('/api/')
  Future<HttpResponse<ImagesResponseModel>> getImagesArticles({
    @Query("key") required String apiKey,
    @Query("q") required String query,
    @Query("page") required int page,
    @Query("per_page") required int pageSize,
  });
}
