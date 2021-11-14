import '../utils/constants.dart';

class ArticlesRequestParams {
  final String apiKey;
  final String? query;
  final int page;
  final int pageSize;

  const ArticlesRequestParams({
    this.apiKey = kApiKey,
    this.query,
    this.page = 1,
    this.pageSize = 20,
  });
}
