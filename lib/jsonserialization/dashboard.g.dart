// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashBoard _$DashBoardFromJson(Map<String, dynamic> json) => DashBoard(
      json['title'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['income'] as int,
      json['expens'] as int,
      json['total'] as int,
    );

Map<String, dynamic> _$DashBoardToJson(DashBoard instance) => <String, dynamic>{
      'title': instance.title,
      'data': instance.data,
      'income': instance.income,
      'expens': instance.expens,
      'total': instance.total,
    };
