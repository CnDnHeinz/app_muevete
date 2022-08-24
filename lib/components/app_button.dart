import 'package:app_muevete/utils/app-colors.dart';
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
    this.roundness = 18,
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
      width: double.maxFinite,
      child: RaisedButton(
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.roundness),
        ),
        color: AppColors.primary,
        textColor: Colors.white,
        elevation: 0.0,
        padding: widget.padding,
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Center(
              child: Text(
                widget.label ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: widget.fontWeight,
                ),
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
  }
}
