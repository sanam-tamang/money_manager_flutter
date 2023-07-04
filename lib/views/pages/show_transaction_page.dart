import 'package:flutter/material.dart';

import '../../blocs/exports.dart';
import '../../core/color_pallete.dart';
import '../../core/extention.dart';
import '../../enum/frequency_enum.dart';
import 'transaction_add_or_edit_page.dart';
import '../widgets/show_transaction_amount_heading_card.dart';

import '../widgets/date_counter_buttons.dart';
import '../widgets/transaction_tiles.dart';

class ShowTransaction extends StatefulWidget {
  const ShowTransaction({super.key});

  @override
  State<ShowTransaction> createState() => _ShowTransactionState();
}

class _ShowTransactionState extends State<ShowTransaction> {
  @override
  void initState() {
    super.initState();
    context
        .read<FrequencyCubit>()
        .changeFrequency(context.read<TempFrequencyCubit>().state.frequency);

    ///by default showing dailly transaction amounts and datas
    context.read<DateCounterBloc>().add(ResetDateTimeCounter());
    context.read<FilteredTransactionBloc>().add(GetFilteredFrequencyTransaction(
        dateTime: DateTime.now(),
        type: context.read<FrequencyCubit>().state.selectedFrequency));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 10,
        title: const DateCounterButton(
          labelInOveral: 'Transactions',
          iconColor: ColorPalette.brighterTextColor,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: _FrequencyTimeButtons(),
        ),
        actions: [
          Builder(builder: (ctx) {
            return IconButton(
              onPressed: () async {
                Scaffold.of(ctx).openEndDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: ColorPalette.brighterTextColor,
              ),
            );
          }),
         const  SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Column(
        children: const [
          Card(
              color: Colors.white,
              elevation: 0.4,
              child: ShowTransactionAmountHeadingCard()),
                 Expanded(child: TrasactionTiles()),
 ],
      ),
      floatingActionButton:
          BlocBuilder<TransactionsScrollCubit, TransactionsScrollState>(
        builder: (context, state) {
          return Visibility(
            visible: state.isScrollUp,
            child: FloatingActionButton(
              tooltip: 'Add transaction',
              onPressed: () {
                Navigator.of(context).pushNamed(TransactionAddOrEditPage.id);
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class _FrequencyTimeButtons extends StatelessWidget {
  const _FrequencyTimeButtons();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FrequencyCubit, FrequencyState>(
        builder: (context, state) {
      return Container(
          height: 35,
          width: double.infinity,
          alignment: Alignment.center,
          child: ListView.builder(
              key: const PageStorageKey('frequencyButtonkey'),
              scrollDirection: Axis.horizontal,
              itemCount: Frequency.values.length,
              itemBuilder: (context, index) {
                return BlocBuilder<DateCounterBloc, DateCounterState>(
                  builder: (context, dateCounterState) {
                    if (dateCounterState is DateCounterLoadedState) {
                      return InkWell(
                          onTap: () => _onPressedFrequencyButton(
                              context, Frequency.values[index]),
                          child: Center(
                            child: _CustomButton(
                              frequency: Frequency.values[index],
                              tappedFrequency: state.selectedFrequency,
                            ),
                          ));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              }));
    });
  }

  void _onPressedFrequencyButton(BuildContext context, Frequency frequency) {
    context.read<FrequencyCubit>().changeFrequency(frequency);
    context
        .read<TempFrequencyCubit>()
        .setLastTransactionPageFrequency(frequency);
    context.read<FilteredTransactionBloc>().add(GetFilteredFrequencyTransaction(
        dateTime: DateTime.now(), type: frequency));
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({
    required this.frequency,
    required this.tappedFrequency,
  });

  final Frequency tappedFrequency;
  final Frequency frequency;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        duration: const Duration(milliseconds: 250),
        child: Baseline(
          baselineType: TextBaseline.alphabetic,
          baseline: 5,
          child: Column(
            children: [
              Text(
                frequency.name.toCapitalizedFirstLater(),
                style: Theme.of(context).primaryTextTheme.bodyMedium?.copyWith(
                    color: tappedFrequency == frequency
                        ? Colors.white
                        : ColorPalette.brighterTextColor),
              ),
              //the purpose of this is to show only color below the content
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                color: tappedFrequency == frequency
                    ? Colors.white
                    : Colors.transparent,
                margin: const EdgeInsets.only(top: 5),
                height: 2,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  frequency.name.toCapitalizedFirstLater(),
                ),
              ),
            ],
          ),
        ));
  }
}
