import 'package:catalog_app/widget/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogImage extends StatelessWidget {
  final String image;

  const CatalogImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .rounded
        .p8
        .color(context.canvasColor)
        .make()
        .p12()
        .wPCT(context: context, widthPCT: context.isMobile ? 40 : 20)
        .hPCT(context: context, heightPCT: !context.isMobile ? 40 : 20);
  }
}
