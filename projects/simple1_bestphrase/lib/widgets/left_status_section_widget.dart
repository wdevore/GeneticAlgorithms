import 'package:flutter/material.dart';

import '../ga_simulation.dart';

// -----------------------------------------
// | xxxxxx                |lkajlfkgjalfds |
// | xxxxxx                |cxz.,ncoicxwld |
// | xxxxxx                |zxopghzpnwe.fg |
// |                       |               |
// |                       |               |
// |                       |               |
// |                       |               |
// -----------------------------------------
//          LEFT              RIGHT
class LeftStatusSectionWidget extends StatefulWidget {
  const LeftStatusSectionWidget({super.key, required this.simulation});

  final GASimulation simulation;

  @override
  State<LeftStatusSectionWidget> createState() =>
      _LeftStatusSectionWidgetState();
}

class _LeftStatusSectionWidgetState extends State<LeftStatusSectionWidget> {
  @override
  Widget build(BuildContext context) {
    GASimulation sim = widget.simulation;

    // Population? pop = widget.appState.population;
    // if (pop == null) {
    //   return SizedBox(
    //     width: 400,
    //     child: Container(
    //       padding: const EdgeInsets.all(10),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //         color: Colors.grey.shade400,
    //       ),
    //     ),
    //   );
    // }

    return SizedBox(
      width: 400,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade400,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Best phrase: "${sim.best}"'),
            Text('Total Generations: ${sim.generations}'),
            Text('Average fitness: ${sim.averageFitness}'),
            Text('Total population: ${sim.popmax}'),
            Text('Mutation rate: ${sim.mutationRate}'),
          ],
        ),
      ),
    );
  }
}
