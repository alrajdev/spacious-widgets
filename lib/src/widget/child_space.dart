import 'package:flutter/widgets.dart';

class AdjustSpace extends SizedBox {
  ///adjustment value for default setSpace height/width
  final double? adjust;

  ///override value for default setSpace height/width
  final double? override;

  ///Adjustments for setSpace's height/width
  ///
  /// ```dart
  /// Column(
  ///   children: [
  ///      Text("A"),
  ///      AdjustSpace(adjust: 5), // increase 5 in height/width
  ///      Text("B"),
  ///      AdjustSpace(adjust: -5), // decrease 5 in height/width
  ///      Text("C"),
  ///      AdjustSpace(override: 5), // overrides the height/width
  ///      Text("C"),
  ///   ].setSpace(height: 10),
  ///)
  ///```
  const AdjustSpace({this.override, this.adjust, Key? key})
      : assert(adjust != null || override != null,
            "Both adjust and override cannot be null"),
        assert(adjust == null || override == null,
            "Both adjust and override cannot have value"),
        assert(
            override == null || override >= 0.0, "override cannot be negative"),
        super(key: key);
}
