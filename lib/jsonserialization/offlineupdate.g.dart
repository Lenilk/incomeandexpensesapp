// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offlineupdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfflineUpdateData _$OfflineUpdateDataFromJson(Map<String, dynamic> json) =>
    OfflineUpdateData(
      json['user'] as String,
      json['Date'] as String,
      Note.fromJson(json['Data'] as Map<String, dynamic>),
      Note.fromJson(json['OldData'] as Map<String, dynamic>),
      json['type'] as String,
    );

Map<String, dynamic> _$OfflineUpdateDataToJson(OfflineUpdateData instance) =>
    <String, dynamic>{
      'user': instance.user,
      'Date': instance.Date,
      'Data': instance.Data,
      'OldData': instance.OldData,
      'type': instance.type,
    };
