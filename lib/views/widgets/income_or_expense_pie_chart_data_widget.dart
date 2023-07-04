

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:money_manager/core/get_percentage.dart';
import 'package:money_manager/views/widgets/no_data_available_widget.dart';

import '../../blocs/exports.dart';

class IncomeOrExpensePieChartData extends StatelessWidget {
  const IncomeOrExpensePieChartData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCategoryWithAmountBloc,
        FilterCategoryWithAmountState>(
      builder: (context, state) {
        return state.filteredList.isNotEmpty
            ? ListView(
                children: [
                  _PieChart(
                    fltrCtgWithAmountState: state,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _CategoriesWithAmountAndColor(state: state),
                ],
              )
            : const NoDataAvailableWidget();
      },
    );
  }
}

class _PieChart extends StatelessWidget {
  const _PieChart({
    Key? key,
    required this.fltrCtgWithAmountState,
  }) : super(key: key);
  final FilterCategoryWithAmountState fltrCtgWithAmountState;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialColorGeneratorCubit,
        MaterialColorGeneratorState>(
      builder: (context, mtrlState) {
        return Card(
          elevation: 0.5,
          child: SizedBox(
            height: 300,
            child: PieChart(
                PieChartData(
                    centerSpaceRadius: 0,
                    startDegreeOffset: 290,
                    sections: List.generate(
                        fltrCtgWithAmountState.filteredList.length, (index) {
                      final fltData =
                          fltrCtgWithAmountState.filteredList[index];
                      return PieChartSectionData(
                        badgePositionPercentageOffset: 1.06,
                        badgeWidget: Card(
                          child: Text(
                            "${getPercentage(fltData.amount, fltrCtgWithAmountState.totalAmount)}%",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                        ),
                        showTitle: false,
                        radius: 95,
                        color: mtrlState.colors[index],
                        value: getPercentage(
                            fltData.amount, fltrCtgWithAmountState.totalAmount),
                      );
                    }).toList()),
                swapAnimationDuration: const Duration(milliseconds: 1300),
                swapAnimationCurve: Curves.decelerate),
          ),
        );
      },
    );
  }
}

class _CategoriesWithAmountAndColor extends StatelessWidget {
  const _CategoriesWithAmountAndColor({
    Key? key,
    required this.state,
  }) : super(key: key);
  final FilterCategoryWithAmountState state;
  @override
  Widget build(BuildContext context) {
    final currency =
        context.read<CurrencyFormatterCubit>().state.formatCurrency;

    return BlocBuilder<MaterialColorGeneratorCubit,
        MaterialColorGeneratorState>(
      builder: (context, mtrlState) {
        return Card(
          elevation: 0.6,
          child: Column(
              children: List.generate(state.filteredList.length, (index) {
            final fltData = state.filteredList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      color: mtrlState.colors[index],
                      borderRadius: BorderRadius.circular(8)),
                  height: 40,
                  width: 48,
                  child: Center(
                    child: Text(
                      "${getPercentage(
                        fltData.amount,
                        state.totalAmount,
                      )}%",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodySmall
                          ?.copyWith(
                              fontSize: 9,
                              color: const Color.fromARGB(255, 242, 242, 242),
                              fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                title: Text(
                  fltData.category.name,
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
                trailing: Text(currency.format(fltData.amount)),
              ),
            );
          })),
        );
      },
    );
  }
}
