import 'package:flutter/material.dart';

import 'widgets/bloops_painter_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Continous Evolution',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Continous Evolution Bloops'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          ElevatedButton(
            onPressed: () {
              // gaSim.configure();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade50,
              foregroundColor: const Color.fromARGB(255, 104, 58, 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Tooltip(
              message: 'Configure Algorithm for simulation',
              child: Text('Configure'),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              // gaSim.start();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade50,
              foregroundColor: const Color.fromARGB(255, 104, 58, 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Tooltip(
              message: 'Start Algorithm',
              child: Text('Start'),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              // gaSim.stop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade50,
              foregroundColor: const Color.fromARGB(255, 104, 58, 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Tooltip(
              message: 'Stop Algorithm',
              child: Text('Stop'),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: <Widget>[
          BloopsPainterWidget(
              height: 500, width: 1000, bgColor: Colors.lime.shade100),
          // Container(
          //   height: 500,
          //   width: 1000,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.black),
          //     color: Colors.blueGrey.shade50,
          //   ),
          //   child: const Center(
          //     child: Text(
          //       'Custom graphics',
          //     ),
          //   ),
          // ),
          const Divider(
            height: 0,
            thickness: 1,
            indent: 10,
            endIndent: 10,
            color: Colors.grey,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: AlignmentDirectional.topStart,
              color: Colors.amber.shade50,
              child: const Text('Status'),
            ),
          ),
        ],
      ),
    );
  }
}
