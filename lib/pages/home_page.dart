import 'package:catalog_app/models/catalog.dart';
import 'package:catalog_app/utils/routes.dart';
// import 'package:catalog_app/widget/drawer.dart';
import 'package:catalog_app/widget/home_widgets/catalog_header.dart';
import 'package:catalog_app/widget/home_widgets/catalog_list.dart';
// import 'package:catalog_app/widget/item_widget.dart';
import 'package:catalog_app/widget/themes.dart';
import 'package:flutter/cupertino.dart';
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
      backgroundColor: context.canvasColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyRoutes.cartRoute);
        },
        backgroundColor: context.theme.buttonColor,
        child: const Icon(
          CupertinoIcons.cart,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                CatalogList().pOnly(top: 16, bottom: 40).expand()
              else
                const CircularProgressIndicator().centered().py16().expand(),
            ],
          ),
        ),
      ),
      // ),
      // drawer: MyDrawer(),
    );
  }
}
