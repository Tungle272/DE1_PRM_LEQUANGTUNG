import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../viewmodels/task_provider.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  final TaskModel task;
  const EditTaskScreen({super.key, required this.task});

  @override
  ConsumerState<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(text: widget.task.description);
    _isCompleted = widget.task.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chỉnh sửa công việc')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Tiêu đề *', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: _descController, decoration: const InputDecoration(labelText: 'Mô tả', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Đã hoàn thành', style: TextStyle(fontSize: 16)),
                Switch(value: _isCompleted, onChanged: (val) => setState(() => _isCompleted = val)),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.black), child: const Text('Hủy')),
                ElevatedButton(
                  onPressed: () {
                    final updatedTask = TaskModel(id: widget.task.id, title: _titleController.text, description: _descController.text, isCompleted: _isCompleted);
                    ref.read(taskNotifierProvider.notifier).updateTask(updatedTask);
                    Navigator.pop(context);
                  },
                  child: const Text('Lưu'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}