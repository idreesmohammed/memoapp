import 'package:get/get.dart';
import 'package:memo/Box.dart';
import 'model.dart';

class StateManage extends GetxController {
  Rx darkMode = false.obs;
  Rx requiredField = "".obs;

  nighModeFunction() {
    darkMode.value = !darkMode.value;

    update();
  }

  dropDownChange(value) {
    requiredField.value = value;
    update();
  }

  void deleteProduct(ProductModel productModels) {
    productModels.delete();
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
