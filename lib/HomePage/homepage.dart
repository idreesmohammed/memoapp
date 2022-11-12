import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo/Box.dart';
import 'package:memo/Constants/constants.dart';
import 'package:memo/model.dart';
import 'package:provider/provider.dart';

import '../providerclass.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue = 'Qty';
  var productController = TextEditingController();
  var quantityController = TextEditingController();
  bool darkMode = false;
  @override
  void dispose() {
    Hive.box('products').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:
          Provider.of<ProviderFunction>(context, listen: true).darkMode == false
              ? Colors.black
              : Colors.white,
      appBar: AppBar(
        backgroundColor:
            Provider.of<ProviderFunction>(context, listen: true).darkMode ==
                    false
                ? const Color(0xff232F3E)
                : Colors.white10,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ProviderFunction>(context, listen: false)
                    .nighModeFunction();
                // setState(() {
                //   darkMode = !darkMode;
                // });
              },
              icon: Provider.of<ProviderFunction>(context, listen: true)
                          .darkMode ==
                      false
                  ? const Icon(
                      Icons.wb_sunny,
                      color: Colors.yellow,
                    )
                  : const Icon(
                      Icons.nightlight_round,
                      color: Colors.black,
                    ))
        ],
        title: Text(
          Constants.header,
          style: GoogleFonts.poppins(
              color: Provider.of<ProviderFunction>(context, listen: true)
                          .darkMode ==
                      false
                  ? Colors.white
                  : Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: ValueListenableBuilder<Box<ProductModel>>(
        valueListenable: Boxes.getProducts().listenable(),
        builder: (context, box, _) {
          final productModels = box.values.toList().cast<ProductModel>();

          return productModels.length == 0
              ? Center(
                  child: Text(
                    Constants.empty,
                    style: GoogleFonts.poppins(
                        color:
                            Provider.of<ProviderFunction>(context, listen: true)
                                        .darkMode ==
                                    false
                                ? Colors.white
                                : Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                )
              : ListView.builder(
                  itemCount: productModels.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color:
                            Provider.of<ProviderFunction>(context, listen: true)
                                        .darkMode ==
                                    false
                                ? Colors.white
                                : Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                      height: height * 0.09,
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          SizedBox(
                            width: width * 0.4,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: StrutStyle(fontSize: 12.0),
                              text: TextSpan(
                                style: (GoogleFonts.poppins(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                  color: Provider.of<ProviderFunction>(context,
                                                  listen: true)
                                              .darkMode ==
                                          false
                                      ? Colors.black
                                      : Colors.white,
                                )),
                                text: productModels[index].productName,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          SizedBox(
                            width: width * 0.05,
                            child: Text(
                              productModels[index].quantity.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 23,
                                color: Provider.of<ProviderFunction>(context,
                                                listen: true)
                                            .darkMode ==
                                        false
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.13,
                            child: Text(
                              Constants.quantity,
                              style: GoogleFonts.poppins(
                                fontSize: 23,
                                color: Provider.of<ProviderFunction>(context,
                                                listen: true)
                                            .darkMode ==
                                        false
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.1,
                          ),
                          IconButton(
                              onPressed: () {
                                deleteProduct(productModels[index]);
                              },
                              icon: Icon(Icons.delete,
                                  color: Provider.of<ProviderFunction>(context,
                                                  listen: true)
                                              .darkMode ==
                                          false
                                      ? Colors.black
                                      : Colors.white)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit,
                                  color: Provider.of<ProviderFunction>(context,
                                                  listen: true)
                                              .darkMode ==
                                          false
                                      ? Colors.black
                                      : Colors.white))
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Provider.of<ProviderFunction>(context, listen: true).darkMode ==
                    false
                ? Colors.white
                : Colors.black,
        onPressed: () {
          showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ClassicGeneralDialogWidget(
                actions: [
                  Container(
                    color: Colors.white,
                    height: height * 0.3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.06,
                          width: width,
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                controller: productController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: (Constants.hintTextProduct)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SizedBox(
                          height: height * 0.06,
                          width: width * 0.5,
                          child: Center(
                            child: Card(
                              elevation: 10,
                              child: TextFormField(
                                controller: quantityController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: (Constants.hintQuantity)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.36,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  child: Text(
                                    Constants.cancel,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.06,
                              ),
                              InkWell(
                                onTap: () {
                                  print(productController.text +
                                      quantityController.text);
                                  if (productController.text
                                          .toString()
                                          .isEmpty ||
                                      quantityController.text
                                          .toString()
                                          .isEmpty) {
                                    const snackBar = SnackBar(
                                      content:
                                          Text('Please enter the valid Input'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                  addProducts(
                                      productController.text,
                                      int.parse(
                                          quantityController.text.toString()));
                                  setState(() {
                                    productController.text.isEmpty;
                                    quantityController.text.isEmpty;
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const HomePage(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  child: Text(
                                    Constants.apply,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )

                        // TextFormField(
                        //   controller: productController,
                        // ),
                      ],
                    ),
                  ),
                ],
              );
            },
            animationType: DialogTransitionType.fadeScale,
            curve: Curves.easeOutSine,
            duration: const Duration(seconds: 1),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
          color:
              Provider.of<ProviderFunction>(context, listen: true).darkMode ==
                      false
                  ? Colors.black
                  : Colors.white,
        ),
      ),
    );
  }

  addProducts(String productName, int productQuantity) {
    final productModel = ProductModel()
      ..productName = productName
      ..quantity = productQuantity;
    final box = Boxes.getProducts();
    box.add(productModel);
  }

  void deleteProduct(ProductModel productModels) {
    // final box = Boxes.getProducts();
    // box.delete(productModels.key);
    // box.delete(transaction.key);
    productModels.delete();

    //setState(() => transactions.remove(transaction));
  }
}
