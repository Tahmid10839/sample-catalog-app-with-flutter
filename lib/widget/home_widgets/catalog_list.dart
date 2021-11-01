import 'package:catalog_app/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:catalog_app/models/catalog.dart';
import 'package:catalog_app/pages/home_detail_page.dart';
import 'package:catalog_app/widget/home_widgets/catalog_image.dart';
import 'package:catalog_app/widget/themes.dart';

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
                      _AddToCart(
                        catalog: catalog,
                      ),
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

class _AddToCart extends StatefulWidget {
  final Item catalog;
  _AddToCart({
    Key? key,
    required this.catalog,
  }) : super(key: key);

  @override
  __AddToCartState createState() => __AddToCartState();
}

class __AddToCartState extends State<_AddToCart> {
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            onPressed: () {
              isAdded = isAdded.toggle();
              final _catalog = CatalogModel();
              final _cart = CartModel();
              _cart.catalog = _catalog;
              _cart.add(widget.catalog);
              setState(() {});
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(context.theme.buttonColor),
              shape: MaterialStateProperty.all(const StadiumBorder()),
            ),
            child: isAdded ? const Icon(Icons.done) : "Add to Cart".text.make())
        .pOnly(right: 8.0);
  }
}
