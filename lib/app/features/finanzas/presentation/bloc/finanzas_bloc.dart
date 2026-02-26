import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rockstardata_apk/app/features/finanzas/domain/entities/finance_models.dart';

part 'finanzas_event.dart';
part 'finanzas_state.dart';

class FinanzasBloc extends Bloc<FinanzasEvent, FinanzasState> {
  FinanzasBloc() : super(FinanzasInitial()) {
    on<LoadFinanceData>(_onLoadFinanceData);
    on<TogglePeriod>(_onTogglePeriod);
    on<NavigatePeriod>(_onNavigatePeriod);
  }

  void _onLoadFinanceData(LoadFinanceData event, Emitter<FinanzasState> emit) {
    emit(FinanzasLoading());
    // Starting Period: Current Year and Quarter
    final now = DateTime.now();
    final year = now.year;
    final quarter = ((now.month - 1) ~/ 3) + 1;

    final mockData = _getMockData(year, quarter, true);
    emit(FinanzasLoaded(
        data: mockData, isTrimestre: true, year: year, quarter: quarter));
  }

  void _onNavigatePeriod(NavigatePeriod event, Emitter<FinanzasState> emit) {
    if (state is FinanzasLoaded) {
      final currentState = state as FinanzasLoaded;
      final now = DateTime.now();
      final currentYear = now.year;
      final currentQuarter = ((now.month - 1) ~/ 3) + 1;

      int newYear = currentState.year;
      int newQuarter = currentState.quarter;

      if (currentState.isTrimestre) {
        newQuarter += event.delta;
        if (newQuarter > 4) {
          newQuarter = 1;
          newYear++;
        } else if (newQuarter < 1) {
          newQuarter = 4;
          newYear--;
        }

        // Check bounds: cannot be future
        if (newYear > currentYear ||
            (newYear == currentYear && newQuarter > currentQuarter)) {
          return;
        }
      } else {
        newYear += event.delta;
        // Check bounds: cannot be future
        if (newYear > currentYear) {
          return;
        }
      }

      final newData =
          _getMockData(newYear, newQuarter, currentState.isTrimestre);
      emit(currentState.copyWith(
        year: newYear,
        quarter: newQuarter,
        data: newData,
      ));
    }
  }

  FinanceData _getMockData(int year, int quarter, bool isTrimestre) {
    final periodStr = isTrimestre ? 'Q$quarter $year' : '$year';
    final subPeriod = isTrimestre
        ? (quarter == 1
            ? '(Ene-Mar)'
            : quarter == 2
                ? '(Abr-Jun)'
                : quarter == 3
                    ? '(Jul-Sep)'
                    : '(Oct-Dic)')
        : '(Ene-Dic)';

    return FinanceData(
      periodSubtitle: '$periodStr $subPeriod',
      ebitda: const EBITDAData(
        value: 41200,
        profitabilityPercentage: 19,
        growthPercentage: 18.5,
      ),
      ingresosVsGastos: const ComparisonData(
        ingresos: 86420,
        gastos: 46420,
        incomeGoal: 80000,
        expenseGoal: 40000,
      ),
      healthRatios: const [
        RatioData(
          label: 'Personal',
          percentage: 31,
          status: 'Dentro de objetivo',
          currentAmount: 16420,
          targetAmount: 50000,
        ),
        RatioData(
          label: 'Materia Prima',
          percentage: 28,
          status: 'Óptimo',
          currentAmount: 6420,
          targetAmount: 50000,
        ),
      ],
      qExpenses: const [
        CategorizedExpense(label: 'RRHH', amount: 66400, percentage: 32),
        CategorizedExpense(label: 'Compras', amount: 60200, percentage: 29),
        CategorizedExpense(
            label: 'Servicios Exteriores', amount: 20500, percentage: 10),
        CategorizedExpense(label: 'Tributos', amount: 11800, percentage: 6),
        CategorizedExpense(
            label: 'Gastos Financieros', amount: 7250, percentage: 3),
        CategorizedExpense(label: 'Marketing', amount: 4000, percentage: 2),
      ],
      treasuryBalance: 18500,
      debts: const [
        DebtItem(creditor: 'Bancos', amount: 11000, icon: 'bank'),
        DebtItem(creditor: 'Hacienda', amount: 5000, icon: 'tax'),
        DebtItem(creditor: 'Seguridad Social', amount: 3800, icon: 'safety'),
        DebtItem(creditor: 'Personal', amount: 2000, icon: 'person'),
      ],
    );
  }

  void _onTogglePeriod(TogglePeriod event, Emitter<FinanzasState> emit) {
    if (state is FinanzasLoaded) {
      final currentState = state as FinanzasLoaded;
      emit(currentState.copyWith(isTrimestre: event.isTrimestre));
    }
  }
}
