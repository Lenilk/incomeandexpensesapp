import 'package:flutter/material.dart';

class DataBox extends StatefulWidget {
  final String type;
  final Map<String, String> data;
  const DataBox({Key? key, required this.type, required this.data})
      : super(key: key);
  @override
  State<DataBox> createState() => _DataBoxState();
}

class _DataBoxState extends State<DataBox> {
  Widget textData(String data) {
    return Text(
      data,
      style: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isincome = widget.type == "income";
    Map<String, String> data = widget.data;
    String infoString = isincome ? "รายรับ" : "รายจ่าย";
    return Container(
      width: MediaQuery.of(context).size.width,
      color: isincome ? Colors.blueAccent : Colors.redAccent,
      padding: const EdgeInsets.all(10),
      child: Center(
          child: Column(
        children: [
          textData("$infoString ${data["info"]}"),
          textData("จำนวน ${data["amount"]} บาท"),
          if (data["note"] != "") textData("หมายเหตุ ${data["note"]}"),
        ],
      )),
    );
  }
}
// class DataBox extends StatelessWidget {
//   final String type;
//   final Map<String, String> data;
  
//   const DataBox({Key? key, required this.type, required this.data})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isIncome = type == "income" ? true : false;
//     return SizedBox(
//       width: context.size!.width,
//       height: context.size!.height * 0.3,
//       child: Text(data["info"].toString()),
//     );
//   }
// }
