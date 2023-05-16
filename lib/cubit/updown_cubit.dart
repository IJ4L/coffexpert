import 'package:bloc/bloc.dart';

class UpdownCubit extends Cubit<bool> {
  UpdownCubit() : super(false);

  void klik() => emit(!state);
}
