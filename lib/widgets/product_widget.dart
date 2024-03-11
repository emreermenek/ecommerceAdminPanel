import 'package:bestshop_adminpanel/providers/product_provider.dart';
import 'package:bestshop_adminpanel/widgets/subtitle_text.dart';
import 'package:bestshop_adminpanel/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key, required this.productId});

  final String productId;
  @override
  Widget build(BuildContext context) {
    //final productModelProvider = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurProduct = productProvider.findByProductId(productId);
    final size = MediaQuery.of(context).size;
    return getCurProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () async {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Flexible(
                      child: FancyShimmerImage(
                        imageUrl: getCurProduct.productImage,
                        height: size.height * 0.25,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.04,
                  ),
                  Flexible(
                    child: TitleTextWidget(
                      label: getCurProduct.productTitle,
                      fontSize: 16,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  Flexible(
                    child: SubtitleTextWidget(
                      label: "${getCurProduct.productPrice}\$",
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
