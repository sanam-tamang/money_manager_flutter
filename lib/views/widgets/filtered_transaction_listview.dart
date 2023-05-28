import 'package:flutter/material.dart';
import 'package:money_manager/core/color_pallete.dart';
import 'package:money_manager/core/extention.dart';

import '../../blocs/exports.dart';
import '../../enum/category_type.dart';

class FilteredTransactionLIstView extends StatelessWidget {
  const FilteredTransactionLIstView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<FilteredTransactionBloc,
          FilteredTransactionLoadedState>(
        builder: (context, state) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = state.filteredTransactions[index];
                return Column(
                  children: [
                    ///
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),

                      // color: Colors.grey[100],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: ListTile(
                        onLongPress: () {
                          context.read<TransactionBloc>().add(
                              DeleteTransactionEvent(
                                  transaction: transaction));
                        },
                        tileColor: transaction.category.type ==
                                TransactionType.income
                            ? ColorPalette.growthColor
                            : ColorPalette.cautionColor,
                        title: Text(
                          transaction.category.name,
                          style: const TextStyle(
                              color: ColorPalette.textColor),
                        ),
                        subtitle: Text(transaction.category.type.name
                            .toCapitalizedFirstLater()),
                        trailing: Text(
                            transaction.transactionAmount.toString()),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
