import 'package:flutter/foundation.dart';

class ExampleModel with ChangeNotifier {
  String value = "Example";

  @override
  String toString() {
    return value;
  }
}
