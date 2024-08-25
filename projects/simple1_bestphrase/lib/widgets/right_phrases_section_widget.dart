import 'package:flutter/material.dart';

import '../ga_simulation.dart';
import '../model/text_list_model.dart';
import 'text_scrolling_widget.dart';

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
class RightPhrasesSectionWidget extends StatefulWidget {
  const RightPhrasesSectionWidget({super.key, required this.simulation});

  final GASimulation simulation;

  @override
  State<RightPhrasesSectionWidget> createState() =>
      _RightPhrasesSectionWidgetState();
}

class _RightPhrasesSectionWidgetState extends State<RightPhrasesSectionWidget> {
  @override
  Widget build(BuildContext context) {
    TextListModel phrases = widget.simulation.textListModel;

    if (phrases.lines.isEmpty) {
      return SizedBox(
        width: 400,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber.shade50,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade400,
      ),
      child: TextScrollingWidget(model: phrases),
    );
  }
}
