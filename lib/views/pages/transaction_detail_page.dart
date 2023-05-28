import 'package:flutter/material.dart';
import 'package:money_manager/blocs/exports.dart';
import 'package:money_manager/core/extention.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:money_manager/views/pages/transaction_add_or_edit_page.dart';
import 'package:money_manager/views/widgets/custom_alert_dialog.dart';

import '../widgets/custom_leading_icon.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({
    Key? key,
    required this.transaction,
  }) : super(key: key);
  static const String id = '/transaction_detail_page';
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final currency =
        context.read<CurrencyFormatterCubit>().state.formatCurrency;

    return Scaffold(
      appBar: AppBar(
          leading: const CustomLeadingIcon(), title: const Text('Detail')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Card(
                child: Column(
                  children: [
                    _customCard(transaction.category.name,
                        currency.format(transaction.transactionAmount)),
                    _customCard(
                        "Transaction",
                        transaction.category.type.name
                            .toCapitalizedFirstLater()),
                    _customCard("Date", transaction.dateTime),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            TransactionAddOrEditPage.id,
                            arguments: {'transaction': transaction});
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Update')),
                ),
                Card(
                  child: OutlinedButton.icon(
                      onPressed: () {
                        customAlertDialog(context,
                            label: 'Do you want to delete this item?',
                            yesOptionLabel: 'Delete', onPressedYesOption: () {
                          context.read<TransactionBloc>().add(
                              DeleteTransactionEvent(transaction: transaction));
                          Navigator.of(context).pop();
                        });
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Delete')),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _customCard(
    String label,
    String labelData,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            overflow: TextOverflow.ellipsis,
          ),
          Text(labelData, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
