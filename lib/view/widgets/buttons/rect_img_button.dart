
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

/// It builds a square button that includes a text and a background image
/// with transparent gradient.
class RectImgButton extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  bool isImageAsset;
  String imagePath;
  String buttonText;
  double buttonSize;
  void Function() handleClick;

  RectImgButton({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.isImageAsset,
    required this.imagePath,
    required this.buttonText,
    required this.buttonSize,
    required this.handleClick
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleClick,
      child: SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: Stack(
          children: [
            buildImage(),
            buildGradient(),
            buildText(context)
          ],
        ),
      ),
    );
  }


  /// It builds the transparent gradient layer.
  Widget buildGradient() {
    return Positioned.fill(
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(240, 240, 240, 0.1),
              Color.fromRGBO(0, 0, 0, 0.8)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
          borderRadius: BorderRadius.circular(buttonSize * 0.1)
        ),
      )
    );
  }


  /// It builds the image layer below the gradient.
  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(buttonSize * 0.1),
      child: Image.asset(
        imagePath,
        width: buttonSize,
        height: buttonSize,
        fit: BoxFit.fill,
      ),
    );
  }

  /// It builds the text layer.
  Widget buildText(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
            fontWeight: FontWeight.bold
          ),
        ),
      )
    );
  }

}