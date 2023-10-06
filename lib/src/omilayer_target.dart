import 'package:flutter/widgets.dart';
import 'package:omilayer/omilayer.dart';

class OmiLayerTarget extends StatelessWidget {
  OmiLayerTarget({super.key, required this.buildContent, required this.child});

  final Widget child;
  final WidgetBuilder buildContent;
  final GlobalKey _targetKey = GlobalKey();

  void _showOmiLayer(BuildContext context) {
    final renderBox =
        _targetKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final RenderBox overlayBox =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final overlaySize = overlayBox.size; // overlay size
    showOmiLayer(
      context: context,
      buildContent: buildContent,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        overlaySize.width - (offset.dx + size.width),
        overlaySize.height - (offset.dy + size.height),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _targetKey,
      onTap: () {
        _showOmiLayer(context);
      },
      child: child,
    );
  }
}
