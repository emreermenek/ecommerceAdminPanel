import 'package:bestshop_adminpanel/consts/color_data.dart';
import 'package:bestshop_adminpanel/providers/theme_provider.dart';
import 'package:bestshop_adminpanel/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AppNameTextWidget extends StatelessWidget {
  const AppNameTextWidget({super.key, required this.title, this.fontSize = 18});

  final String title;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Shimmer.fromColors(
        period: const Duration(milliseconds: 3000),
        baseColor: themeProvider.getIsDarkTheme
            ? ColorData.darkPrimaryColor
            : ColorData.lightPrimaryColor,
        highlightColor: themeProvider.getIsDarkTheme
            ? ColorData.lightPrimaryColor
            : ColorData.darkPrimaryColor,
        child: SubtitleTextWidget(
          label: title,
          fontSize: fontSize,
        ));
  }
}
