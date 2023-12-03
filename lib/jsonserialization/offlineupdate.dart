import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offlineupdate.g.dart';

@JsonSerializable()
class OfflineUpdateData {
  String user;
  String Date;
  Note Data;
  Note OldData;
  String type;
  OfflineUpdateData(this.user, this.Date, this.Data, this.OldData, this.type);

  factory OfflineUpdateData.fromJson(Map<String, dynamic> json) =>
      _$OfflineUpdateDataFromJson(json);
  Map<String, dynamic> toJson() => _$OfflineUpdateDataToJson(this);
}
