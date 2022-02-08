import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String text;
  final bool? isNetwork;
  final double? width;
  final EdgeInsetsGeometry? margin;

  const ErrorText(
      {Key? key, required this.text, this.isNetwork, this.width, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isNetwork!
        ? SafeArea(child: Scaffold(body: _builContainer(context)))
        : _builContainer(context);
  }

  _builContainer(BuildContext context) {
    return Container(
      height: width ?? double.infinity,
      width: width ?? double.infinity,
      margin: margin ?? const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: width! * 0.75,
            height: width! * 0.75,
            child: Image.asset(
              isNetwork!
                  ? 'assets/images/network_error.jpg'
                  : 'assets/images/userError.png',
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
