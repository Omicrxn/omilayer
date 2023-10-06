import 'package:flutter/widgets.dart';

/// {@template omilayer}
/// Flutter overlays elevated to the next level
/// {@endtemplate}

class OmiLayer extends StatefulWidget {
  /// {@macro omilayer}
  const OmiLayer(
      {super.key,
      required this.buildContent,
      this.initialPosition = const RelativeRect.fromLTRB(0, 0, 0, 0)});

  final RelativeRect initialPosition;
  final WidgetBuilder buildContent;

  @override
  State<OmiLayer> createState() => _OmiLayerState();
}

class _OmiLayerState extends State<OmiLayer> {
  double topOffset = 0.0;
  double leftOffset = 0.0;

  @override
  void initState() {
    super.initState();
    topOffset = widget.initialPosition.top;
    leftOffset = widget.initialPosition.left;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topOffset,
      left: leftOffset,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            topOffset += details.delta.dy;
            leftOffset += details.delta.dx;
          });
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF000000).withOpacity(0.2),  // Lower opacity for a softer shadow
                spreadRadius: 1,
                blurRadius: 15,  // Higher blur radius for a smoother shadow
                offset: Offset(0, 3),  // Vertical offset
              ),
            ],
          ),
          child: Builder(builder: widget.buildContent),
        ),
      ),
    );
  }
}

void showOmiLayer(
    {required BuildContext context,
    required WidgetBuilder buildContent,
    required RelativeRect position,
    AlignmentGeometry alignment = Alignment.center,
    bool isDraggable = false}) {
  final GlobalKey<_OmiLayerState> menuKey = GlobalKey();
  OverlayEntry? overlayEntry;
  overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          overlayEntry?.remove();
        },
        child: Stack(
          children: [
            OmiLayer(
                key: menuKey, initialPosition: position, buildContent: buildContent),
          ],
        ),
      ));
  Overlay.of(context).insert(overlayEntry);
}
