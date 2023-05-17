import 'package:bloc/bloc.dart';

class SelectGejalaCubit extends Cubit<List<int>> {
  SelectGejalaCubit() : super([]);

  void select(int index) {
    List<int> newState = List.from(state);
    newState.add(index);
    emit(newState);
  }

  void unselect(int index) {
    List<int> newState = List.from(state);
    newState.remove(index);
    emit(newState);
  }
}
