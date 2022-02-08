// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sample_app/panda/button_view.dart';
import 'package:sample_app/panda/fab_button_view.dart';
import 'package:sample_app/panda/model.dart';

class PandaBar extends StatefulWidget {
  final Color? backgroundColor;
  final List<PandaBarButtonData>? buttonData;
  final Widget? fabIcon;

  final Color? buttonColor;
  final Color? buttonSelectedColor;
  final List<Color>? fabColors;

  final Function(dynamic selectedPage) onChange;
  final VoidCallback onFabButtonPressed;

  const PandaBar({
    Key? key,
    required this.buttonData,
    required this.onChange,
    this.backgroundColor,
    this.fabIcon,
    this.fabColors,
    required this.onFabButtonPressed,
    this.buttonColor,
    this.buttonSelectedColor,
  }) : super(key: key);

  @override
  _PandaBarState createState() => _PandaBarState();
}

class _PandaBarState extends State<PandaBar> {
  final double fabSize = 60;
  final Color unSelectedColor = Colors.grey;

  dynamic selectedId;

  @override
  void initState() {
    selectedId =
        widget.buttonData!.isNotEmpty ? widget.buttonData!.first.id : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clipper = _PandaBarClipper(fabSize: fabSize);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipPath(
          clipper: clipper,
          child: Container(
            height: 70,
            // padding: const EdgeInsets.symmetric(vertical: 10.0),
            color: widget.backgroundColor ?? const Color(0xFF222427),
            child: Builder(builder: (context) {
              List<Widget> leadingChildren = [];
              List<Widget> trailingChildren = [];
              widget.buttonData!.asMap().forEach((i, data) {
                Widget btn = PandaBarButton(
                  icon: data.icon,
                  title: data.title,
                  isSelected: data.id != null && selectedId == data.id,
                  unselectedColor: widget.buttonColor,
                  selectedColor: widget.buttonSelectedColor,
                  onTap: () {
                    setState(() {
                      selectedId = data.id;
                    });
                    widget.onChange(data.id);
                  },
                );

                if (i < 2) {
                  leadingChildren.add(btn);
                } else {
                  trailingChildren.add(btn);
                }
              });
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: leadingChildren,
                    ),
                  ),
                  Container(width: fabSize),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: trailingChildren,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        PandaBarFabButton(
          size: fabSize,
          icon: widget.fabIcon,
          onTap: widget.onFabButtonPressed,
          colors: widget.fabColors,
        ),
      ],
    );
  }
}

class _PandaBarClipper extends CustomClipper<Path> {
  final double fabSize;
  final double padding = 50;
  final double centerRadius = 15;
  final double cornerRadius = 5;

  _PandaBarClipper({required this.fabSize});

  @override
  Path getClip(Size size) {
    print('size');
    print(size.height);
    print(size.width);
    final xCenter = (size.width / 2);

    final fabSizeWithPadding = fabSize + padding;
/**
    Path path0 = Path();
    path0.moveTo(size.width * 0.9983000, size.height * 0.2457410);
    path0.lineTo(size.width, size.height * 1.0022446);
    path0.lineTo(0, size.height * 0.9962734);
    path0.lineTo(0, size.height * 0.2459568);
    path0.lineTo(size.width * 0.3679250, size.height * 0.2463165);
    // path0.quadraticBezierTo(size.width * 0.3830000, size.height * 0.7183165,
    //     size.width * 0.5073000, size.height * 0.7201007);
    // path0.quadraticBezierTo(size.width * 0.6307000, size.height * 0.7192950,
    //     size.width * 0.6217250, size.height * 0.2452230);
    path0.lineTo(size.width * 0.9983000, size.height * 0.2457410);
    path0.close();

    // Path path0 = Path();
    // path0.moveTo(size.width, size.height * 0.4333957);
    // path0.lineTo(size.width, size.height * 0.6465324);
    // path0.lineTo(0, size.height * 0.6483309);
    // path0.lineTo(0, size.height * 0.4334676);
    // path0.lineTo(size.width * 0.3750000, size.height * 0.4316547);
    // path0.quadraticBezierTo(size.width * 0.3773250, size.height * 0.5764460,
    //     size.width * 0.4985000, size.height * 0.5749353);
    // path0.quadraticBezierTo(size.width * 0.6280250, size.height * 0.5744892,
    //     size.width * 0.6225000, size.height * 0.4330935);
    // path0.lineTo(size.width, size.height * 0.4333957);
    // path0.close();
    */
    final path = Path();
    path.lineTo((xCenter - (fabSizeWithPadding / 2) - cornerRadius), 0);
    path.quadraticBezierTo(xCenter - (fabSizeWithPadding / 2), 0,
        (xCenter - (fabSizeWithPadding / 2)) + cornerRadius, cornerRadius);
    path.lineTo(
        xCenter - centerRadius, (fabSizeWithPadding / 2) - centerRadius);
    path.quadraticBezierTo(xCenter, (fabSizeWithPadding / 2),
        xCenter + centerRadius, (fabSizeWithPadding / 2) - centerRadius);
    path.lineTo(
        (xCenter + (fabSizeWithPadding / 2) - cornerRadius), cornerRadius);
    path.quadraticBezierTo(xCenter + (fabSizeWithPadding / 2), 0,
        (xCenter + (fabSizeWithPadding / 2) + cornerRadius), 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

// class _ClipShadowPainter extends CustomPainter {
//   final Shadow shadow;
//   final CustomClipper<Path> clipper;

//   _ClipShadowPainter({@required this.shadow, @required this.clipper});

//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = shadow.toPaint();
//     var clipPath = clipper.getClip(size).shift(shadow.offset);
//     canvas.drawPath(clipPath, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
