import 'dart:math';

import 'package:flutter/material.dart';

import '../app_state.dart';
import '../population.dart';
import '../text_list_model.dart';
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
  const RightPhrasesSectionWidget({super.key, required this.appState});

  final AppState appState;

  @override
  State<RightPhrasesSectionWidget> createState() =>
      _RightPhrasesSectionWidgetState();
}

class _RightPhrasesSectionWidgetState extends State<RightPhrasesSectionWidget> {
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

    List<String> phrases = pop.phraseSubset;
    widget.appState.textListModel.lines.clear();
    for (String phrase in phrases) {
      widget.appState.textListModel.addLine(phrase);
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade400,
      ),
      child: TextScrollingWidget(model: widget.appState.textListModel),
    );
  }
}
