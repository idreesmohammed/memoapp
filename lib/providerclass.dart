import 'package:flutter/widgets.dart';

class ProviderFunction extends ChangeNotifier {
  bool darkMode = false;
  nighModeFunction() {
    darkMode = !darkMode;
    notifyListeners();
  }
}
