import 'package:hive/hive.dart';

part 'item_model.g.dart'; // Hive will generate this file

@HiveType(typeId: 0)
class ItemModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  ItemModel({required this.id, required this.title, required this.description});
}
