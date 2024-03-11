import 'package:bestshop_adminpanel/widgets/subtitle_text.dart';
import 'package:bestshop_adminpanel/widgets/title_text.dart';
import 'package:flutter/material.dart';

class EmptyCardWidget extends StatelessWidget {
  const EmptyCardWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle1,
      required this.subtitle2,
      required this.buttonText,
      required this.func});

  final String image, title, subtitle1, subtitle2, buttonText;
  final Function func;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Image.asset(
            image,
            width: double.infinity,
            height: size.height * 0.4,
          ),
          const SizedBox(
            height: 30,
          ),
          TitleTextWidget(
            label: title,
            color: Colors.red,
          ),
          const SizedBox(
            height: 20,
          ),
          SubtitleTextWidget(
            label: subtitle1,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 10,
          ),
          SubtitleTextWidget(
            label: subtitle2,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
