import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ga_simulation.dart';
import 'widgets/left_status_section_widget.dart';
import 'widgets/right_phrases_section_widget.dart';

void main() async {
  // final AppState appState = AppState.create()..setup();
  final GASimulation gaSimulation = GASimulation();
  await gaSimulation.initialize();

  runApp(
    ChangeNotifierProvider.value(
      value: gaSimulation,
      child: const MyApp(),
    ),
  );
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
    GASimulation gaSim = context.read<GASimulation>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          ElevatedButton(
            onPressed: () {
              gaSim.configure();
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
              gaSim.start();
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
              gaSim.stop();
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
          ElevatedButton(
            onPressed: () {
              gaSim.exit();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: const Color.fromARGB(255, 104, 58, 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Tooltip(
              message: 'Exit Sim Isolate',
              child: Text('Exit Isolate'),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Consumer<GASimulation>(
        builder: (BuildContext context, GASimulation value, Widget? child) {
          return Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                LeftStatusSectionWidget(simulation: value),
                const VerticalDivider(
                  width: 10,
                  thickness: 1,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.grey,
                ),
                Expanded(
                  child: RightPhrasesSectionWidget(simulation: value),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
