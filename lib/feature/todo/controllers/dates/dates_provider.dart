import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dates_provider.g.dart';

@riverpod // riverpod annotation
class DateState extends _$DateState {
  @override
  String build() {
    return "";
  }

  void setDate(String newState) {
    state = newState;
  }

}

@riverpod // riverpod annotation
class StartTimeState extends _$StartTimeState {
  @override
  String build() {
    return "";
  }

  void setStart(String newState) {
    state = newState;
  }
  
}

@riverpod // riverpod annotation
class FinishTimeState extends _$FinishTimeState {
  @override
  String build() {
    return "";
  }

  void setStart(String newState) {
    state = newState;
  }
  
}