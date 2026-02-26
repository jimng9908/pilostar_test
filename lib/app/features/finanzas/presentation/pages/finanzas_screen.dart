import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/finanzas/index.dart';
import 'package:flutter/material.dart';

class FinanzasScreen extends StatelessWidget {
  const FinanzasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinanzasBloc()..add(LoadFinanceData()),
      child: BlocBuilder<FinanzasBloc, FinanzasState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context, state),
                  Expanded(
                    child: state is FinanzasLoading || state is FinanzasInitial
                        ? const Center(child: CircularProgressIndicator())
                        : state is FinanzasError
                            ? Center(child: Text(state.message))
                            : state is FinanzasLoaded
                                ? ScrollConfiguration(
                                    behavior: ScrollConfiguration.of(context)
                                        .copyWith(
                                      overscroll: false,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          EBITDASection(
                                              data: state.data.ebitda,
                                              isTrimestre: state.isTrimestre),
                                          ComparisonSection(
                                              data:
                                                  state.data.ingresosVsGastos),
                                          HealthRatiosSection(
                                              ratios: state.data.healthRatios),
                                          CategorizedExpensesSection(
                                              expenses: state.data.qExpenses,
                                              isTrimestre: state.isTrimestre),
                                          TreasurySection(
                                              balance:
                                                  state.data.treasuryBalance),
                                          DebtSection(debts: state.data.debts),
                                          const SizedBox(height: 20),
                                          _buildFutterInfo(context),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildHeader(BuildContext context, FinanzasState state) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Finanzas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                Text(
                  state is FinanzasLoaded ? state.data.periodSubtitle : '...',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          PeriodSelector(
            isTrimestre: state is FinanzasLoaded ? state.isTrimestre : true,
            onToggle: (val) =>
                context.read<FinanzasBloc>().add(TogglePeriod(val)),
          ),
          if (state is FinanzasLoaded)
            Container(
              color: AppColor.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context
                        .read<FinanzasBloc>()
                        .add(const NavigatePeriod(-1)),
                    child: Icon(Icons.chevron_left, color: AppColor.primary),
                  ),
                  Text(
                    state.periodDisplay,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context
                        .read<FinanzasBloc>()
                        .add(const NavigatePeriod(1)),
                    child: Icon(Icons.chevron_right, color: AppColor.primary),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  _buildFutterInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: const Color(0x19560BAD),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.65,
              color: const Color(0xFF540BA8) /* Brand-Primary-800 */,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF6A1B9A)),
                Text(
                  '¿Tus datos no coinciden?',
                  style: TextStyle(
                    color: const Color(0xFF540BA8) /* Brand-Primary-800 */,
                    fontSize: 16,
                    fontFamily: 'SF Pro',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ],
            ),
            Text(
              'Si necesitas ver reflejada la información más reciente, contacta con tu gestor para coordinar la actualización.',
              style: TextStyle(
                color: AppColor.primary,
                fontSize: 14,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
