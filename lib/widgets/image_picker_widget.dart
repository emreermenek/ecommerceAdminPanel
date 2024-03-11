import 'dart:io';
import 'package:bestshop_adminpanel/widgets/material_button_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key, this.pickedImage, required this.func});

  final XFile? pickedImage;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: pickedImage == null
              ? DottedBorder(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(25),
                  child: const SizedBox.expand())
              : ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: FileImage(
                              File(pickedImage!.path),
                            )),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.onBackground),
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
        ),
        pickedImage == null
            ? Center(
                child: FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      func();
                    },
                    child: const Icon(
                      Icons.image,
                      color: Colors.blue,
                      size: 80,
                    ),
                  ),
                ),
              )
            : Positioned(
                right: 0,
                top: 0,
                child: MaterialButtonWidget(
                  size: 20,
                  padding: 5.5,
                  color: Colors.lightBlue.shade300,
                  borderRadius: 25,
                  icon: Icons.edit,
                  func: () {
                    func();
                  },
                ),
              )
      ],
    );
  }
}
