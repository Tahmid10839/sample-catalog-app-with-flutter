import 'package:catalog_app/models/catalog.dart';
import 'package:catalog_app/pages/home_detail_page.dart';
import 'package:catalog_app/widget/home_widgets/catalog_image.dart';
import 'package:catalog_app/widget/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: CatalogModel.items.length,
        itemBuilder: (context, index) {
          final catalog = CatalogModel.items[index];
          return InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeDetailPage(
                            catalog: catalog,
                          ))),
              child: CatalogItem(catalog: catalog));
        });
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({Key? key, required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
              tag: Key(catalog.id.toString()),
              child: CatalogImage(image: catalog.image)),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
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
                      ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    context.theme.buttonColor),
                                shape: MaterialStateProperty.all(
                                    const StadiumBorder()),
                              ),
                              child: "Add to Cart".text.make())
                          .pOnly(right: 8.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).color(context.cardColor).rounded.square(130).make().py8();
  }
}
