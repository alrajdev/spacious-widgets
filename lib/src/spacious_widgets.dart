import 'package:flutter/widgets.dart';

import './utils.dart';
import './widget/child_space.dart';
import './widget/no_space.dart';

extension SpaciousChildren on List<Widget> {
  /// inserts SizedBox between every widget
  ///
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text("A"),
  ///     Text("B"),
  ///     Text("C"),
  ///   ].setSpace(height: 10)
  /// )
  /// ```
  ///
  /// instead of
  ///
  /// ```dart
  /// Column(
  ///   children: [
  ///     Text("A"),
  ///     SizedBox(height: 10),
  ///     Text("B"),
  ///     SizedBox(height: 10),
  ///     Text("C"),
  ///   ]
  /// )
  /// ```
  ///
  /// use [height] for Column, and [width] for Row
  ///
  /// [start] - insert SizedBox before first widget
  ///
  /// [end] - insert SizedBox after last widget
  ///
  /// To add SizedBox only at the start and end, set height/width to 0.0
  ///
  /// to adjust inserted SizedBox use [AdjustSpace] and [NoSpace]
  List<Widget> setSpace({
    final double? height,
    final double? width,
    final double? start,
    final double? end,
  }) {
    // return if empty
    if (isEmpty) return this;

    assert(!(height == null && width == null),
        "setSpace: Both height and width cannot be null");
    assert(!(height != null && width != null),
        "setSpace: Both height and width cannot have value");
    assert(!(height != null && height < 0.0),
        "setSpace: height cannot be negative");
    assert(
        !(width != null && width < 0.0), "setSpace: width cannot be negative");
    assert(
        !(start != null && start < 0.0), "setSpace: start cannot be negative");
    assert(!(end != null && end < 0.0), "setSpace: end cannot be negative");

    // pool for reusing SizedBox
    final pool = {
      // default SizedBox with no height/width adjustments
      0.0: SizedBox(
        height: height,
        width: width,
      )
    };

    // widgets with spaces inserted
    final spacedWidgets = [
      // start is set
      if (start != null)
        SizedBox(
          height: height?.other(start),
          width: width?.other(start),
        ),

      // always add first widget
      first
    ];

    // add SizedBox between widgets only if there are more than one widget
    // and only if either height or width is more than 0.0
    if (length > 1) {
      // adjustments from default height/width
      double adjustment = 0.0;

      // flag to ignore SizedBoxes when using NoSpace
      bool noSpace = false;

      // loop from the second widget
      for (final widget in sublist(1)) {
        // add SizedBox only if the previous widget is not NoSpace
        if (!noSpace) {
          // widget is for adjusting default height/width
          if (widget is AdjustSpace) {
            // overriding is set
            if (widget.override != null) {
              // calculate difference from default for reuse
              adjustment = height?.getOverrideAdjustment(widget.override!) ??
                  width!.getOverrideAdjustment(widget.override!);
            }
            // adjustment is set
            else {
              adjustment = widget.adjust!;
            }

            // don't add AdjustSpace, since it is only for setSpace
            continue;
          }

          // widget is for ignoring SizedBox
          else if (widget is NoSpace) {
            // flag for next loop to ignore next SizedBox too
            noSpace = true;

            // don't add NoSpace, since it is only for setSpace
            continue;
          }

          SizedBox? sizedBox;

          // pool has SizedBox
          if (pool.containsKey(adjustment)) {
            sizedBox = pool[adjustment];
          }
          // pool doesn't have SizedBox
          else {
            sizedBox = _getSizedBox(
              height: height,
              width: width,
              adjustment: adjustment,
            );
          }

          // we have a SizedBox for the space
          if (sizedBox != null) {
            // add SizedBox to pool
            pool[adjustment] = sizedBox;

            // add the SizedBox
            spacedWidgets.add(sizedBox);
          }
        }

        // add the widget
        spacedWidgets.add(widget);

        // reset adjustments and noSpace
        // so next SizedBox isn't affected
        adjustment = 0.0;
        noSpace = false;
      }
    }

    // end is set
    if (end != null) {
      spacedWidgets.add(
        SizedBox(
          height: height?.other(end),
          width: width?.other(end),
        ),
      );
    }

    return spacedWidgets;
  }

  /// returns SizedBox with adjusted height or width
  SizedBox? _getSizedBox({
    required double? height,
    required double? width,
    required double adjustment,
  }) {
    // calculate new height or width for adjustments
    final adjustedHeight =
        adjustment != 0.0 ? height?.positiveOrZero(adjustment) : 0.0;
    final adjustedWidth =
        adjustment != 0.0 ? width?.positiveOrZero(adjustment) : 0.0;

    // add SizedBox only if height or width is more than 0.0 after modification
    final toAdd = (adjustedHeight != null && adjustedHeight > 0.0) ||
        (adjustedWidth != null && adjustedWidth > 0.0);

    if (toAdd) {
      return SizedBox(
        height: adjustedHeight,
        width: adjustedWidth,
      );
    }
    return null;
  }
}
