import 'package:hive/hive.dart';
import '../model/item_model.dart';

class LocalStorageService {
  static const String boxName = 'itemsBox';

  static Future<void> init() async {
    Hive.registerAdapter(ItemModelAdapter());
    await Hive.openBox<ItemModel>(boxName);
  }

  static Box<ItemModel> get _box => Hive.box<ItemModel>(boxName);

  static List<ItemModel> getAllItems() => _box.values.toList();

  static Future<void> addItem(ItemModel item) async {
    await _box.add(item); // ✅ Auto-increment key, no manual ID needed
  }

  static Future<void> updateItem(ItemModel item) async {
    await item.save(); // ✅ Directly updates existing object
  }

  static Future<void> deleteItem(int index) async {
    await _box.deleteAt(index);
  }
}
