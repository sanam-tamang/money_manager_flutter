// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../blocs/exports.dart';
import '../../core/color_pallete.dart';
import '../../core/get_percentage.dart';
import '../widgets/no_data_available_widget.dart';

class IncomeExpensePage extends StatefulWidget {
  const IncomeExpensePage({
    Key? key,
  }) : super(key: key);

  @override
  State<IncomeExpensePage> createState() => _IncomeExpensePageState();
}

class _IncomeExpensePageState extends State<IncomeExpensePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTransactionBloc, FilteredTransactionLoadedState>(
      builder: (context, state) {
        final theme = Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
            color: ColorPalette.textColor, fontWeight: FontWeight.w500);
        final Map<String, double> transactionTotals = {
          "Income": state.totalIncome,
          "Expense": state.totalExpenses,
        };
        return state.filteredTransactions.isNotEmpty
            ? ListView(children: [
                SizedBox(
                  height: 300,
                  child: Card(
                    elevation: 0.6,
                    child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 0,
                          startDegreeOffset: 290,
                          sections: transactionTotals.entries.map((e) {
                            return PieChartSectionData(
                                badgePositionPercentageOffset: 1,
                                badgeWidget: Card(
                                  child: Text(
                                    "${getPercentage(e.value, (state.totalExpenses + state.totalIncome))}%",
                                    style: theme,
                                  ),
                                ),
                                showTitle: false,
                                radius: 100,
                                color: e.key == "Income"
                                    ? ColorPalette.growthColor
                                    : ColorPalette.cautionColor,
                                value: getPercentage(e.value,
                                    (state.totalExpenses + state.totalIncome)));
                          }).toList(),
                        ),
                        swapAnimationDuration:
                            const Duration(milliseconds: 1300),
                        swapAnimationCurve: Curves.decelerate),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 0.4,
                  child: Column(
                    children: [
                      _TrnAmountCard(
                        amountLabel: 'Balance',
                        amount: state.totalAmount,
                        icon: Icons.savings_outlined,
                        color: Colors.black38,
                      ),
                      _TrnAmountCard(
                        amountLabel: 'Income',
                        amount: state.totalIncome,
                        icon: Icons.arrow_downward_outlined,
                        color: ColorPalette.growthColor,
                      ),
                      _TrnAmountCard(
                        amountLabel: 'Expense',
                        amount: state.totalExpenses,
                        icon: Icons.arrow_upward_outlined,
                        color: ColorPalette.cautionColor,
                      ),
                    ],
                  ),
                ),
              ])
            : const NoDataAvailableWidget();
      },
    );
  }
}

class _TrnAmountCard extends StatelessWidget {
  const _TrnAmountCard({
    Key? key,
    required this.amountLabel,
    required this.amount,
    required this.icon,
    required this.color,
  }) : super(key: key);
  final String amountLabel;
  final double amount;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .primaryTextTheme
        .bodyText1
        ?.copyWith(color: ColorPalette.textColor, fontSize: 14);
    final currency =
        context.read<CurrencyFormatterCubit>().state.formatCurrency;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          foregroundColor: Colors.white,
          child: Icon(icon),
        ),
        title: Text(amountLabel, style: textTheme),
        trailing: Text(
          currency.format(amount),
          style: textTheme,
        ),
      ),
    );
  }
}
