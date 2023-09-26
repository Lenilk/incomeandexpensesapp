import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './function/function.dart';
import './function/extension.dart';
import 'component/component.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Stater()),
      ],
      child: const MyApp(),
    ),
  );
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
      home: const MediaQuery(
        data: MediaQueryData(textScaleFactor: 1.0),
        child: MyHomePage(),
      ),
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
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = context.watch<Stater>().data;
    String selectDateINData =
        Provider.of<Stater>(context, listen: true).selectDateString();
    int whereday = whereDateInData(selectDateINData, context);
    bool isDayAvailable = isSelectDayAvailablefn(selectDateINData, context);
    List datalist = isDayAvailable ? data[whereday]["data"] : [];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
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
        Datalist(
          data: datalist,
          isAvailable: isDayAvailable,
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const ChoicePage(),
          );
          debugPrint(whereDateInData(selectDateINData, context).toString());
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
