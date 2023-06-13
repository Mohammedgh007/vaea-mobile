

import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VirtualTourContainer extends StatefulWidget {
  
  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  double? shrinkWidth;
  double? shrinkHeight;
  String imagePurviewUrl;
  String tourUrl;


  VirtualTourContainer({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    this.shrinkWidth,
    this.shrinkHeight,
    required this.imagePurviewUrl,
    required this.tourUrl
  });

  @override
  State<VirtualTourContainer> createState() => _VirtualTourContainerState();
}

class _VirtualTourContainerState extends State<VirtualTourContainer> {
  
  WebViewController controller = WebViewController()..loadRequest(Uri.parse("https://kuula.co/share/collection/7YykL?fs=1&vr=1&zoom=1&sd=1&initload=0&thumbs=1&info=0&logo=1&logosize=162"));

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: widget.layoutConstraints.maxWidth * 0.8,
      height: widget.layoutConstraints.maxWidth * 0.8,
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
