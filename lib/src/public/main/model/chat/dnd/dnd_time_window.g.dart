// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dnd_time_window.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DndTimeWindow _$DndTimeWindowFromJson(Map<String, dynamic> json) =>
    DndTimeWindow(
      startHour: (json['start_hour'] as num).toInt(),
      startMin: (json['start_min'] as num).toInt(),
      endHour: (json['end_hour'] as num).toInt(),
      endMin: (json['end_min'] as num).toInt(),
    );

Map<String, dynamic> _$DndTimeWindowToJson(DndTimeWindow instance) =>
    <String, dynamic>{
      'start_hour': instance.startHour,
      'start_min': instance.startMin,
      'end_hour': instance.endHour,
      'end_min': instance.endMin,
    };
