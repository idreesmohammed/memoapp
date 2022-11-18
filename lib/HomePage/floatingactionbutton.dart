import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo/getxcontroller.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:select_form_field/select_form_field.dart';

import '../Constants/constants.dart';
import '../list_of_items.dart';
import 'homepage.dart';

// ignore: must_be_immutable
class FloatingButton extends StatefulWidget {
  FloatingButton(this.color, {Key? key}) : super(key: key);
  dynamic color;

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  StateManage stateManage = StateManage();
  var productController = TextEditingController();
  var quantityController = TextEditingController();
  var selectedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    var color = widget.color;
    final width = MediaQuery.of(context).size.width;
    return Obx(() => FloatingActionButton(
          backgroundColor: color == false ? Colors.white : Colors.black,
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
                                padding: const EdgeInsets.only(left: 10.0),
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
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 5.0),
                                child: SelectFormField(
                                  type: SelectFormFieldType.dropdown,
                                  // or can be dialog
                                  initialValue: 'Kg',
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: Icon(Icons.arrow_drop_down)),

                                  items: ItemList.items,

                                  onChanged: (val) {
                                    stateManage.dropDownChange(val);
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
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.06,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (productController.text
                                            .toString()
                                            .isEmpty ||
                                        quantityController.text
                                            .toString()
                                            .isEmpty) {
                                      QuickAlert.show(
                                          text:
                                              "Please check the Input Fields!",
                                          context: context,
                                          type: QuickAlertType.warning);
                                    }
                                    stateManage.addProducts(
                                        productController.text,
                                        int.parse(
                                            quantityController.text.toString()),
                                        stateManage.requiredField(),
                                        selectedController);

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
            color: color == false ? Colors.black : Colors.white,
          ),
        ));
  }
}
