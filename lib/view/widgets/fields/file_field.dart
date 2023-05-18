import 'dart:io';
import 'package:breakpoint/breakpoint.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

/// It builds a file input field that uses VAEA theme.
class VAEAFileField extends StatelessWidget {

  final Breakpoint breakpoint;
  final BoxConstraints layoutConstraints;
  final void Function(File selectedFile) handleSelectFile;
  /// selectedFile must be managed in setState() of the parent
  final File? selectedFile;
  final String labelStr;
  final String hintStr;
  final Icon? icon;
  final double? height;
  final double? width;
  final bool? isDisabled;
  /// If it is null, then the field is not in error state
  final String? errorMsg;

  // dimensions
  late double fieldWidth;
  late double labelFieldSpacer;
  late double fieldBorderWidth;


  VAEAFileField({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.selectedFile,
    required this.handleSelectFile,
    required this.labelStr,
    required this.hintStr,
    this.icon,
    this.height,
    this.width,
    this.isDisabled,
    this.errorMsg,
  }) {
    setupDimension();
  }


  /// It is a helper method for the constructor. It initializes the dimensions.
  void setupDimension() {
    if (breakpoint.device.name == "smallHandset") {
      fieldWidth = (width != null) ?  width! : layoutConstraints.maxWidth * 0.92;
      labelFieldSpacer = layoutConstraints.maxHeight * 0.001;
      fieldBorderWidth = layoutConstraints.maxWidth * 0.01;
    } else if(breakpoint.device.name == "mediumHandset") {
      fieldWidth = (width != null) ?  width! : layoutConstraints.maxWidth * 0.92;
      labelFieldSpacer = layoutConstraints.maxHeight * 0.001;
      fieldBorderWidth = layoutConstraints.maxWidth * 0.01;
    } else {
      fieldWidth = (width != null) ?  width! : layoutConstraints.maxWidth * 0.92;
      labelFieldSpacer = layoutConstraints.maxHeight * 0.001;
      fieldBorderWidth = layoutConstraints.maxWidth * 0.01;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelStr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: labelFieldSpacer),
        GestureDetector(
          onTap: () => selectFile(),
          child: Container(
            height: height,
            width: fieldWidth,
            padding: const EdgeInsets.all(8),
            decoration: getContainerDecoration(context),
            child: getFieldContent(context),
          ),
        ),
        if (errorMsg != null) buildErrorMsg(context)
      ],
    );
  }


  /// It returns the decoration for the field container decoration.
  BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
          color: (errorMsg != null) ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.outline,
          width: fieldBorderWidth * 0.5
      ),
      borderRadius: BorderRadius.circular(fieldWidth * 0.04),
    );
  }


  /// It builds the text widget and the icon within the container
  Widget getFieldContent(BuildContext context) {
    String displayedText = (selectedFile == null)
        ? hintStr
        : Path.basename(selectedFile!.path);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            displayedText,
            style: TextStyle(
              fontWeight: (selectedFile == null) ? Theme.of(context).textTheme.bodyLarge!.fontWeight : Theme.of(context).textTheme.titleSmall!.fontWeight,
              fontSize: (selectedFile == null) ? Theme.of(context).textTheme.bodyLarge!.fontSize : Theme.of(context).textTheme.titleSmall!.fontSize,
              color: (selectedFile == null) ? Colors.black45 : Theme.of(context).colorScheme.onBackground,
              overflow: TextOverflow.ellipsis
            ),
          ),
        ),
        Icon(
          Icons.upload_file,
          color: Theme.of(context).colorScheme.outline,
        )
      ],
    );
  }


  /// It is a helper method. It builds the error message for the field.
  /// @pre-condition errorMsg is not null.
  Widget buildErrorMsg(BuildContext context) {
    return Container(
      width: fieldWidth,
      margin: const EdgeInsets.only(top: 2),
      child: Text(
        errorMsg!,
        overflow: TextOverflow.visible,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            color: Theme.of(context).colorScheme.error
        ),
      ),
    );
  }


  /// it handles prompting the user to input a file
  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null && result.files.single.path != null) {
      File selectedFile = File(result.files.single.path!);
      handleSelectFile(selectedFile);
    }
  }

}