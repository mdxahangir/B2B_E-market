import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../models/subcategory.dart';
import '../../services/category_service.dart';
import '../../services/subcategory_service.dart';

class AddSubCategoryScreen extends StatefulWidget {
  const AddSubCategoryScreen({super.key});

  @override
  State<AddSubCategoryScreen> createState() => _AddSubCategoryScreenState();
}

class _AddSubCategoryScreenState extends State<AddSubCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final SubCategoryService _subService = SubCategoryService();

  late TextEditingController _nameController;
  late TextEditingController _descController;

  bool _isEditMode = false;
  int? _editingId;

  late Future<List<SubCategory>> _subcategories;
  late Future<List<Category>> _categoriesFuture;

  int? _selectedCategoryId;
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _loadData();
  }

  void _loadData() {
    _subcategories = _subService.fetchAll();
    _categoriesFuture = CategoryService.fetchCategories();
    _categoriesFuture.then((value) => setState(() => _categories = value));
  }

  void _refresh() {
    setState(() {
      _loadData();
    });
  }

  void _startEditing(SubCategory sub) {
    setState(() {
      _isEditMode = true;
      _editingId = sub.id;
      _nameController.text = sub.name;
      _descController.text = sub.description ?? '';
      _selectedCategoryId = sub.categoryId;
    });
  }

  void _resetForm() {
    setState(() {
      _isEditMode = false;
      _editingId = null;
      _nameController.clear();
      _descController.clear();
      _selectedCategoryId = null;
    });
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final subCategory = SubCategory(
      id: _editingId,
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      categoryId: _selectedCategoryId,
    );

    if (_isEditMode) {
      await _subService.update(_editingId!, subCategory);
    } else {
      await _subService.create(subCategory);
    }

    _resetForm();
    _refresh();
  }

  void _delete(int id) async {
    await _subService.delete(id);
    if (_editingId == id) _resetForm();
    _refresh();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Subcategories")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ---------- Subcategory Form ----------
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: "Name"),
                    validator: (val) =>
                        val == null || val.isEmpty ? "Name is required" : null,
                  ),
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(labelText: "Description"),
                  ),
                  const SizedBox(height: 10),

                  /// 🔽 Category Dropdown
                  DropdownButtonFormField<int>(
                    value: _selectedCategoryId,
                    decoration: const InputDecoration(labelText: "Select Category"),
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                        value: category.id,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedCategoryId = value);
                    },
                    validator: (val) => val == null ? 'Category required' : null,
                  ),
                  const SizedBox(height: 10),

                  /// Submit & Cancel Buttons
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(_isEditMode ? "Update" : "Create"),
                      ),
                      const SizedBox(width: 10),
                      if (_isEditMode)
                        OutlinedButton(
                          onPressed: _resetForm,
                          child: const Text("Cancel"),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ---------- Subcategory List ----------
            Expanded(
              child: FutureBuilder<List<SubCategory>>(
                future: _subcategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final items = snapshot.data!;
                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final sub = items[index];
                      final categoryName = _categories
                          .firstWhere((c) => c.id == sub.categoryId,
                              orElse: () => Category(id: 0, name: 'Unknown', description: ''))
                          .name;

                      return ListTile(
                        title: Text(sub.name),
                        subtitle: Text("${sub.description ?? ''}\nCategory: $categoryName"),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _startEditing(sub),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _delete(sub.id!),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
