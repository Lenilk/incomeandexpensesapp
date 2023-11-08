// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      json['info'] as String,
      json['amount'] as int,
      json['note'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'info': instance.info,
      'amount': instance.amount,
      'note': instance.note,
      'type': instance.type,
    };
