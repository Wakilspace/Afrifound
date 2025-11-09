import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/item_model.dart';
import '../services/local_storage_service.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, List<ItemModel>>(
      (ref) => HomeViewModel(),
    );

class HomeViewModel extends StateNotifier<List<ItemModel>> {
  HomeViewModel() : super([]) {
    _loadItems();
  }

  void _loadItems() {
    state = LocalStorageService.getAllItems();
  }

  Future<void> addItem(String title, String description) async {
    final newItem = ItemModel(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
    );
    await LocalStorageService.addItem(newItem);
    _loadItems();
  }

  Future<void> updateItem(
    ItemModel item,
    String title,
    String description,
  ) async {
    item.title = title;
    item.description = description;
    await LocalStorageService.updateItem(item);
    _loadItems();
  }

  Future<void> deleteItemAt(int index) async {
    await LocalStorageService.deleteItem(index);
    _loadItems();
  }
}
