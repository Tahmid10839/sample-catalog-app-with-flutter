import 'package:catalog_app/models/catalog.dart';
import 'package:catalog_app/widget/drawer.dart';
import 'package:catalog_app/widget/item_widget.dart';
import 'package:catalog_app/widget/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    final productsData = decodedData['products'];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final dummyList = List.generate(5, (index) => CatalogModel.items[0]);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(
      //       child: Text(
      //     "Catalog App",
      //   )),
      // ),
      // body:
      // Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
      //       ?
      // ListView.builder(
      //     itemCount: CatalogModel.items.length,
      //     itemBuilder: (context, index) => ItemWidget(
      //           item: CatalogModel.items[index],
      //         ))
      // GridView.builder(
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 2,
      //       mainAxisSpacing: 16,
      //       crossAxisSpacing: 16,
      //     ),
      //     itemCount: CatalogModel.items.length,
      //     itemBuilder: (context, index) {
      //       final items = CatalogModel.items[index];
      //       return Card(
      //         clipBehavior: Clip.antiAlias,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(10)),
      //         child: GridTile(
      //           header: Container(
      //             child: Text(
      //               items.name,
      //               style: const TextStyle(color: Colors.white),
      //             ),
      //             padding: const EdgeInsets.all(16.0),
      //             decoration: const BoxDecoration(
      //               color: Colors.deepPurple,
      //             ),
      //           ),
      //           child: Image.network(items.image),
      //           footer: Container(
      //             child: Text(
      //               "\$ ${items.price}",
      //               style: const TextStyle(color: Colors.white),
      //             ),
      //             padding: const EdgeInsets.all(16.0),
      //             decoration: const BoxDecoration(
      //               color: Colors.black,
      //             ),
      //           ),
      //         ),
      //       );
      //     })
      // : const Center(
      //     child: CircularProgressIndicator(),
      //   ),
      backgroundColor: MyTheme.creamColor,
      body: SafeArea(
        child: Container(
          padding: Vx.m24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                CatalogList().expand()
              else
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
      // ),
      // drawer: MyDrawer(),
    );
  }
}

class CatalogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App".text.xl3.bold.color(MyTheme.darkBluishColor).make(),
        "Trending Products".text.xl.make(),
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: CatalogModel.items.length,
        itemBuilder: (context, index) {
          final catalog = CatalogModel.items[index];
          return CatalogItem(catalog: catalog);
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
          CatalogImage(image: catalog.image),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  catalog.name.text.lg.bold
                      .color(MyTheme.darkBluishColor)
                      .make(),
                  catalog.desc.text.color(Colors.black.withOpacity(0.5)).make(),
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
                                    MyTheme.darkBluishColor),
                                shape: MaterialStateProperty.all(
                                    const StadiumBorder()),
                              ),
                              child: "Buy".text.make())
                          .pOnly(right: 8.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).white.rounded.square(130).make().py8();
  }
}

class CatalogImage extends StatelessWidget {
  final String image;

  const CatalogImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .rounded
        .p8
        .color(MyTheme.creamColor)
        .make()
        .p12()
        .w32(context);
  }
}
