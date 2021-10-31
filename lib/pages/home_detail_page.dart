import 'package:catalog_app/models/catalog.dart';
import 'package:catalog_app/widget/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeDetailPage extends StatelessWidget {
  final Item catalog;

  const HomeDetailPage({Key? key, required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: context.canvasColor,
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "\$ ${catalog.price}".text.bold.xl3.red800.make(),
            ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(context.theme.buttonColor),
                      shape: MaterialStateProperty.all(const StadiumBorder()),
                    ),
                    child: "Add to Cart".text.xl.bold.make())
                .wh(150, 50),
          ],
        ).pOnly(left: 32, right: 32, top: 16, bottom: 16),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
                    tag: Key(catalog.id.toString()),
                    child: Image.network(catalog.image))
                .h32(context)
                .pOnly(left: 16, right: 16),
            Expanded(
                child: VxArc(
              height: 30.0,
              edge: VxEdge.TOP,
              arcType: VxArcType.CONVEY,
              child: Container(
                color: context.cardColor,
                width: context.screenWidth,
                child: Column(
                  children: [
                    catalog.name.text.xl3.bold
                        .color(context.accentColor)
                        .make(),
                    catalog.desc.text.xl
                        .color(context.accentColor.withOpacity(0.7))
                        .make(),
                    4.heightBox,
                    "At ipsum dolores takimata vero dolor erat. Sed dolor clita et invidunt dolor, takimata eos voluptua ut et at et, gubergren amet amet consetetur kasd ipsum invidunt, sed rebum invidunt erat sit. Justo ut magna dolores rebum magna nonumy, sadipscing lorem ipsum ipsum takimata duo no. Labore amet dolor ipsum."
                        .text
                        .justify
                        .color(context.accentColor.withOpacity(0.8))
                        .make()
                        .pOnly(left: 32, right: 32, top: 16),
                  ],
                ).py64(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
