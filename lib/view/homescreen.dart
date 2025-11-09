import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/home_viewmodel.dart';
import '../viewmodel/theme_viewmodel.dart';
import 'add_edit_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Items"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              ref.watch(themeProvider) == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text("No items yet. Tap + to add."))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Dismissible(
                  key: Key(item.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) async {
                    await viewModel.deleteItemAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item deleted')),
                    );
                  },
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.description),
                    trailing: const Icon(Icons.edit),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddEditScreen(existingItem: item),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
