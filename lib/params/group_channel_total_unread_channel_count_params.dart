import 'package:sendbird_sdk/constant/enums.dart';

/// An object consists a set of parameters for group channel total unread
/// channel count.
class GroupChannelTotalUnreadChannelCountParams {
  /// List of channel custom types to be used as filter
  List<String> customTypes = [];

  /// The enumerator filter of super channel.
  SuperChannelFilter superChannelFilter = SuperChannelFilter.all;
}
