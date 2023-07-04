import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../core/color_pallete.dart';

import '../../blocs/exports.dart';

class ShowTransactionAmountHeadingCard extends StatelessWidget {
  const ShowTransactionAmountHeadingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTransactionBloc, FilteredTransactionLoadedState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _TransactionsAmount(
                amount: state.totalIncome,
                label: 'Income',
              ),
            ),
            Expanded(
              child: _TransactionsAmount(
                amount: state.totalExpenses,
                label: 'Expense',
              ),
            ),
            Expanded(
              child: _TransactionsAmount(
                amount: state.totalAmount,
                label: 'Total',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TransactionsAmount extends StatelessWidget {
  const _TransactionsAmount({required this.amount, required this.label});
  final double amount;
  final String label;
  @override
  Widget build(BuildContext context) {
    final currency =
        context.read<CurrencyFormatterCubit>().state.formatCurrency;
    TextStyle? style = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: ColorPalette.textColor,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Column(
        children: [
          Text(label, style: style?.copyWith(fontSize: 15)),
          AutoSizeText(
            currency.format(amount),
            maxLines: 1,
            minFontSize: 8,
            maxFontSize: 16,
            style: style,
          ),
        ],
      ),
    );
  }
}
