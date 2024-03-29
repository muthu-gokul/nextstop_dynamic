import 'package:flutter/widgets.dart';
import '../arc/arc_clipper.dart';
import '../arc/clip_shadow.dart';
import '../arc/edge.dart';
export '../arc/arc_clipper.dart' show ArcType;
export '../arc/clip_shadow.dart' show ClipShadow;

class Arc extends StatelessWidget {
  const Arc(
      {
        required this.height,
        required this.child,
        this.edge = Edge.BOTTOM,
        this.arcType = ArcType.CONVEX,
        this.clipShadows = const []});

  /// The widget which one of [edge]s is going to be clippddddded as arc
  final Widget child;

  ///The height of the arc
  final double height;

  ///The edge of the widget which clipped as arc
  final Edge edge;

  ///The type of arc which can be [ArcType.CONVEX] or [ArcType.CONVEY]
  final ArcType arcType;

  ///List of shadows to be cast on the border
  final List<ClipShadow> clipShadows;

  @override
  Widget build(BuildContext context) {
    var clipper = ArcClipper(height, edge, arcType);
    return CustomPaint(
      painter: ClipShadowPainter(clipper, clipShadows),
      child: ClipPath(
        clipper: clipper,
        child: child,
      ),
    );
  }
}
