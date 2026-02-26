part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
  @override
  List<Object> get props => [];
}

class ChangeFilterEvent extends FilterEvent {
  final String selectedFilter;
  const ChangeFilterEvent(this.selectedFilter);

  @override
  List<Object> get props => [selectedFilter];
}
