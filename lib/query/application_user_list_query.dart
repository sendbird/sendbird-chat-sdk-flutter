part of 'user_list_query.dart';

/// A query object to retrieve list of user on current application.
@JsonSerializable()
class ApplicationUserListQuery extends UserListQuery {
  /// The meta data key filter. This query will return users
  /// that has the meta data key and values
  String metaDataKey;

  /// The meta data values filter. This query will return users
  /// that has the meta data key and values
  List<String> metaDataValues;

  ApplicationUserListQuery({
    this.metaDataKey,
    this.metaDataValues,
  }) : super(queryType: UserListQueryType.filtered);

  @override
  Future<List<User>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;
    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.getUsers(
      token: token,
      limit: limit,
      userIds: userIds,
      metaDataKey: metaDataKey,
      metaDataValues: metaDataValues,
    );

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.users;
  }

  // Json Serialization
  Map<String, dynamic> toJson() => _$ApplicationUserListQueryToJson(this);
}
