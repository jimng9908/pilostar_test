part of 'finanzas_bloc.dart';

abstract class FinanzasEvent extends Equatable {
  const FinanzasEvent();

  @override
  List<Object> get props => [];
}

class LoadFinanceData extends FinanzasEvent {}

class TogglePeriod extends FinanzasEvent {
  final bool isTrimestre;
  const TogglePeriod(this.isTrimestre);

  @override
  List<Object> get props => [isTrimestre];
}

class NavigatePeriod extends FinanzasEvent {
  final int delta;
  const NavigatePeriod(this.delta);

  @override
  List<Object> get props => [delta];
}
