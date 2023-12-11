import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_bar/src/features/home_screen/widget/progress_bar_render_object.dart';

class ProgressBar extends LeafRenderObjectWidget {
  const ProgressBar({
    super.key,
    required this.dotColor,
    required this.filedDotColor,
    required this.thumbColor,
    required this.thumbHeight,
    this.initialThumbValue = 0.0,
  });

  final Color dotColor;
  final Color filedDotColor;
  final Color thumbColor;
  final double thumbHeight;
  final double initialThumbValue;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      ProgressBarRenderObject(
        dotColor: dotColor,
        filedDotColor: filedDotColor,
        thumbColor: thumbColor,
        thumbHeight: thumbHeight,
        initialThumbValue: initialThumbValue,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant ProgressBarRenderObject renderObject,
  ) {
    renderObject
      ..dotColor = dotColor
      ..filedDotColor = filedDotColor
      ..thumbColor = thumbColor
      ..thumbHeight = thumbHeight;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(ColorProperty('dotColor', dotColor));
    properties.add(ColorProperty('filedDotColor', filedDotColor));
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(DoubleProperty('thumbHeight', thumbHeight));
    properties.add(DoubleProperty('initialThumbValue', initialThumbValue));
  }
}
