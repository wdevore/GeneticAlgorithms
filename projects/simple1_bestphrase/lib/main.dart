import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'simulation.dart' as sim;

final AppState appState = AppState()..setup();
final sim.Simulation simulation = sim.Simulation(appState);

void main() {
  runApp(
    ChangeNotifierProvider.value(
      value: appState,
      child: const MyApp(),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genetic Algorithms',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'GA: Simple1 best phrase'),
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
  // Column
  //   left = fixed pos text, right = scrolling text
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            ElevatedButton(
              onPressed: () {
                appState.start();
                simulation.simulate();
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
                appState.stop();
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
        // A single Row with
        //
        // -----------------------------------------
        // |                       |               |
        // |                       |               |
        // |                       |               |
        // |                       |               |
        // | xxxxxx                |               |
        // | xxxxxx                |               |
        // | xxxxxx                |               |
        // -----------------------------------------
        body: Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              SizedBox(
                width: 400,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade400,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('line1'),
                      Text('line2'),
                    ],
                  ),
                ),
              ),
              const VerticalDivider(
                width: 10,
                thickness: 1,
                indent: 20,
                endIndent: 0,
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200),
                ),
              ),
            ],
          ),
        )
        // const Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: <Widget>[
        //      Text(
        //       'You have pushed the button this many times:',
        //     ),

        //   ],
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
