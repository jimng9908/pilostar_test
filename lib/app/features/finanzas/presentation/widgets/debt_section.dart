import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rockstardata_apk/app/core/core.dart';
import 'package:rockstardata_apk/app/features/finanzas/index.dart';

class DebtSection extends StatelessWidget {
  final List<DebtItem> debts;

  const DebtSection({super.key, required this.debts});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Deuda a Corto Plazo',
              style: TextStyle(
                color: Colors.black /* Brand-Greyscale-1000 */,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.50,
                letterSpacing: -0.45,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total pendiente',
              style: TextStyle(
                color: const Color(0xFF6B6B6B),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.47,
                letterSpacing: -0.38,
              ),
            ),
            Text(
              '${NumberFormat.decimalPattern('es_ES').format(debts.fold(0.0, (sum, item) => sum + item.amount))}€',
              style: TextStyle(
                color: Colors.black /* Brand-Greyscale-1000 */,
                fontSize: 26,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.30,
                letterSpacing: -0.04,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildTableHeader(),
                  ...debts.map((item) => _buildTableRow(item)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Acreedor',
              style: TextStyle(
                  color: AppColor.black.withValues(alpha: 0.7), fontSize: 12)),
          Text('Importe',
              style: TextStyle(
                  color: AppColor.black.withValues(alpha: 0.7), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTableRow(DebtItem item) {
    IconData iconData = Icons.help_outline;
    Color iconColor = Colors.blue;

    if (item.creditor == 'Bancos') {
      iconData = Icons.account_balance;
      iconColor = Colors.blue;
    } else if (item.creditor == 'Hacienda') {
      iconData = Icons.receipt_long;
      iconColor = Colors.redAccent;
    } else if (item.creditor == 'Seguridad Social') {
      iconData = Icons.health_and_safety_outlined;
      iconColor = Colors.green;
    } else if (item.creditor == 'Personal') {
      iconData = Icons.person_outline;
      iconColor = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(iconData, size: 18, color: iconColor),
              const SizedBox(width: 12),
              Text(item.creditor,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          Text(
            '${NumberFormat.decimalPattern('es_ES').format(item.amount)}€',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
