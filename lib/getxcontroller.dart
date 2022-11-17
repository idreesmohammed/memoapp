import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memo/Box.dart';
import 'model.dart';

class StateManage extends GetxController {
  Rx darkMode = false.obs;
  Rx requiredField = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  nighModeFunction() {
    darkMode.value = !darkMode.value;
    update();
  }

  dropDownChange(value) {
    print(value + "dsfd");
    requiredField.value = value;
    update();
  }

  void deleteProduct(ProductModel productModels) {
    productModels.delete();
    print("inside");
  }

  editProducts(
      ProductModel productModel, String product, int qty, String type) {
    if (type.isEmpty || type == "") {
      type = "Kg";
    }
    productModel.productName = product;
    productModel.quantity = qty;
    productModel.productType = type;
    productModel.save();
  }

  addProducts(String productName, int productQuantity, String type, data) {
    print(productQuantity);
    print(data);
    print(productName + type);
    if (type.isEmpty || type == "") {
      type = "Kg";
    }
    final productModel = ProductModel()
      ..productName = productName
      ..quantity = productQuantity
      ..productType = type;
    final box = Boxes.getProducts();
    box.add(productModel);
  }
}
