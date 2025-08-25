import 'package:flutter/material.dart';
import 'package:e_market/models/category.dart';
import 'package:e_market/services/category_service.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  bool _isEditing = false;
  int? _editingId;

  late Future<List<Category>> _categories;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    _categories = CategoryService.fetchCategories();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameCtrl.clear();
    _descCtrl.clear();
    _isEditing = false;
    _editingId = null;
  }

  void _populateForm(Category category) {
    _nameCtrl.text = category.name;
    _descCtrl.text = category.description;
    _isEditing = true;
    _editingId = category.id;
  }

  void _saveCategory() async {
    if (_formKey.currentState!.validate()) {
      final category = Category(
        id: _editingId,
        name: _nameCtrl.text,
        description: _descCtrl.text,
      );

      if (_isEditing) {
        await CategoryService.updateCategory(_editingId!, category);
      } else {
        await CategoryService.addCategory(category);
      }

      _resetForm();
      setState(() => _loadCategories());
    }
  }

  void _deleteCategory(int id) async {
    await CategoryService.deleteCategory(id);
    if (_editingId == id) _resetForm();
    setState(() => _loadCategories());
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Categories')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// ----------- Category Form -----------
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _descCtrl,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _saveCategory,
                        child: Text(_isEditing ? 'Update' : 'Add'),
                      ),
                      const SizedBox(width: 10),
                      if (_isEditing)
                        OutlinedButton(
                          onPressed: _resetForm,
                          child: const Text('Cancel'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// ----------- Category List -----------
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: _categories,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final categories = snapshot.data!;
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (_, index) {
                        final c = categories[index];
                        return ListTile(
                          title: Text(c.name),
                          subtitle: Text(c.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => setState(() {
                                  _populateForm(c);
                                }),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteCategory(c.id!),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading categories'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
