import 'package:catalog_app/core/store.dart';
import 'package:catalog_app/models/cart.dart';
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
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final url = "https://api.jsonbin.io/b/604dbddb683e7e079c4eefd3";
  final url = "https://api.jsonbin.io/b/618009a44a82881d6c68aa97";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    // final catalogJson =
    //     await rootBundle.loadString("assets/files/catalog.json");
    final response = await http.get(Uri.parse(url));
    final catalogJson = response.body;
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
    final _cart = (VxState.store as MyStore).cart;
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
      floatingActionButton: VxBuilder(
        mutations: {AddMutation, RemoveMutation},
        builder: (context, dynamic, VxStatus) {
          return FloatingActionButton(
            onPressed: () {
              // Navigator.pushNamed(context, MyRoutes.cartRoute);
              context.vxNav.push(Uri.parse(MyRoutes.cartRoute));
            },
            backgroundColor: context.theme.buttonColor,
            child: const Icon(
              CupertinoIcons.cart,
              color: Colors.white,
            ),
          ).badge(
              color: Vx.red500,
              size: 25,
              count: _cart.items.length,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white));
        },
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
                CircularProgressIndicator(
                  color: context.accentColor,
                ).centered().py16().expand(),
            ],
          ),
        ),
      ),
      // ),
      // drawer: MyDrawer(),
    );
  }
}
