import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProgressBarRenderObject extends RenderBox {
  ProgressBarRenderObject({
    required Color dotColor,
    required Color filedDotColor,
    required Color thumbColor,
    required double thumbHeight,
    required double initialThumbValue,
  }) {
    _dotColor = dotColor;
    _filedDotColor = filedDotColor;
    _thumbColor = thumbColor;
    _thumbHeight = thumbHeight;
    _currentThumbValue = initialThumbValue;

    _drag = HorizontalDragGestureRecognizer()
      ..onStart = (DragStartDetails details) {
        _updateThumbPosition(details.localPosition);
      }
      ..onUpdate = (DragUpdateDetails details) {
        _updateThumbPosition(details.localPosition);
      };
  }

  late Color _dotColor;
  late Color _filedDotColor;
  late Color _thumbColor;
  late double _thumbHeight;
  late double _currentThumbValue;
  late HorizontalDragGestureRecognizer _drag;

  Color get dotColor => _dotColor;
  set dotColor(Color value) {
    if (value == _dotColor) {
      return;
    }
    _dotColor = value;

    markNeedsPaint();
  }

  Color get filedDotColor => _filedDotColor;
  set filedDotColor(Color value) {
    if (value == _filedDotColor) {
      return;
    }
    _filedDotColor = value;

    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;
  set thumbColor(Color value) {
    if (value == _thumbColor) {
      return;
    }
    _thumbColor = value;

    markNeedsPaint();
  }

  double get thumbHeight => _thumbHeight;
  set thumbHeight(double value) {
    if (value == _thumbHeight) {
      return;
    }
    _thumbHeight = value;

    markNeedsPaint();
  }

  @override
  void performLayout() {
    final double desiredWidth = constraints.maxWidth;
    final double desiredHeight = thumbHeight;
    final Size desiredSize = Size(desiredWidth, desiredHeight);

    size = constraints.constrain(desiredSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    // Paint dots
    final Paint dotPaint = Paint()
      ..color = dotColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    final Paint barPaint = Paint()
      ..color = filedDotColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    final double spacing = size.width / 10;
    for (int i = 0; i < 11; i++) {
      Offset upperPoint = Offset(spacing * i, size.height * 0.75);
      final Offset loverPoint = Offset(spacing * i, size.height);

      if (i % 5 == 0) {
        upperPoint = Offset(spacing * i, size.height * 0.25);
      }

      if (upperPoint.dx <= _currentThumbValue * size.width) {
        canvas.drawLine(upperPoint, loverPoint, barPaint);
      } else {
        canvas.drawLine(upperPoint, loverPoint, dotPaint);
      }
    }

    // Set thumb
    final Paint thumbPaint = Paint()..color = thumbColor;
    final double thumbDx = _currentThumbValue * size.width;

    // Draw the bar from left to thumb position
    final Offset point1 = Offset(0, size.height / 2);
    final Offset point2 = Offset(thumbDx, size.height / 2);
    canvas.drawLine(point1, point2, barPaint);

    // Paint thumb
    final Offset center = Offset(thumbDx, size.height / 2);
    canvas.drawCircle(center, thumbHeight / 2, thumbPaint);

    canvas.restore();
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag.addPointer(event);
    }
  }

  void _updateThumbPosition(Offset localPosition) {
    // Clamp the position between the full width of the RenderObject
    // to avoid f you drag the mouse of the window
    final num dx = localPosition.dx.clamp(0, size.width);

    // Make the size between 0 and 1 with only 1 decimal
    // example 0.4 or 0.7
    _currentThumbValue = double.parse((dx / size.width).toStringAsFixed(1));

    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }
}
