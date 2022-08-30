import 'package:app_muevete/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String? label;
  final double roundness;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final Widget? trailingWidget;
  final Function? onPressed;

  const AppButton({
    Key? key,
    this.label,
    this.roundness = 50,
    this.fontWeight = FontWeight.bold,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
    this.trailingWidget,
    this.onPressed,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: () {
          if (widget.onPressed != null) {
            widget.onPressed?.call();
          }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        textColor: Colors.white,
        elevation: 10.0,
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[800]!, Color.fromARGB(255, 120, 113, 10)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
          child: Container(
            width: double.maxFinite,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_circle_right_outlined),
                const SizedBox(width: 10.0),
                Text(
                  widget.label ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: widget.fontWeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: RaisedButton(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.roundness),
        ),
        color: AppColors.primary,
        textColor: Colors.white,
        elevation: 5.0,
        padding: widget.padding,
        child: Stack(
          fit: StackFit.passthrough,          
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_circle_right_outlined),
                  const SizedBox(width: 10.0),
                  Text(
                    widget.label ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: widget.fontWeight,
                    ),
                  ),
                ],
              ),
            ),
            if (widget.trailingWidget != null)
              Positioned(
                top: 0,
                right: 25,
                child: widget.trailingWidget ?? Container(),
              )
          ],
        ),
        onPressed: () {
          if (widget.onPressed != null) {
            widget.onPressed?.call();
          }
        },
      ),
    );
  } */
}
