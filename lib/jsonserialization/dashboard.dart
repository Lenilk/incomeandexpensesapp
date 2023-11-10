import 'package:incomeandexpensesapp/jsonserialization/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard.g.dart';

@JsonSerializable()
class DashBoard {
  String title;
  List<Data> data;
  int income;
  int expens;
  int total;
  DashBoard(this.title, this.data, this.income, this.expens, this.total);

  factory DashBoard.fromJson(Map<String, dynamic> json) =>
      _$DashBoardFromJson(json);
  Map<String, dynamic> toJson() => _$DashBoardToJson(this);
}
