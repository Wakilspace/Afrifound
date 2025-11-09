import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/item_model.dart';
import '../viewmodel/home_viewmodel.dart';

class AddEditScreen extends ConsumerStatefulWidget {
  final ItemModel? existingItem;

  const AddEditScreen({super.key, this.existingItem});

  @override
  ConsumerState<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends ConsumerState<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.existingItem?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.existingItem?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingItem == null ? "Add Item" : "Edit Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter a title" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.existingItem == null) {
                      await viewModel.addItem(
                        _titleController.text.trim(),
                        _descriptionController.text.trim(),
                      );
                    } else {
                      await viewModel.updateItem(
                        widget.existingItem!,
                        _titleController.text.trim(),
                        _descriptionController.text.trim(),
                      );
                    }
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                child: Text(widget.existingItem == null ? "Add" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
