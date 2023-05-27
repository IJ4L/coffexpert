import 'package:bloc/bloc.dart';

class UpdownCubit extends Cubit<int> {
  UpdownCubit() : super(-1);

  void klik(int index) => emit(index);
}
