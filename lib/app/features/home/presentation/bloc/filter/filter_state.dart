part of 'filter_bloc.dart';

class FilterState extends Equatable {
  final String filter;
  const FilterState(this.filter);

  @override
  List<Object> get props => [filter];
}
