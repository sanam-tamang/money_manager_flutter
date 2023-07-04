// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/core/extention.dart';
import 'package:money_manager/models/transaction_model.dart';

import '../../blocs/exports.dart';
import '../../core/color_pallete.dart';
import '../../enum/category_type.dart';
import '../pages/transaction_detail_page.dart';

class TrasactionTiles extends StatelessWidget {
  const TrasactionTiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTransactionBloc, FilteredTransactionLoadedState>(
      builder: (context, state) {
        return NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              context.read<TransactionsScrollCubit>().changeScroll(true);
            } else if (notification.direction == ScrollDirection.reverse) {
              context.read<TransactionsScrollCubit>().changeScroll(false);
            }
            return true;
          },
          child: ListView.builder(
              itemCount: state.filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = state.filteredTransactions[index];
                final trnColor =
                    transaction.category.type == TransactionType.income
                        ? ColorPalette.growthColor
                        : ColorPalette.textColor;
                final plusOrMinusSign =
                    transaction.category.type == TransactionType.income
                        ? '+'
                        : '-';
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),

                      // color: Colors.grey[100],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: _TransactionsMainTile(
                          transaction: transaction,
                          plusOrMinusSign: plusOrMinusSign,
                          trnColor: trnColor),
                    ),
                  ],
                );
              }),
        );
      },
    );
  }
}

final formatter = NumberFormat.currency(locale: "en_US", symbol: "\$");

class _TransactionsMainTile extends StatelessWidget {
  const _TransactionsMainTile({
    Key? key,
    required this.transaction,
    required this.plusOrMinusSign,
    required this.trnColor,
  }) : super(key: key);

  final Transaction transaction;
  final String plusOrMinusSign;
  final Color trnColor;

  @override
  Widget build(BuildContext context) {
    final currency =
        context.read<CurrencyFormatterCubit>().state.formatCurrency;
    return Card(
      elevation: 1,
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(TransactionDetailPage.id,
              arguments: {'transaction': transaction});
        },
        tileColor: ColorPalette.backgroundColor.withOpacity(0.2),
        title: Text(
          transaction.category.name,
          style: const TextStyle(color: ColorPalette.textColor),
        ),
        subtitle:
            Text(transaction.category.type.name.toCapitalizedFirstLater()),
        trailing: Text(
          "$plusOrMinusSign ${currency.format(transaction.transactionAmount)}",
          style: Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: trnColor,
              ),
        ),
      ),
    );
  }
}
