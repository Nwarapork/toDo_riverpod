import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/models/task_model.dart';
import 'package:riverpod_todo/feature/todo/controllers/todo/todo_provider.dart';
import 'package:riverpod_todo/feature/todo/widgets/todo_tile.dart';

class TodayTasks extends ConsumerWidget {
  const TodayTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(todoStateProvider);
    String today = ref.read(todoStateProvider.notifier).getToday();
    var todayList = listData
        .where((element) =>
            element.isCompleted == 0 && element.date!.contains(today))
        .toList();

    return ListView.builder(
        itemCount: todayList.length,
        itemBuilder: ((context, index) {
          final data = todayList[index];
          bool isCompleted =
              ref.read(todoStateProvider.notifier).getStatus(data);
          Color color = ref.read(todoStateProvider.notifier).getRandomColor();
          return TodoTile(
            delete: () {
              ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
            },
            editWidget: GestureDetector(
              onTap: () {

              },
              child: const Icon(MaterialCommunityIcons.circle_edit_outline),
            ),
            title: data.title,
            color: color,
            description: data.desc,
            start: data.startTime,
            end: data.endTime,
            switcher: Switch(
              value: isCompleted,
              onChanged: (value) {},
            ),
          );
        }));
  }
}
