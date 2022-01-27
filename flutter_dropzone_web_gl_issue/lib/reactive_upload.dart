// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_dropzone_web_gl_issue/main.dart';

class ReactiveUpload extends StatefulWidget {
  const ReactiveUpload({
    Key? key,
  }) : super(key: key);

  @override
  _ReactiveUploadState createState() => _ReactiveUploadState();
}

class _ReactiveUploadState extends State {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.pink[100],
              height: 200,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.only(
                      top: 24 / 2,
                    ),
                    child: BorderRect(),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: FittedBox(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 24,
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          'widget.title',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  DropzoneViewTest(),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      top: 24,
                    ),
                    padding: EdgeInsetsDirectional.all(
                      4,
                    ),
                    alignment: AlignmentDirectional.center,
                    child: Text('blehhhh'),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 4),
              alignment: AlignmentDirectional.center,
              child: _FilePickerMessage(),
            ),
          ],
        ),
      ],
    );
  }
}

class _FilePickerMessage extends StatelessWidget {
  const _FilePickerMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload,
              size: 32,
            ),
            RichText(
              text: TextSpan(
                text: 'context.strings.commonFw_uploadFileBrowseAction',
                // ignore: prefer_const_literals_to_create_immutables
                children: <TextSpan>[
                  TextSpan(
                    text: 'message',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BorderRect extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double borderRadius;
  final double topLength;
  final bool centerTitle;

  const BorderRect({
    this.color = Colors.white,
    this.strokeWidth = 2,
    this.borderRadius = 16,
    this.topLength = 24,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsetsDirectional.all(strokeWidth / 2),
        child: CustomPaint(
          painter: RectPainter(
            topLength: topLength,
            borderRadius: borderRadius,
            color: color,
            strokeWidth: strokeWidth,
            centerTitle: centerTitle,
            direction: Directionality.of(context),
          ),
        ),
      ),
    );
  }
}

class RectPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double borderRadius;
  final double topLength;
  final bool centerTitle;
  final ui.TextDirection direction;

  RectPainter({
    this.topLength = 32,
    this.borderRadius = 24,
    this.strokeWidth = 2,
    this.color = Colors.white,
    this.centerTitle = true,
    this.direction = ui.TextDirection.ltr,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    var x = size.width;
    var y = size.height;

    var path = Path();
    var fixedTopLength = min(
      size.width - (borderRadius * 2) - (16 * 2),
      topLength,
    );

    // Moving the starting point to the initial part,
    // we consider the initial to be first point after the text clockwise
    // This point need to account RTL and LTR or if it is centered.
    if (centerTitle) {
      // CENTER CASE, Move to center plus half of the space
      path.moveTo((size.width / 2) + (fixedTopLength / 2), 0);
    } else if (direction == ui.TextDirection.ltr) {
      //LTR CASE, text to the left, gap right after
      path.moveTo(borderRadius + fixedTopLength - 4, 0);
    } else {
      //RTL CASE, text to the right, gap start at corner after
      path.moveTo(size.width - borderRadius - 4, 0);
    }

    //Draw first line, from starting position to top right corner
    path.lineTo(x - borderRadius, 0);

    //Draw top right corner
    path.arcToPoint(Offset(x, borderRadius),
        radius: Radius.circular(borderRadius));

    //Draw right line from top right corner to bottom right corner
    path.lineTo(x, y - borderRadius);

    //Draw bottom right corner
    path.arcToPoint(Offset(x - borderRadius, y),
        radius: Radius.circular(borderRadius));

    //Draw bottom line from bottom right corner to bottom left corner
    path.lineTo(0 + borderRadius, y);

    //Draw bottom left corner
    path.arcToPoint(Offset(0, y - borderRadius),
        radius: Radius.circular(borderRadius));

    //Draw left line from top left corner to bottom left corner
    path.lineTo(0, 0 + borderRadius);

    //Draw top left corner
    path.arcToPoint(Offset(0 + borderRadius, 0),
        radius: Radius.circular(borderRadius));

    // Drawing the end point,
    // we consider the end to be the point before the text clockwise
    // This point need to account RTL and LTR or if it is centered.
    if (centerTitle) {
      // CENTER CASE, Move to center minus half of the space
      path.lineTo((size.width / 2) - (fixedTopLength / 2), 0);
    } else if (direction == ui.TextDirection.ltr) {
      //RTL CASE, text to the right, gap before the text
      path.lineTo(16, 0);
    } else {
      //RTL CASE, text to the right, gap before the text
      path.lineTo(
        size.width - borderRadius - fixedTopLength + 4,
        0,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
