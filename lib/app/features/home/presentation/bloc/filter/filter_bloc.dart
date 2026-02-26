import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState("Hoy")) {
    on<ChangeFilterEvent>((event, emit) {
      emit(FilterState(event.selectedFilter));
    });
  }
}
