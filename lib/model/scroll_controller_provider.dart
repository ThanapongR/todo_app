import 'package:flutter/material.dart';

class ScrollControllerProvider extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  double _savedScrollOffset = 0.0;

  ScrollController get scrollController => _scrollController;

  void saveScrollOffset() {
    _savedScrollOffset = scrollController.offset;
  }

  void restoreScrollOffset() {
    _scrollController.jumpTo(_savedScrollOffset);
  }

  void resetScrollOffset() {
    _savedScrollOffset = 0;
    _scrollController.jumpTo(_savedScrollOffset);
  }

  void addScrollListener(VoidCallback listener) {
    scrollController.addListener(listener);
  }
}
