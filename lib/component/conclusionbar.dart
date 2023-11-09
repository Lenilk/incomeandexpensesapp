import 'package:flutter/material.dart';

class ConclusionBar extends StatelessWidget {
  final int incomeamt;
  final int expensamt;
  const ConclusionBar(
      {Key? key, required this.incomeamt, required this.expensamt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: Container(
            color: const Color.fromARGB(255, 243, 130, 130),
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Text(
              'รายจ่าย $expensamt บาท',
              overflow: TextOverflow.ellipsis,
            ))),
      ),
      Expanded(
        child: Container(
            color: const Color.fromARGB(255, 123, 158, 218),
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Text(
              'รายรับ $incomeamt บาท',
              overflow: TextOverflow.ellipsis,
            ))),
      )
    ]);
  }
}
