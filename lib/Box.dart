import 'package:hive/hive.dart';

import 'model.dart';

class Boxes {
  static Box<ProductModel> getProducts() => Hive.box<ProductModel>('products');
  static Future<void> deleteProduct() => Hive.deleteFromDisk();
}
