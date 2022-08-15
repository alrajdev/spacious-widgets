import 'package:flutter/material.dart';
import 'package:spacious_widgets/spacious_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spacious Children example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Spacious Children example'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  Widget item(int i) {
    return Container(
      color: Colors.green.shade700,
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          i.toString(),
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // start adds SizedBox here
            item(1),
            item(2),
            const AdjustSpace(
                adjust: 5), // increase 5 to the given height/width
            item(3),
            const AdjustSpace(
                adjust: -5), // decrease 5 to the given height/width
            item(4),
            const NoSpace(), // add no SizedBox here
            item(5),
            const AdjustSpace(
                override: 15), // override the given height/width with 15
            item(6),
            item(7),
            item(8),
            item(9),
            item(10),
            // end adds SizedBox here
          ].setSpace(start: 15, height: 10, end: 15), // use width for Row
        ),
      ),
    );
  }
}
