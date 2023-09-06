import 'package:flutter/material.dart';

class DataList extends StatelessWidget {
  final bool isAvailable;
  final List data;
  const DataList({Key? key, required this.isAvailable, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 0),
      child: isAvailable
          ? Column(children: [
              Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text("${data[index]["info"]}");
                    }),
              ),
            ])
          : const Center(
              child: Text("No data"),
            ),
    ));
  }
}
// class DataList extends StatelessWidget {
//   final bool isAvailable;
//   final List data;
//   const DataList({Key? key, required this.isAvailable, required this.data})
//       : super(key: key);

//   @override
//   State<DataList> createState() => _DataListState();
// }

// class _DataListState extends State<DataList> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: Padding(
//       padding: const EdgeInsets.only(top: 0),
//       child: widget.isAvailable
//           ? ListView.builder(
//               itemCount: widget.data.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Text("${widget.data[index]["info"]}");
//               })
//           : const Center(
//               child: Text("No data"),
//             ),
//     ));
//   }
// }
