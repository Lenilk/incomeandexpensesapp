import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:incomeandexpensesapp/component/conclusionbar.dart';
import 'package:incomeandexpensesapp/jsonserialization/data.dart';
import 'package:incomeandexpensesapp/jsonserialization/note.dart';
import 'package:provider/provider.dart';
import './function/function.dart';
import './function/extension.dart';
import 'component/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Stater()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MediaQuery(
              data: const MediaQueryData(textScaleFactor: 1.0),
              child: MyHomePage(key: UniqueKey()),
            ),
        '/dashboard': (context) => MediaQuery(
              data: const MediaQueryData(textScaleFactor: 1.0),
              child: DashBoardPage(
                key: UniqueKey(),
              ),
            ),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool onStart = true;
  List<Data> dataS = [];
  List<String> dateMark = [];
  Future getData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? jsonString = pref.getString('Data11');
    String? jsonStringDM = pref.getString('Date11Dm');
    List<Data> dataL = (jsonString != null)
        ? (json.decode(jsonString) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((e) => Data.fromJson(e))
            .toList()
        : [];
    List<dynamic> dataLDM =
        (jsonStringDM != null) ? json.decode(jsonStringDM)['datemark'] : [];
    debugPrint(dataL.toString());
    debugPrint(dataLDM.toString());
    if (dataL != []) {
      //type '_Map<String, dynamic>' is not a subtype of type 'Map<String, String>
      // ignore: unnecessary_cast
      debugPrint(dataL.toString());
      setState(() {
        dataS = dataL;
      });
    }
    if (dataLDM != []) {
      //type '_Map<String, dynamic>' is not a subtype of type 'Map<String, String>
      // ignore: unnecessary_cast
      List<String> data = dataLDM.map((e) => e as String).toList();
      debugPrint(data.toString());
      setState(() {
        dateMark = data;
      });
    }
    // pref.setString("Data1", json.encode([{"meaw":1234}]));
    // String? testS = pref.getString("Data1");
    // debugPrint(testS.toString());
    // debugPrint(json.decode(testS!)[0]["meaw"].toString());
  }

  @override
  void initState() {
    super.initState();
    getData().then((e) => Provider.of<Stater>(context, listen: false)
        .initSetData(dataS, dateMark));
  }

  @override
  Widget build(BuildContext context) {
    // if(onStart){
    // Provider.of<Stater>(context,listen: false).initSetData(dataS);
    // setState(() {
    //   onStart=false;
    // });
    // }
    List<Data> data = context.watch<Stater>().data;
    String selectDateINData =
        Provider.of<Stater>(context, listen: true).selectDateString();
    int whereday = whereDateInData(selectDateINData, context);
    bool isDayAvailable = isSelectDayAvailablefn(selectDateINData, context);
    List<Note> datalist = isDayAvailable ? data[whereday].data : [];
    int incomeamt = context.watch<Stater>().incomeAmount();
    int expensamt = context.watch<Stater>().expensAmount();
    bool isSelectMonthAvailable =
        context.watch<Stater>().isSelectMonthAvailable();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Text(
            Provider.of<Stater>(context).selectDateTitle(),
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: Column(children: [
        const Calender(),
        if (isDayAvailable)
          ConclusionBar(
            incomeamt: incomeamt,
            expensamt: expensamt,
            key: UniqueKey(),
          ),
        if (isDayAvailable)
          Datalist(
            key: UniqueKey(),
            data: datalist,
          )
        else
          const Expanded(
            child: Center(
              child: Text('ไม่มีรายการ'),
            ),
          ),
      ]),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isSelectMonthAvailable)
            FloatingActionButton(
              key: UniqueKey(),
              heroTag: 'dashboard',
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              tooltip: 'DashBoard',
              child: const Icon(Icons.assessment_outlined),
            ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => ChoicePage(
                  key: UniqueKey(),
                ),
              );
              debugPrint(whereDateInData(selectDateINData, context).toString());
            },
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
