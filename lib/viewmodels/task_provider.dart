import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/task_model.dart';
import '../services/database_helper.dart';

part 'task_provider.g.dart';

@riverpod
class TaskNotifier extends _$TaskNotifier {
  @override
  FutureOr<List<TaskModel>> build() async {
    return await DatabaseHelper.instance.getTasks();
  }

  Future<void> updateTask(TaskModel task) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await DatabaseHelper.instance.updateTask(task);
      return await DatabaseHelper.instance.getTasks();
    });
  }
}