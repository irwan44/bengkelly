import 'package:flutter/material.dart';

class ButtonSubmitWidget extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color? textColor;
  final Color? bgColor, borderSide;
  final double? width, height;
  final bool loading;
  final FontWeight? fontWeight;
  final IconData? iconData;
  final double? sizeIcon;

  const ButtonSubmitWidget({
    Key? key,
    required this.onPressed,
    this.title = '',
    this.bgColor,
    this.textColor,
    this.fontWeight,
    this.borderSide,
    this.width,
    this.height,
    this.iconData,
    this.sizeIcon,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderSide ?? Colors.black),
      ),
      onPressed: onPressed,
      disabledColor: Colors.grey.shade400,
      color: bgColor ?? const Color(0x002b407d),
      child: Container(
        width: width ?? 80,
        height: height ?? 80,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            iconData != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      iconData,
                      color: textColor,
                      size: sizeIcon,
                    ),
                  )
                : Container(),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor ?? Colors.grey[800],
                  fontSize: 18,
                ),
              ),
            ),
            loading
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color?>(
                          textColor ?? Colors.grey[800],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class ButtonSubmitWidget1 extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color? textColor;
  final Color? bgColor, borderSide;
  final double? width, height;
  final bool loading;
  final FontWeight? fontWeight;
  final IconData? iconData;
  final double? sizeIcon;

  const ButtonSubmitWidget1({
    Key? key,
    required this.onPressed,
    this.title = '',
    this.bgColor,
    this.textColor,
    this.fontWeight,
    this.borderSide,
    this.width,
    this.height,
    this.iconData,
    this.sizeIcon,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderSide ?? Colors.black),
      ),
      onPressed: onPressed,
      disabledColor: Colors.grey.shade400,
      color: bgColor ?? const Color(0x002b407d),
      child: Container(
        width: width ?? 80,
        height: height ?? 80,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            iconData != null
                ? Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                iconData,
                color: textColor,
                size: sizeIcon,
              ),
            )
                : Container(),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: textColor ?? Colors.grey[800],
                ),
              ),
            ),
            loading
                ? Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color?>(
                    textColor ?? Colors.grey[800],
                  ),
                ),
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
class ButtonSubmitWidget2 extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color? textColor;
  final Color? bgColor, borderSide;
  final double? width, height;
  final bool loading;
  final FontWeight? fontWeight;
  final IconData? iconData;
  final double? sizeIcon;

  const ButtonSubmitWidget2({
    Key? key,
    required this.onPressed,
    this.title = '',
    this.bgColor,
    this.textColor,
    this.fontWeight,
    this.borderSide,
    this.width,
    this.height,
    this.iconData,
    this.sizeIcon,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderSide ?? Colors.black),
      ),
      onPressed: onPressed,
      disabledColor: Colors.grey.shade400,
      color: bgColor ?? const Color(0x002b407d),
      child: Container(
        width: width ?? 80,
        height: height ?? 80,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            iconData != null
                ? Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                iconData,
                color: textColor,
                size: sizeIcon,
              ),
            )
                : Container(),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor ?? Colors.grey[800],
                ),
              ),
            ),
            loading
                ? Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color?>(
                    textColor ?? Colors.grey[800],
                  ),
                ),
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}

