import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:rockstardata_apk/app/features/profile/index.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Objetivos y Metas",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileLoaded) {
            final goals = state.goals;
            return ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(overscroll: false),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Info Context
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColor.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info_outline,
                                  color: AppColor.primary, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Configura tus objetivos",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Define tus metas y recibe avisos de progreso. Edítalas cuando quieras",
                            style: TextStyle(
                                color: AppColor.primary.withValues(alpha: 0.7),
                                fontSize: 13),
                          ),
                          const SizedBox(height: 15),
                          CustomButton(
                            text: "Crear objetivo",
                            onPressed: () {
                              context
                                  .read<ProfileBloc>()
                                  .add(const InitGoalForm());
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (ctx) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                      value: context.read<ProfileBloc>(),
                                    ),
                                  ],
                                  child: const GoalBottomSheet(),
                                ),
                              );
                            },
                            backgroundColor: AppColor.primary,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Goals List
                    ...goals.map((goal) => _GoalCard(goal: goal)),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text("Error loading goals"));
        },
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final ProfileGoal goal;

  const _GoalCard({required this.goal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goal.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    goal.subtitle,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit_outlined,
                        color: Colors.grey[600], size: 20),
                    onPressed: () {
                      context.read<ProfileBloc>().add(InitGoalForm(goal: goal));
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (ctx) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: context.read<ProfileBloc>(),
                            ),
                          ],
                          child: const GoalBottomSheet(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline,
                        color: Colors.red[300], size: 20),
                    onPressed: () {
                      context.read<ProfileBloc>().add(DeleteGoal(goal.id));
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Progreso actual",
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text(
                "${NumberFormat.decimalPattern('es_ES').format(goal.currentAmount)} € / ${NumberFormat.decimalPattern('es_ES').format(goal.targetAmount)} €",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: goal.progress,
              backgroundColor: Colors.grey[200],
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF6200EA)),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.greyLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.trending_up,
                        color: Colors.green, size: 16),
                    const SizedBox(width: 8),
                    const Text("vs. año pasado",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "+${NumberFormat.decimalPattern('es_ES').format(goal.progressVsLastYear)} %",
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    Text(
                      "${NumberFormat.decimalPattern('es_ES').format(goal.amountVsLastYear)} €",
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _AlertBox(
                  label: "Umbral alerta",
                  value:
                      "${NumberFormat.decimalPattern('es_ES').format(goal.alertThreshold)}%",
                  color: Color(0xFFFFD6A7),
                  textcolor: Color(0xFFC93400),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _AlertBox(
                  label: "Umbral crítico",
                  value:
                      "${NumberFormat.decimalPattern('es_ES').format(goal.criticalThreshold)}%",
                  color: Color(0xFFFFC9C9),
                  textcolor: Color(0xFFC10007),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _AlertBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Color textcolor;

  const _AlertBox({
    required this.label,
    required this.value,
    required this.color,
    required this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: textcolor,
              fontSize: 11,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  color: Color(0xFF7E2A0B),
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
