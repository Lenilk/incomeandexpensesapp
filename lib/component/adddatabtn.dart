import 'package:flutter/material.dart';

class AddDataBtn extends StatefulWidget {
  const AddDataBtn({super.key});

  @override
  State<AddDataBtn> createState() => _AddDataBtnState();
}

class _AddDataBtnState extends State<AddDataBtn> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {}, tooltip: 'Add', child: const Icon(Icons.add));
  }
}
