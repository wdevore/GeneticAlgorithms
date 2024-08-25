import 'package:flutter/material.dart';

import '../model/text_list_model.dart';

class TextScrollingWidget extends StatefulWidget {
  const TextScrollingWidget({super.key, required this.model});

  final TextListModel model;

  @override
  State<TextScrollingWidget> createState() => _TextScrollingWidgetState();
}

class _TextScrollingWidgetState extends State<TextScrollingWidget> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextListModel model = widget.model;
    Iterable<String> lines =
        model.lines.getRange(model.indexStart, model.indexEnd);

    controller.text = lines.join('\n');

    return TextField(
      controller: controller,
      maxLines: TextListModel.windowSize,
    );
  }
}
