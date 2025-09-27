import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class PaintingCanvas extends StatefulWidget {
  final Color selectedColor;
  final double brushSize;

  const PaintingCanvas({
    super.key,
    required this.selectedColor,
    required this.brushSize,
  });

  @override
  State<PaintingCanvas> createState() => _PaintingCanvasState();
}

class _PaintingCanvasState extends State<PaintingCanvas> {
  List<DrawingPoint> _points = [];
  List<List<DrawingPoint>> _strokes = [];
  ui.Image? _backgroundImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: CanvasPainter(
            points: _points,
            strokes: _strokes,
            backgroundImage: _backgroundImage,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _points.add(DrawingPoint(
        point: details.localPosition,
        color: widget.selectedColor,
        size: widget.brushSize,
        timestamp: DateTime.now(),
      ));
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _points.add(DrawingPoint(
        point: details.localPosition,
        color: widget.selectedColor,
        size: widget.brushSize,
        timestamp: DateTime.now(),
      ));
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _strokes.add(List.from(_points));
      _points.clear();
    });
  }
}

class DrawingPoint {
  final Offset point;
  final Color color;
  final double size;
  final DateTime timestamp;

  DrawingPoint({
    required this.point,
    required this.color,
    required this.size,
    required this.timestamp,
  });
}

class CanvasPainter extends CustomPainter {
  final List<DrawingPoint> points;
  final List<List<DrawingPoint>> strokes;
  final ui.Image? backgroundImage;

  CanvasPainter({
    required this.points,
    required this.strokes,
    this.backgroundImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    final backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Draw decorative background pattern
    _drawBackgroundPattern(canvas, size);

    // Draw all completed strokes
    for (final stroke in strokes) {
      _drawStroke(canvas, stroke);
    }

    // Draw current stroke
    if (points.isNotEmpty) {
      _drawStroke(canvas, points);
    }
  }

  void _drawBackgroundPattern(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < size.width; i += 50) {
      for (int j = 0; j < size.height; j += 50) {
        canvas.drawCircle(
          Offset(i.toDouble(), j.toDouble()),
          1,
          paint,
        );
      }
    }
  }

  void _drawStroke(Canvas canvas, List<DrawingPoint> stroke) {
    if (stroke.length < 2) return;

    for (int i = 0; i < stroke.length - 1; i++) {
      final currentPoint = stroke[i];
      final nextPoint = stroke[i + 1];

      final paint = Paint()
        ..color = currentPoint.color
        ..strokeWidth = currentPoint.size
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      // Create smooth curves between points
      final controlPoint1 = Offset(
        currentPoint.point.dx + (nextPoint.point.dx - currentPoint.point.dx) / 3,
        currentPoint.point.dy + (nextPoint.point.dy - currentPoint.point.dy) / 3,
      );

      final controlPoint2 = Offset(
        currentPoint.point.dx + 2 * (nextPoint.point.dx - currentPoint.point.dx) / 3,
        currentPoint.point.dy + 2 * (nextPoint.point.dy - currentPoint.point.dy) / 3,
      );

      final path = Path();
      path.moveTo(currentPoint.point.dx, currentPoint.point.dy);
      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        nextPoint.point.dx,
        nextPoint.point.dy,
      );

      canvas.drawPath(path, paint);

      // Add brush texture effect
      _drawBrushTexture(canvas, currentPoint);
    }
  }

  void _drawBrushTexture(Canvas canvas, DrawingPoint point) {
    final random = math.Random(point.timestamp.millisecondsSinceEpoch);
    final paint = Paint()
      ..color = point.color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 3; i++) {
      final offset = Offset(
        point.point.dx + (random.nextDouble() - 0.5) * point.size,
        point.point.dy + (random.nextDouble() - 0.5) * point.size,
      );
      canvas.drawCircle(offset, point.size * 0.3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
