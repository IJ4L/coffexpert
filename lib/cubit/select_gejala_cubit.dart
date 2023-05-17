import 'package:bloc/bloc.dart';

class SelectGejalaCubit extends Cubit<int> {
  SelectGejalaCubit() : super(-1);

  void select(int index) => emit(index);
}
