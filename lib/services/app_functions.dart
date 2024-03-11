import 'package:bestshop_adminpanel/services/images_manager.dart';
import 'package:bestshop_adminpanel/widgets/subtitle_text.dart';
import 'package:bestshop_adminpanel/widgets/title_text.dart';
import 'package:flutter/material.dart';

class AppFunctions {
  static Future<void> showErrorOrWarningDialog({
    required BuildContext context,
    required Function func,
    bool isError = true,
    required String title,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  isError ? ImagesManager.error : ImagesManager.warning,
                  width: 60,
                  height: 60,
                ),
                const SizedBox(
                  height: 15,
                ),
                TitleTextWidget(
                  label: title,
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      visible: !isError,
                      child: TextButton(
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          child: const TitleTextWidget(
                            label: "Cancel",
                            color: Colors.green,
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                          func();
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                        child: const TitleTextWidget(
                          label: "OK",
                          color: Colors.red,
                        )),
                  ],
                ),
              ],
            ),
          );
        });
  }

  static Future<void> imagePickerDialog(
      {required BuildContext context,
      required Function cameraFunc,
      required Function galleryFunc,
      required Function removeFunc}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: TitleTextWidget(label: "Choose option")),
            content: SingleChildScrollView(
              child: ListBody(children: [
                TextButton.icon(
                    onPressed: () {
                      cameraFunc();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const SubtitleTextWidget(label: "Camera")),
                TextButton.icon(
                    onPressed: () {
                      galleryFunc();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.photo),
                    label: const SubtitleTextWidget(label: "Gallery")),
                TextButton.icon(
                    onPressed: () {
                      removeFunc();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.remove_circle),
                    label: const SubtitleTextWidget(label: "Remove")),
              ]),
            ),
          );
        });
  }
}
