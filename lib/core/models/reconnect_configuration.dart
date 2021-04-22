import 'package:json_annotation/json_annotation.dart';

part 'reconnect_configuration.g.dart';

@JsonSerializable()
class ReconnectConfiguration {
  @JsonKey(name: 'interval')
  double interval;

  @JsonKey(name: 'max_interval')
  double maxInterval;

  @JsonKey(name: 'mul')
  int multiplier;

  @JsonKey(name: 'retry_cnt')
  int maximumRetryCount;

  bool get enabledInfinitelyRetry => maximumRetryCount < 0;

  ReconnectConfiguration({
    this.interval,
    this.maxInterval,
    this.multiplier,
    this.maximumRetryCount,
  });

  factory ReconnectConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ReconnectConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$ReconnectConfigurationToJson(this);
}
