import 'package:flutter/widgets.dart';

class NoSpace extends SizedBox {
  ///Do not insert SizedBox
  ///
  /// ```dart
  /// Column(
  ///   children: [
  ///      Text("A"),
  ///      Text("B"),
  ///      NoSpace(),
  ///      Text("C"),
  ///   ].setSpace(height: 10),
  ///)
  ///```
  const NoSpace({Key? key}) : super(key: key);
}
