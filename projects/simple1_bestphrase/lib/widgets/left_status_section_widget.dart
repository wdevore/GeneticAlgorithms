import 'package:flutter/material.dart';

import '../app_state.dart';
import '../population.dart';

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
  const LeftStatusSectionWidget({super.key, required this.appState});

  final AppState appState;

  @override
  State<LeftStatusSectionWidget> createState() =>
      _LeftStatusSectionWidgetState();
}

class _LeftStatusSectionWidgetState extends State<LeftStatusSectionWidget> {
  @override
  Widget build(BuildContext context) {
    Population? pop = widget.appState.population;
    if (pop == null) {
      return SizedBox(
        width: 400,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade400,
          ),
        ),
      );
    }

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
            Text('Best phrase: "${pop.best}"'),
            Text('Total Generations: ${pop.generations}'),
            Text('Average fitness: ${pop.averageFitness}'),
            Text('Total population: ${widget.appState.popmax}'),
            Text('Mutation rate: ${widget.appState.mutationRate}'),
          ],
        ),
      ),
    );
  }
}
