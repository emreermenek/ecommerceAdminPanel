import 'package:bestshop_adminpanel/consts/app_consts.dart';
import 'package:bestshop_adminpanel/widgets/subtitle_text.dart';
import 'package:bestshop_adminpanel/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: FancyShimmerImage(
            imageUrl: AppConstants.nikeShoe,
            width: size.width * 0.3,
            height: size.width * 0.3,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      flex: 4,
                      child: TitleTextWidget(
                        label: "Nike Shoe",
                        fontSize: 18,
                        maxLines: 2,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.close),
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                      text: "Price:  ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground),
                      children: const <TextSpan>[
                        TextSpan(
                            text: "\$1600",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.w400))
                      ]),
                ),
                const SizedBox(height: 5),
                const SubtitleTextWidget(
                  label: "Qty: 10",
                  fontSize: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
