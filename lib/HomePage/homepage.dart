import 'dart:ui';
import 'package:quickalert/quickalert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo/Box.dart';
import 'package:memo/Constants/constants.dart';
import 'package:memo/model.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

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
  var editedProductController = TextEditingController();
  var editedQtyController = TextEditingController();
  var selectedController = TextEditingController();
  bool darkMode = false;
  bool isChecked = false;
  String selectedField = "";
  @override
  void dispose() {
    Hive.box('products').close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
                            width: width * 0.35,
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
                            width: width * 0.1,
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
                                text: productModels[index].productType,
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
                          //editIconButton
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      actions: [
                                        SizedBox(
                                          height: height * 0.05,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          height: height * 0.4,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: height * 0.06,
                                                width: width,
                                                child: Card(
                                                  elevation: 10,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                    child: TextFormField(
                                                      controller: editedProductController =
                                                          TextEditingController.fromValue(
                                                              TextEditingValue(
                                                                  text: productModels[
                                                                          index]
                                                                      .productName)),
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText: (Constants
                                                              .hintTextProduct)),
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
                                                      controller: editedQtyController =
                                                          TextEditingController.fromValue(
                                                              TextEditingValue(
                                                                  text: productModels[
                                                                          index]
                                                                      .quantity
                                                                      .toString())),
                                                      textAlign:
                                                          TextAlign.center,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText: (Constants
                                                              .hintQuantity)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.05,
                                              ),
                                              Card(
                                                  elevation: 10,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0, top: 5.0),
                                                    child: SelectFormField(
                                                      type: SelectFormFieldType
                                                          .dropdown, // or can be dialog
                                                      initialValue:
                                                          productModels[index]
                                                              .productType,
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          suffixIcon: Icon(Icons
                                                              .arrow_drop_down)),

                                                      items: _items,

                                                      onChanged: (val) {
                                                        print(selectedField +
                                                            "hi");
                                                        setState(() {
                                                          selectedField = val;
                                                        });
                                                      },
                                                    ),
                                                  )),
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
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.06,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        if (editedProductController
                                                                .text
                                                                .toString()
                                                                .isEmpty ||
                                                            editedQtyController
                                                                .text
                                                                .toString()
                                                                .isEmpty) {
                                                          QuickAlert.show(
                                                              context: context,
                                                              type:
                                                                  QuickAlertType
                                                                      .warning);
                                                        }
                                                        editProducts(
                                                            productModels[
                                                                index],
                                                            editedProductController
                                                                .text,
                                                            int.parse(
                                                                editedQtyController
                                                                    .text
                                                                    .toString()),
                                                            selectedField);
                                                        setState(() {
                                                          productController
                                                              .text.isEmpty;
                                                          quantityController
                                                              .text.isEmpty;
                                                        });
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute<
                                                              void>(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                const HomePage(),
                                                          ),
                                                        );
                                                      },
                                                      child: SizedBox(
                                                        child: Text(
                                                          Constants.apply,
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                );
                              },
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actions: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    color: Colors.white,
                    height: height * 0.4,
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
                                keyboardType: TextInputType.number,
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
                        Card(
                            elevation: 10,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.0, top: 5.0),
                              child: SelectFormField(
                                type: SelectFormFieldType
                                    .dropdown, // or can be dialog
                                initialValue: 'Kgs',
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: Icon(Icons.arrow_drop_down)),

                                items: _items,

                                onChanged: (val) {
                                  print(selectedField + "hi");
                                  setState(() {
                                    selectedField = val;
                                  });
                                },
                              ),
                            )),
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
                                  print(selectedField);
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
                                    QuickAlert.show(
                                        text: "Please check the Input Fields!",
                                        context: context,
                                        type: QuickAlertType.warning);
                                  }
                                  addProducts(
                                      productController.text,
                                      int.parse(
                                          quantityController.text.toString()),
                                      selectedField);

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()));
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
                        ),

                        // TextFormField(
                        //   controller: productController,
                        // ),
                      ],
                    ),
                  ),
                ],
              );
            },
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

  addProducts(String productName, int productQuantity, String type) {
    print(type + "578");
    if (type.isEmpty || type == "" || type == null) {
      setState(() {
        type = "Kgs";
      });
      print(type + "584");
    }
    final productModel = ProductModel()
      ..productName = productName
      ..quantity = productQuantity
      ..productType = type;
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

  void editProducts(
      ProductModel productModel, String product, int qty, String type) {
    print(type + "596");
    if (type.isEmpty || type == "" || type == null) {
      setState(() {
        type = "Kgs";
      });
      print(type + "584");
    }
    print(product + qty.toString());
    productModel.productName = product;
    productModel.quantity = qty;
    productModel.productType = type;

    // final productModel = ProductModel();
    // if (productModel.isInBox == true) {
    //   print("its here");
    // } else {
    //   print("not here");
    // }
    // productModel.productName = product;
    // productModel.quantity = qty;
    productModel.save();
  }

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Kgs',
      'label': 'Kgs',
    },
    {
      'value': 'Litre',
      'label': 'Litre',
    },
    {
      'value': 'Grams',
      'label': 'Grams',
    },
    {
      'value': 'Packets',
      'label': 'Packets',
    },
  ];
}
