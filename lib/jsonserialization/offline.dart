import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offline.g.dart';

@JsonSerializable()
class OfflineData {
  String user;
  String Date;
  Note Data;
  String type;
  OfflineData(this.user, this.Date, this.Data, this.type);

  factory OfflineData.fromJson(Map<String, dynamic> json) =>
      _$OfflineDataFromJson(json);
  Map<String, dynamic> toJson() => _$OfflineDataToJson(this);
}
