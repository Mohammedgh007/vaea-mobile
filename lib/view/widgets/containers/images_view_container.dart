
import 'package:flutter/material.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// It is used to contain a collection of images that when the user clicks,
/// it opens a view to navigate between the images and perform zoom in and out.
class ImagesViewContainer extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  List<String> imageUrls;

  ImagesViewContainer({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.imageUrls
  });


  @override
  State<ImagesViewContainer> createState() => _ImagesViewContainerState();
}

class _ImagesViewContainerState extends State<ImagesViewContainer> {

  int initialSelectedImage = 0;

  // dimensions
  late double viewWidth;
  late double viewHeight;
  late double bigImageWidth;
  late double bigImageHeight;
  late double smallerImageWidth;
  late double smallerImageHeight;
  late double imageNavigatorPadding;
  late double closeNavigatorButtonSize;
  late double navigatorBottomImageSize;

  @override
  void initState() {
    super.initState();

    setupDimensions();
  }

  /// It is a helper method for initState(). It initializes the fields of dimensions
  void setupDimensions() {
    if (widget.breakpoint.device.name == "smallHandset") {
      viewWidth = widget.layoutConstraints.maxWidth;
      viewHeight = widget.layoutConstraints.maxHeight * 0.35;
      bigImageWidth = viewWidth * 0.5;
      bigImageHeight = (widget.imageUrls.length == 4) ? viewHeight * 0.5 : viewHeight * 0.6;
      smallerImageWidth = viewWidth * 0.33;
      smallerImageHeight = viewHeight * 0.4;
      imageNavigatorPadding = widget.layoutConstraints.maxWidth * 0.04;
      closeNavigatorButtonSize = widget.layoutConstraints.maxWidth * 0.1;
      navigatorBottomImageSize = widget.layoutConstraints.maxWidth * 0.2;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      viewWidth = widget.layoutConstraints.maxWidth;
      viewHeight = widget.layoutConstraints.maxHeight * 0.35;
      bigImageWidth = viewWidth * 0.5;
      bigImageHeight = (widget.imageUrls.length == 4) ? viewHeight * 0.5 : viewHeight * 0.6;
      smallerImageWidth = viewWidth * 0.33;
      smallerImageHeight = viewHeight * 0.4;
      imageNavigatorPadding = widget.layoutConstraints.maxWidth * 0.04;
      closeNavigatorButtonSize = widget.layoutConstraints.maxWidth * 0.1;
      navigatorBottomImageSize = widget.layoutConstraints.maxWidth * 0.2;
    } else {
      viewWidth = widget.layoutConstraints.maxWidth;
      viewHeight = widget.layoutConstraints.maxHeight * 0.35;
      bigImageWidth = viewWidth * 0.5;
      bigImageHeight = (widget.imageUrls.length == 4) ? viewHeight * 0.5 : viewHeight * 0.6;
      smallerImageWidth = viewWidth * 0.33;
      smallerImageHeight = viewHeight * 0.4;
      imageNavigatorPadding = widget.layoutConstraints.maxWidth * 0.04;
      closeNavigatorButtonSize = widget.layoutConstraints.maxWidth * 0.1;
      navigatorBottomImageSize = widget.layoutConstraints.maxWidth * 0.2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(context: context, builder: (ctx) => buildImagesNavigator(ctx)),
      child: SizedBox(
        width: viewWidth,
        height: viewHeight,
        child: Wrap(
          children: [
            ...buildImagesSquares(),
            buildRemainingImagesSquare()
          ],
        ),
      ),
    );
  }


  /// It builds the view for showing all the images.
  Widget buildImagesNavigator(BuildContext ctx) {
    int selectedImageIndex = initialSelectedImage;
    PageController pageController = PageController(initialPage: initialSelectedImage);
    ScrollController bottomImagesScroll = ScrollController();
    return StatefulBuilder(
      builder: (dialogContext, setState) {
        return Scaffold(
          backgroundColor: Colors.black87,
          body: SizedBox(
            width: widget.layoutConstraints.maxWidth,
            height: widget.layoutConstraints.maxHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildExitButtonRow(dialogContext),
                SizedBox(
                  width: widget.layoutConstraints.maxWidth,
                  height: widget.layoutConstraints.maxHeight * 0.7,
                  child: PhotoViewGallery.builder(
                    itemCount: widget.imageUrls.length,
                    pageController: pageController,
                    backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                    onPageChanged: (imageIndex) {
                      setState(() => selectedImageIndex = imageIndex);
                      initialSelectedImage = imageIndex;
                      bottomImagesScroll.jumpTo(imageIndex * navigatorBottomImageSize - navigatorBottomImageSize);
                    } ,
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (context, index) {
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(widget.imageUrls[index]),
                        initialScale: PhotoViewComputedScale.contained * 1,
                        //heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
                      );
                    },
                  ),
                ),
                buildImagesRow(selectedImageIndex, pageController, bottomImagesScroll)
              ],
            ),
          ),
        );
      } ,
    );
  }


  /// It is a helper method for buildImagesNavigator. It builds the exit button section
  Widget buildExitButtonRow(BuildContext dialogContext) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: imageNavigatorPadding),
      child: IconButton(
        onPressed: () => Navigator.of(dialogContext).pop(),
        icon: Icon(Icons.close, color: Colors.white, size: closeNavigatorButtonSize,)
      )
    );
  }


  /// It is a helper method for buildImagesNavigator. It builds the row image of images
  /// at the bottom.
  Widget buildImagesRow(int selectedImageIndex, PageController pageController, ScrollController bottomImagesScroll) {

    return SizedBox(
      width: widget.layoutConstraints.maxWidth,
      height: navigatorBottomImageSize + 10,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: imageNavigatorPadding),
        scrollDirection: Axis.horizontal,
        itemCount: widget.imageUrls.length,
        controller: bottomImagesScroll,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 4);
        },
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => pageController.jumpToPage(index),
            child: Container(
              width: navigatorBottomImageSize,
              height: navigatorBottomImageSize,
              decoration: BoxDecoration(
                border: Border.all(
                  color: (index == selectedImageIndex) ? Theme.of(context).colorScheme.primary : Colors.transparent,
                  width: navigatorBottomImageSize * 0.08
                )
              ),
              child: Image.network( widget.imageUrls[index], fit: BoxFit.fill ),
            ),
          );
        },

      ),
    );
  }


  /// It returns a list of images squares.
  List<Widget> buildImagesSquares() {
    // adding first row that contains the big size always
    List<Widget> imagesSquares = [];
    BoxDecoration imageContainerDecoration = BoxDecoration(
      border: Border.all(color: Theme.of(context).colorScheme.background, width: 2)
    );
    for (int i = 0; i < 2; i++) {
      imagesSquares.add(
        Container(
          width: bigImageWidth,
          height: bigImageHeight,
          decoration: imageContainerDecoration,
          child: Image.network(
            widget.imageUrls[i],
            fit: BoxFit.fill,
          ),
        )
      );
    }

    // adding second row that contains the big size or smaller size images depending on quantity.
    bool isUsingBigSize = (widget.imageUrls.length == 4) ;
    int secondRowLength = isUsingBigSize ? 3 : 4;
    for (int i = 2; i < secondRowLength; i++) {
      imagesSquares.add(
        Container(
          width: (isUsingBigSize) ? bigImageWidth : smallerImageWidth,
          height: (isUsingBigSize) ? bigImageHeight : smallerImageHeight,
          decoration: imageContainerDecoration,
          child: Image.network(
            widget.imageUrls[i],
            fit: BoxFit.fill,
          ),
        )
      );
    }
    
    return imagesSquares;
  }


  /// It builds the square that shows the remaining count of images.
  Widget buildRemainingImagesSquare() {
    bool isUsingBigSize = (widget.imageUrls.length == 4) ;
    debugPrint(widget.imageUrls.length.toString());
    BoxDecoration imageContainerDecoration = BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.background, width: 2)
    );
    
    return Container(
      width: (isUsingBigSize) ? bigImageWidth : smallerImageWidth,
      height: (isUsingBigSize) ? bigImageHeight : smallerImageHeight,
      decoration: imageContainerDecoration,
      child: Stack(
        children: [
          Image.network(
            widget.imageUrls.last,
            fit: BoxFit.fill,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromRGBO(0, 0, 0, 0.8),
            alignment: Alignment.center,
            child: Text(
              "+${(isUsingBigSize) ? 1 : widget.imageUrls.length - 4}",
              style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize
              ),
            ),
          )
        ],
      ),
    );
  }

}