import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import './function/function.dart';

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
      home: const MyHomePage(),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
            child: Text(Provider.of<Stater>(context).selectDateString())),
      ),
      body: const Column(children: [Calender(), DataList()]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("${DateTime(2023)}");
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
