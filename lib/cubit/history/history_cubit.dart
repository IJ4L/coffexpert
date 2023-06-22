import 'package:bloc/bloc.dart';
import 'package:coffe_brain/models/history_model.dart';
import 'package:coffe_brain/services/history_service.dart';
import 'package:equatable/equatable.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryService historyService;

  HistoryCubit({required this.historyService}) : super(HistoryInitial());

  void saveHistory(HistoryModel newHistory) {
    historyService.saveHistory(newHistory);
  }

  Future<void> getAllHistory() async {
    final result = await historyService.getHistory();
    emit(HistoryLoaded(result));
  }

  Future<void> deleteHistory() async {
    emit(HistoryLoading());
    historyService.deleteHistory();
    Future.delayed(const Duration(seconds: 2), () {
      getAllHistory();
    });
  }
}
