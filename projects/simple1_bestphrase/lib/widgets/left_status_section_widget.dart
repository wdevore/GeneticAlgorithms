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

    final TextEditingController phraseController = TextEditingController()
      ..text = widget.simulation.target;
    final TextEditingController popmaxController = TextEditingController()
      ..text = widget.simulation.popmax.toString();
    final TextEditingController mutRateController = TextEditingController()
      ..text = widget.simulation.mutationRate.toString();

    return SizedBox(
      width: 600,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade400,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Best phrase achieved: "${sim.best}"'),
            Text('Total Generations: ${sim.generations}'),
            Text('Average fitness: ${sim.averageFitness}'),
            Row(
              children: [
                const Text('Target phrase: '),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: phraseController,
                      onChanged: (String value) {
                        widget.simulation.target = value;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.amber.shade50,
                          filled: true,
                          constraints:
                              const BoxConstraints.tightFor(height: 40),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          hintText: 'Enter a target phrase'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Population Max: '),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: popmaxController,
                      onChanged: (String value) {
                        widget.simulation.popmax = int.parse(value);
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.amber.shade50,
                          filled: true,
                          constraints:
                              const BoxConstraints.tightFor(height: 40),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          hintText: 'Enter an integer max population'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Mutation Rate: '),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: mutRateController,
                      onChanged: (String value) {
                        widget.simulation.mutationRate = double.parse(value);
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.amber.shade50,
                          filled: true,
                          constraints:
                              const BoxConstraints.tightFor(height: 40),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          hintText: 'Enter an float Mutation Rate'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
