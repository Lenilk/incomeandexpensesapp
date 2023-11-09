import 'package:flutter/material.dart';

class ConclusionBar extends StatelessWidget {
  final int incomeamt;
  final int expensamt;
  const ConclusionBar(
      {Key? key, required this.incomeamt, required this.expensamt})
      : super(key: key);
  Widget textData(String data) {
    return Text(
      data,
      style: const TextStyle(color: Colors.white),
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: Container(
            color: Colors.redAccent,
            padding: const EdgeInsets.all(10),
            child: Center(
                child: textData(
              'รายจ่าย $expensamt บาท',
            ))),
      ),
      Expanded(
        child: Container(
            color: Colors.blueAccent,
            padding: const EdgeInsets.all(10),
            child: Center(
                child: textData(
              'รายรับ $incomeamt บาท',
            ))),
      )
    ]);
  }
}
