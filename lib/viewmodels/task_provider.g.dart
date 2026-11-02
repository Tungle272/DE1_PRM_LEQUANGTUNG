// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskNotifier)
final taskProvider = TaskNotifierProvider._();

final class TaskNotifierProvider
    extends $AsyncNotifierProvider<TaskNotifier, List<TaskModel>> {
  TaskNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskNotifierHash();

  @$internal
  @override
  TaskNotifier create() => TaskNotifier();
}

String _$taskNotifierHash() => r'ab1b94db1eba90fc3dc90b6c57a0d5af07d0925b';

abstract class _$TaskNotifier extends $AsyncNotifier<List<TaskModel>> {
  FutureOr<List<TaskModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<TaskModel>>, List<TaskModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<TaskModel>>, List<TaskModel>>,
              AsyncValue<List<TaskModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
