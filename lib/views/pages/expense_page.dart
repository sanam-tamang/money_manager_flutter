import 'package:flutter/material.dart';
import 'package:money_manager/enum/category_type.dart';

import '../../blocs/exports.dart';
import '../widgets/income_or_expense_pie_chart_data_widget.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  void initState() {
    context
        .read<CurrentTransactionTypeCubit>()
        .changeTransactionType(TransactionType.expense);
    context
        .read<FilterCategoryWithAmountBloc>()
        .add(const GetFilterCategoryWithAmount(type: TransactionType.expense));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const IncomeOrExpensePieChartData();
  }
}
