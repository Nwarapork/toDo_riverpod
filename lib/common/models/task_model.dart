
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'task_model.g.dart';
part 'task_model.freezed.dart';
@freezed
class TaskModel with _$TaskModel {
  factory TaskModel({
    int? id,
    String? title,
    String? desc,
    int? isCompleted,
    String? date,
    String? startTime,
    String? endTime,
    int? remind,
    String? repeat,
  
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}