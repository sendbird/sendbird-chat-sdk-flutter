/// Abstract class for query
abstract class QueryBase {
  /// True if query is loading
  bool loading = false;

  /// True if query has next items to be queried
  bool hasNext = true;

  /// token for next query
  String? token;

  /// number of item per executing [loadNext]
  int limit = 20;

  /// Load next items asynchronously
  Future<List> loadNext();
}
