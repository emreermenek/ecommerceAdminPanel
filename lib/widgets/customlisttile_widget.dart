import 'package:bestshop_adminpanel/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.func});

  final String image;
  final String title;
  final Function func;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        image,
        height: 32,
        width: 32,
      ),
      titleAlignment: ListTileTitleAlignment.titleHeight,
      title: SubtitleTextWidget(
        label: title,
        fontSize: 14,
      ),
      trailing: const Icon(Icons.arrow_right),
      onTap: () {
        func();
      },
    );
  }
}
