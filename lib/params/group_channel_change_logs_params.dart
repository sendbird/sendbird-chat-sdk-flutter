/// An object consists a set of parameters for group channel change logs
class GroupChannelChangeLogsParams {
  /// Sets the custom types filter.
  /// The property filters channels which have one of custom types.
  List<String> customTypes = [];

  /// Determines whether to include members property in each channel.
  bool includeMemberList = true;

  /// Determines whether to include the empty channels in the results.
  bool includeEmptyChannel = false;

  /// Determines whether to include the frozen channels in the results.
  bool includeFrozenChannel = false;

  Map<String, dynamic> toJson() {
    return {
      'custom_type': customTypes,
      'show_member': includeMemberList,
      'show_empty': includeEmptyChannel,
      'show_frozen': includeFrozenChannel,
    };
  }
}
