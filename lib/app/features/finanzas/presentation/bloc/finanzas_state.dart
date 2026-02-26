part of 'finanzas_bloc.dart';

abstract class FinanzasState extends Equatable {
  const FinanzasState();

  @override
  List<Object> get props => [];
}

class FinanzasInitial extends FinanzasState {}

class FinanzasLoading extends FinanzasState {}

class FinanzasLoaded extends FinanzasState {
  final FinanceData data;
  final bool isTrimestre;
  final int year;
  final int quarter; // 1-4

  const FinanzasLoaded({
    required this.data,
    required this.isTrimestre,
    this.year = 2025,
    this.quarter = 4,
  });

  String get periodDisplay => isTrimestre ? 'Q$quarter $year' : '$year';

  String get subPeriodDisplay {
    if (!isTrimestre) return 'Enero - Diciembre';
    switch (quarter) {
      case 1:
        return 'Ene-Mar';
      case 2:
        return 'Abr-Jun';
      case 3:
        return 'Jul-Sep';
      case 4:
        return 'Oct-Dic';
      default:
        return '';
    }
  }

  @override
  List<Object> get props => [data, isTrimestre, year, quarter];

  FinanzasLoaded copyWith({
    FinanceData? data,
    bool? isTrimestre,
    int? year,
    int? quarter,
  }) {
    return FinanzasLoaded(
      data: data ?? this.data,
      isTrimestre: isTrimestre ?? this.isTrimestre,
      year: year ?? this.year,
      quarter: quarter ?? this.quarter,
    );
  }
}

class FinanzasError extends FinanzasState {
  final String message;
  const FinanzasError(this.message);

  @override
  List<Object> get props => [message];
}
