import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable(explicitToJson: true)
class Note {String info;
  int amount;
  String note;
  String type;
  Note(this.info,this.amount,this.note,this.type);

  factory Note.fromJson(Map<String, dynamic> json) =>
      _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}