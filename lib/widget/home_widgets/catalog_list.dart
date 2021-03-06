import 'package:catalog_app/models/cart.dart';
import 'package:catalog_app/utils/routes.dart';
import 'package:catalog_app/widget/home_widgets/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:catalog_app/models/catalog.dart';
import 'package:catalog_app/pages/home_detail_page.dart';
import 'package:catalog_app/widget/home_widgets/catalog_image.dart';
import 'package:catalog_app/widget/themes.dart';

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return !context.isMobile
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 40.0),
            shrinkWrap: true,
            itemCount: CatalogModel.items.length,
            itemBuilder: (context, index) {
              final catalog = CatalogModel.items[index];
              return InkWell(
                  // onTap: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => HomeDetailPage(
                  //               catalog: catalog,
                  //             ))
                  onTap: () => context.vxNav.push(
                      Uri(
                          path: MyRoutes.homeDetailRoute,
                          queryParameters: {"id": catalog.id.toString()}),
                      params: catalog),
                  child: CatalogItem(catalog: catalog));
            })
        : ListView.builder(
            shrinkWrap: true,
            itemCount: CatalogModel.items.length,
            itemBuilder: (context, index) {
              final catalog = CatalogModel.items[index];
              return InkWell(
                  // onTap: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => HomeDetailPage(
                  //               catalog: catalog,
                  //             ))),
                  onTap: () => context.vxNav.push(
                      Uri(
                          path: MyRoutes.homeDetailRoute,
                          queryParameters: {"id": catalog.id.toString()}),
                      params: catalog),
                  child: CatalogItem(catalog: catalog));
            });
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({Key? key, required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children2 = [
      Hero(
          tag: Key(catalog.id.toString()),
          child: CatalogImage(image: catalog.image)),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              catalog.name.text.lg.bold.color(context.accentColor).make(),
              catalog.desc.text
                  .color(context.accentColor.withOpacity(0.7))
                  .make(),
              4.heightBox,
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                buttonPadding: EdgeInsets.zero,
                children: [
                  "\$ ${catalog.price}".text.bold.xl.make(),
                  AddToCart(
                    catalog: catalog,
                  ),
                ],
              ),
            ],
          ).p(context.isMobile ? 0 : 16),
        ),
      ),
    ];
    return VxBox(
      child: context.isMobile
          ? Row(
              children: children2,
            )
          : Column(
              children: children2,
            ),
    ).color(context.cardColor).rounded.square(130).make().py8();
  }
}
