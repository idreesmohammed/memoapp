import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  late String productName;
  @HiveField(1)
  late int quantity;
}
