import '../constant/enums.dart';

/// An object consists a set of parameters for group channel total unread
///  message count.
class GroupChannelTotalUnreadMessageCountParams {
  /// List of channel custom types to be used as filter
  List<String> customTypes;

  /// The enumerator filter of super channel.
  GroupChannelSuperChannelFilter superChannelFilter =
      GroupChannelSuperChannelFilter.all;
}
