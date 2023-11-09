import 'package:json_annotation/json_annotation.dart';
import './note.dart';
part 'data.g.dart';

@JsonSerializable(explicitToJson: true)
class Data {
  List<Note> data;
  // ignore: non_constant_identifier_names
  String Date;
  Data(this.Date,this.data);

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}