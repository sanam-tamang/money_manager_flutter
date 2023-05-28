
import 'package:flutter/material.dart';
import 'package:money_manager/enum/category_type.dart';

import '../../blocs/exports.dart';
import '../widgets/income_or_expense_pie_chart_data_widget.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  @override
  void initState() {
    
    context
        .read<CurrentTransactionTypeCubit>()
        .changeTransactionType(TransactionType.income);
    context
        .read<FilterCategoryWithAmountBloc>()
        .add(const GetFilterCategoryWithAmount(type: TransactionType.income));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const IncomeOrExpensePieChartData();
  }
}
