import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/task_provider.dart';
import '../viewmodels/theme_provider.dart';
import 'edit_task_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _showColorPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Chọn màu thanh ứng dụng', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _colorCircle(context, ref, Colors.blue),
                  _colorCircle(context, ref, Colors.green),
                  _colorCircle(context, ref, Colors.purple),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Đóng'))
            ],
          ),
        );
      },
    );
  }

  Widget _colorCircle(BuildContext context, WidgetRef ref, Color color) {
    final currentColor = ref.watch(themeNotifierProvider);
    return GestureDetector(
      onTap: () {
        ref.read(themeNotifierProvider.notifier).changeColor(color);
        Navigator.pop(context);
      },
      child: CircleAvatar(
        backgroundColor: color,
        radius: 25,
        child: currentColor.toARGB32() == color.toARGB32() ? const Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsyncValue = ref.watch(taskNotifierProvider);
    final themeColor = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý công việc'),
        backgroundColor: themeColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.palette), onPressed: () => _showColorPicker(context, ref)),
        ],
      ),
      body: tasksAsyncValue.when(
        data: (tasks) => ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return ListTile(
              leading: Icon(Icons.check_box_outline_blank, color: themeColor),
              title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(task.description),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditTaskScreen(task: task))),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Lỗi: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}