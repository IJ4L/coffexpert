import 'package:bloc/bloc.dart';
import 'package:coffe_brain/services/machine_service.dart';
import 'package:equatable/equatable.dart';

import '../../models/prediction_model.dart';

part 'naive_bayes_proces_state.dart';

class NaiveBayesProcesCubit extends Cubit<NaiveBayesProcesState> {
  NaiveBayesProcesCubit() : super(NaiveBayesProcesInitial());

  void onPredict(List<String> selectedGejala) async {
    emit(NaiveBayesProcesLoading());

    final result = await procesNaiveBayes(selectedGejala);
    result.fold(
      (message) => emit(NaiveBayesProcesFailure(message)),
      (value) => emit(NaiveBayesProcesLoaded(value, value.gejala)),
    );
  }
}
