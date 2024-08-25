import 'dart:math';

class TextListModel {
  List<String> lines = [];
  static const windowSize = 150;
  static const bufferSize = 150;

  // Indices range from 0 to lines.length().
  int indexStart = 0;
  int indexEnd = windowSize;

  TextListModel() {
    scrollToBottom();
  }

  void scrollToBottom() {
    indexStart = max(lines.length - windowSize, 0);
    indexEnd = lines.length;
  }

  void addLine(String text) {
    lines.add(text);
    if (lines.length > bufferSize) {
      lines.removeAt(0);
    }
    scrollToBottom();
  }

  void addLines(List<String> lineList) {
    lines.addAll(lineList);
    if (lines.length > bufferSize) {
      lines.removeRange(0, lines.length - bufferSize);
    }
    scrollToBottom();
  }

  // Scrolling up means incrementing the index only if there are more
  // lines of than could be visible in the view.
  void scrollUp() {
    // Increment indices which moves the window.
    if (indexEnd == lines.length) {
      return; // Can't move
    }
    indexStart++;
    indexEnd++;
  }

  void scrollDown() {
    // Decrement indices which moves the window
    if (indexStart == 0) {
      return; // Can't move
    }
    indexStart--;
    indexEnd--;
  }
}
