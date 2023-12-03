// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfflineData _$OfflineDataFromJson(Map<String, dynamic> json) => OfflineData(
      json['user'] as String,
      json['Date'] as String,
      Note.fromJson(json['Data'] as Map<String, dynamic>),
      json['type'] as String,
    );

Map<String, dynamic> _$OfflineDataToJson(OfflineData instance) =>
    <String, dynamic>{
      'user': instance.user,
      'Date': instance.Date,
      'Data': instance.Data,
      'type': instance.type,
    };
