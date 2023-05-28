// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_manager/views/pages/navigation_bar.dart';
import 'package:uuid/uuid.dart';

import 'package:money_manager/blocs/exports.dart';
import 'package:money_manager/core/color_pallete.dart';
import 'package:money_manager/core/extention.dart';
import 'package:money_manager/core/validation.dart';
import 'package:money_manager/enum/category_type.dart';
import 'package:money_manager/models/transaction_category.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:money_manager/views/widgets/custom_leading_icon.dart';
import 'package:money_manager/views/widgets/custom_snackbar.dart';
import 'package:money_manager/views/widgets/custom_transaction_fillable_widget.dart';

import '../../core/date_time_formattor.dart';
import '../widgets/date_time_picker_widget.dart';
import '../widgets/show_transaction_category_widget.dart';

class TransactionAddOrEditPage extends StatefulWidget {
  static const String id = '/transactionAddOrEditPage';
  const TransactionAddOrEditPage({
    Key? key,
    this.transaction,
  }) : super(key: key);
  final Transaction? transaction;

  @override
  State<TransactionAddOrEditPage> createState() =>
      _TransactionAddOrEditPageState();
}

class _TransactionAddOrEditPageState extends State<TransactionAddOrEditPage> {
  late TextEditingController transactionAmountController;
  late ValueNotifier<TransactionCategory?> categoryNotifier;
  late ValueNotifier<TransactionType> transactionTypeNotifier;
  final GlobalKey<FormState> _moneyFormKey = GlobalKey();
  late String dateTime;
  @override
  void initState() {
    final transactionType =
        widget.transaction?.category.type ?? TransactionType.expense;
    final transactionDate = widget.transaction?.dateTime != null
        ? DateTime.parse(widget.transaction!.dateTime)
        : DateTime.now();

    ///************
    /// initializationsss
    /// of data
    transactionAmountController = TextEditingController(
        text: widget.transaction?.transactionAmount.toString());

    ///holding the category value
    categoryNotifier = ValueNotifier(widget.transaction?.category);
    dateTime = formatDateTimeWithHourAndMinute(transactionDate);

    ///this is only for updating some stuff
    transactionTypeNotifier = ValueNotifier(transactionType);
    context
        .read<FilterCategoryListBloc>()
        .add(GetFilteredCategoryListEvent(type: transactionType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const CustomLeadingIcon(),
          title: ValueListenableBuilder(
            valueListenable: transactionTypeNotifier,
            builder: (__, state, _) {
              return Text(
                state.name.toCapitalizedFirstLater(),
              );
            },
          )),
      body: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionLoadedState) {
            customSnackBar(context,
                label: widget.transaction == null
                    ? 'Transaction added'
                    : 'Transaction updated');
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _transactionTypeButtons(),
              const SizedBox(
                height: 15,
              ),
              _transactionsMetaDataWidget(context),
              const SizedBox(
                height: 15,
              ),
              _saveTransactionWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  //methods widgets

  ValueListenableBuilder<TransactionCategory?> _saveTransactionWidget(
      BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categoryNotifier,
        builder: (_, catState, child) {
          return ValueListenableBuilder(
              valueListenable: transactionTypeNotifier,
              builder: (context, trnTypeState, child) {
                return InkWell(
                  onTap: () {
                    widget.transaction == null
                        ? _onSaveTransaction(catState)
                        : _onEditTransaction(catState);
                  },
                  child: Container(
                    height: 50,
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: catState == null
                            ? ColorPalette.backgroundColor
                            : trnTypeState == TransactionType.income
                                ? ColorPalette.growthColor
                                : ColorPalette.cautionColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text('Save',
                        style: TextStyle(color: ColorPalette.textColor)),
                  ),
                );
              });
        });
  }

  Column _transactionsMetaDataWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatefulBuilder(builder: (context, newDateState) {
          return Row(
            children: [
              const Text('Date', style: TextStyle(color: Colors.grey)),
              const SizedBox(
                width: 45,
              ),
              InkWell(
                onTap: () {
                  DateAndTimePicker(
                      context: context,
                      dateTime: (dateTime) {
                        this.dateTime = dateTime;
                        newDateState(() {});
                      }).selectDateAndTime();
                },
                child: Text(dateTime,
                    style: const TextStyle(color: ColorPalette.textColor)),
              ),
            ],
          );
        }),
        const SizedBox(
          height: 15,
        ),

        ///Category
        ValueListenableBuilder(
          valueListenable: categoryNotifier,
          builder: (context, catState, child) {
            return FillableTransactionWidget(
                text: 'Category', fillabe: catState?.name, child: child!);
          },
          child: ShowTransactionCategory(transactionCategory: (category) {
            categoryNotifier.value = category;
            Navigator.of(context).pop();
          }),
        ),

        ///Amount
        Row(
          children: [
            const Text('Amount', style: TextStyle(color: Colors.grey)),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Form(
                key: _moneyFormKey,
                child: TextFormField(
                  controller: transactionAmountController,
                  style: const TextStyle(color: ColorPalette.textColor),
                  validator: Validate.transactionAmount,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _transactionTypeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: TransactionType.values.map((type) {
        return ValueListenableBuilder(
            valueListenable: categoryNotifier,
            builder: (context, catState, child) {
              return ValueListenableBuilder(
                  valueListenable: transactionTypeNotifier,
                  builder: (context, transactionTypeState, child) {
                    return InkWell(
                      onTap: () {
                        context
                            .read<FilterCategoryListBloc>()
                            .add(GetFilteredCategoryListEvent(type: type));

                        transactionTypeNotifier.value = type;

                        ///if type is changed then we need to wipe out the category
                        if (catState?.type != type) {
                          categoryNotifier.value = null;
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color:
                                  ColorPalette.backgroundColor.withOpacity(0.1),
                              border: Border.all(
                                  color: _selectedColor(
                                      transactionTypeState, type)),
                              borderRadius: BorderRadius.circular(6)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 28),
                          child: Text(
                            type.name.toCapitalizedFirstLater(),
                            style: TextStyle(
                                color:
                                    _selectedColor(transactionTypeState, type)),
                          )),
                    );
                  });
            });
      }).toList(),
    );
  }

  Color _selectedColor(TransactionType selectedType, TransactionType type) {
    return type == selectedType
        ? selectedType == TransactionType.expense
            ? ColorPalette.cautionColor
            : ColorPalette.growthColor
        : Colors.grey;
  }

  void _onSaveTransaction(
    TransactionCategory? catState,
  ) {
    if (_moneyFormKey.currentState!.validate() == false || catState == null) {
      return;
    }
    Uuid uuid = const Uuid();
    final transaction = Transaction(
        id: uuid.v1(),
        category: catState,
        transactionAmount: double.parse(transactionAmountController.text),
        dateTime: dateTime);
    context
        .read<TransactionBloc>()
        .add(AddTransactionEvent(transaction: transaction));

    Navigator.of(context).pop();
  }

  void _onEditTransaction(TransactionCategory? catState) {
    final transaction = widget.transaction?.copyWith(
        category: catState,
        transactionAmount: double.parse(transactionAmountController.text),
        dateTime: dateTime);
    context
        .read<TransactionBloc>()
        .add(UpdateTransactionEvent(transaction: transaction as Transaction));
    Navigator.pushNamedAndRemoveUntil(
        context, CustomNavigationBar.id, (route) => false);
  }
}
