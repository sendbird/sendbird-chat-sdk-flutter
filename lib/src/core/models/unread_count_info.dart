import 'package:json_annotation/json_annotation.dart';

part 'unread_count_info.g.dart';

@JsonSerializable()
class UnreadCountInfo {
  int all;
  Map<String, num> customTypes;
  int ts;

  UnreadCountInfo({this.all, this.customTypes, this.ts});

  bool copyWith(UnreadCountInfo others) {
    bool didChange = false;

    ts = others.ts;

    others.customTypes?.forEach((key, value) {
      final currValue = customTypes[key];
      if (currValue != value) {
        didChange = true;
        customTypes[key] = value;
      }
    });

    if (all != others.all) {
      didChange = true;
      all = others.all;
    }

    return didChange;
  }

  static UnreadCountInfo fromJson(Map<String, dynamic> json) =>
      _$UnreadCountInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UnreadCountInfoToJson(this);
}
