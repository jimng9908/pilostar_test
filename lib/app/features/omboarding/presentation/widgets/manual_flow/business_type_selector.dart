import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/omboarding/business_omboarding.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';

class BusinessTypeSelection extends StatelessWidget {
  BusinessTypeSelection({super.key});

  // Lista de datos basada en tu imagen principal
  final List<BusinessType> businesses = [
    BusinessType(
        title: 'Cafetería',
        description: 'Desayunos, café y pasteles.',
        imagen: 'assets/icons/cafeteria_icon.png'),
    BusinessType(
        title: 'Bar / Pub',
        description: 'Bares, pubs, cervecerías, tabernas',
        imagen: 'assets/icons/bar_icon.png'),
    BusinessType(
        title: 'Restaurante',
        description: 'Restaurantes, comedores, bistros.',
        imagen: 'assets/icons/restaurant_icon.png'),
    BusinessType(
        title: 'Fast casual',
        description: 'Cómida rápida de calidad',
        imagen: 'assets/icons/fast_casual_icon.png'),
    BusinessType(
        title: 'Pizzería',
        description: 'Pizza y comida italiana',
        imagen: 'assets/icons/pizzeria_icon.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
            builder: (context, state) {
              final currentSelected = state is BusinessOnboardingLoaded &&
                      state.businessType.isNotEmpty
                  ? state.businessType
                  : null;
              return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: false,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: businesses.length,
                itemBuilder: (context, index) {
                  final item = businesses[index];
                  return _BusinessCard(
                    business: item,
                    isSelected: currentSelected == item.title,
                    onSelect: () {
                      context.read<BusinessOnboardingBloc>().add(
                            BuisinessTypeSelected(businessType: item.title),
                          );
                    },
                  );
                },
              );
            },
          ),
        ),
        BlocBuilder<BusinessOnboardingBloc, BusinessOnboardingState>(
          builder: (context, state) {
            final currentSelected = state is BusinessOnboardingLoaded &&
                    state.businessType.isNotEmpty
                ? state.businessType
                : null;
            return _buildFooterButtons(context, currentSelected);
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Tipo de negocio',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 22,
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w500,
              height: 1.30,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 345,
            child: Text(
              'Selecciona el tipo que mejor describe tu establecimiento',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF495565),
                fontSize: 16,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButtons(BuildContext context, String? selectedType) {
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CustomButton(
              text: 'Siguiente',
              textColor: AppColor.white,
              onPressed: selectedType != null
                  ? () {
                      context.read<BusinessOnboardingBloc>().add(
                            SubmitBusinessType(businessType: selectedType),
                          );
                    }
                  : null,
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'Atrás',
              textColor: AppColor.purple,
              backgroundColor: AppColor.greyDark.withValues(alpha: 0.3),
              onPressed: () {
                context.read<BusinessOnboardingBloc>().add(BackToPrevious());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BusinessCard extends StatelessWidget {
  final BusinessType business;
  final bool isSelected;
  final VoidCallback onSelect;

  const _BusinessCard({
    required this.business,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColor.primary : Colors.grey.shade100,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColor.primary.withValues(alpha: 0.1)
                  : AppColor.black.withValues(alpha: 0.03),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(business.imagen, width: 40, height: 40),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        business.title,
                        style: TextStyle(
                          color: const Color(0xFF1A171C),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 1.50,
                          letterSpacing: -0.31,
                        ),
                      ),
                      Text(
                        business.description,
                        style: TextStyle(
                          color: const Color(0xFF495565),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                          letterSpacing: -0.15,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: AppColor.primary, size: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
