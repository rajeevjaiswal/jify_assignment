import '../utils/constants.dart';

class ImagesRequestParams {
  final String apiKey;
  final String? query;
  final int page;
  final int pageSize;

  const ImagesRequestParams({
    this.apiKey = kApiKey,
    this.query,
    this.page = 1,
    this.pageSize = 20,
  });
}
