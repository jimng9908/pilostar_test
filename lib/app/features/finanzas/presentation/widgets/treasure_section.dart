import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TreasurySection extends StatelessWidget {
  final double balance;

  const TreasurySection({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.account_balance_wallet_outlined,
                    color: Colors.pinkAccent),
                const SizedBox(width: 12),
                Text('Saldo de Tesorería',
                    style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            Text(
              '${NumberFormat.decimalPattern('es_ES').format(balance)}€',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
