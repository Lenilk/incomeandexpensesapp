import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/component.dart';
import 'package:incomeandexpensesapp/function/function.dart';
import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:provider/provider.dart';

class DataBox extends StatefulWidget {
  final String type;
  final Note data;
  final int index;
  const DataBox(
      {Key? key, required this.type, required this.data, required this.index})
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
    bool isincome = widget.type == 'income';
    Note data = widget.data;
    String infoString = isincome ? 'รายรับ' : 'รายจ่าย';
    String date =
        Provider.of<Stater>(context, listen: false).selectDateString();
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (_) => DeletePage(data: data, date: date),
        );
      },
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => UpdatePage(
            data: data,
            date: date,
            index: widget.index,
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: isincome
            ? const Color.fromARGB(255, 123, 158, 218)
            : const Color.fromARGB(255, 243, 130, 130),
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Column(
          children: [
            textData('$infoString ${data.info}'),
            textData('จำนวน ${data.amount} บาท'),
            if (data.note != '') textData('หมายเหตุ ${data.note}'),
          ],
        )),
      ),
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
