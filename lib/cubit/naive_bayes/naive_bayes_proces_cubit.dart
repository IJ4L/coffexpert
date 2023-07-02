import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/prediction_model.dart';
import '../../services/naive_bayes.dart';

part 'naive_bayes_proces_state.dart';

class NaiveBayesProcesCubit extends Cubit<NaiveBayesProcesState> {
  NaiveBayesProcesCubit() : super(NaiveBayesProcesInitial());

  void onPredict(List<String> selectedGejala) async {
    emit(NaiveBayesProcesLoading());
    if (selectedGejala.length < 2) {
      emit(const NaiveBayesProcesFailure('Pilih Gejala !! (2 sampai 4)'));
    } else {
      final result = await procesOfNaiveBayes(selectedGejala);
      result.fold(
        (message) => emit(NaiveBayesProcesFailure(message)),
        (value) => emit(NaiveBayesProcesLoaded(value, value.gejala)),
      );
    }
  }
}
