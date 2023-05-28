import 'package:flutter/material.dart';
import 'package:money_manager/blocs/exports.dart';
import 'package:money_manager/core/color_pallete.dart';
import 'package:money_manager/core/extention.dart';
import 'package:money_manager/enum/frequency_enum.dart';
import 'package:money_manager/views/widgets/date_counter_buttons.dart';

import 'expense_page.dart';
import 'income_expense_page.dart';
import 'income_page.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});
  static const String id = '/stats';
  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  List<String> transactions = ["Transactions", "Income", "Expense"];
  late TabController tabController;
  late Frequency frequencyValue;
  @override
  void initState() {
    //Loading colors
    context.read<MaterialColorGeneratorCubit>().generateMaterialColor();

    frequencyValue = context.read<FrequencyCubit>().state.selectedFrequency;

    tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const DateCounterButton(
            iconColor: ColorPalette.brighterTextColor,
            labelInOveral: 'Statistics',
          ),
          actions: [
            DropdownButton(
              iconEnabledColor: ColorPalette.brighterTextColor,
              borderRadius: BorderRadius.circular(5),
              style: Theme.of(context).primaryTextTheme.bodyText2,
              value: frequencyValue,
              selectedItemBuilder: (context) {
                return Frequency.values
                    .map((frequency) => Baseline(
                          baseline: 30,
                          baselineType: TextBaseline.alphabetic,
                          child: Text(frequency.name.toCapitalizedFirstLater(),
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText2
                                  ?.copyWith(
                                      color: ColorPalette.brighterTextColor)),
                        ))
                    .toList();
              },
              items: Frequency.values
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.name.toCapitalizedFirstLater(),
                      )))
                  .toList(),
              onChanged: (value) {
                frequencyValue = value ?? Frequency.today;
                context.read<FilteredTransactionBloc>().add(
                    GetFilteredFrequencyTransaction(
                        dateTime: DateTime.now(), type: frequencyValue));
                context.read<FrequencyCubit>().changeFrequency(frequencyValue);
                setState(() {});
              },
            )
          ],
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            labelPadding: const EdgeInsets.symmetric(horizontal: 25),
            isScrollable: true,
            labelColor: ColorPalette.brighterTextColor,
            controller: tabController,
            tabs:
                transactions.map((frequency) => Tab(text: frequency)).toList(),
          ),
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: const [
              IncomeExpensePage(),
              IncomePage(),
              ExpensePage(),
            ]));
  }
}
