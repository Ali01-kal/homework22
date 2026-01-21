import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entity/movie_entity.dart';
import '../controller/movie_controller.dart';

class MovieAddScreen extends StatefulWidget {
  const MovieAddScreen({super.key});
  @override State<MovieAddScreen> createState() => _MovieAddScreenState(); }

class _MovieAddScreenState extends State<MovieAddScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final year = int.tryParse(_yearController.text);
    if (year == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid year")));
      return;
    }

    final movie = MovieEntity(
      id: DateTime.now().microsecondsSinceEpoch,
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      year: year,
    );

    context.read<MovieController>().addMovie(movie);
    Navigator.pop(context);
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      validator: (v) => v == null || v.isEmpty ? "Enter $label" : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Movie")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(controller: _titleController, label: "Title"),
              _buildField(controller: _descController, label: "Description"),
              _buildField(
                controller: _yearController,
                label: "Year",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Add Movie"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
