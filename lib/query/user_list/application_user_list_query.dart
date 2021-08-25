part of 'user_list_query.dart';

/// A query object to retrieve list of user on current application.
@JsonSerializable()
class ApplicationUserListQuery extends UserListQuery {
  /// Filters users who have this meta data key.
  ///
  /// This query will return users that has the meta data key and values
  /// This should be specified in conjunction with the metaDataValues.
  String? metaDataKey;

  /// Filters users who have this meta data values.
  ///
  /// This query will return users that has the meta data key and values
  /// This should be specified in conjunction with the metaDataKey.
  List<String>? metaDataValues;

  /// Filters users whose nicknames start with the this value
  String? nicknameStartsWith;

  ApplicationUserListQuery({
    this.metaDataKey,
    this.metaDataValues,
    this.nicknameStartsWith,
  }) : super(queryType: UserListQueryType.filtered);

  @override
  Future<List<User>> loadNext() async {
    if (loading) throw QueryInProgressError();
    if (!hasNext) return [];

    loading = true;

    final sdk = SendbirdSdk().getInternal();
    final res = await sdk.api.send<UserListQueryResponse>(
      ApplicationUserListRequest(
        token: token,
        limit: limit,
        userIds: userIds,
        metaDataKey: metaDataKey,
        metaDataValues: metaDataValues,
        nicknameStartsWith: nicknameStartsWith,
      ),
    );

    loading = false;
    token = res.next;
    hasNext = res.next != '';
    return res.users;
  }

  // Json Serialization
  @override
  Map<String, dynamic> toJson() => _$ApplicationUserListQueryToJson(this);
}
