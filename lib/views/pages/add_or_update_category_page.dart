// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:money_manager/blocs/exports.dart';
import 'package:money_manager/core/color_pallete.dart';
import 'package:money_manager/core/extention.dart';
import 'package:money_manager/core/validation.dart';
import 'package:money_manager/enum/category_type.dart';
import 'package:money_manager/models/transaction_category.dart';
import 'package:money_manager/views/widgets/custom_leading_icon.dart';
import 'package:money_manager/views/widgets/custom_snackbar.dart';

///in this page it will add or edit the category
class CategoryPage extends StatefulWidget {
  const CategoryPage({
    Key? key,
    this.category,
  }) : super(key: key);
  static const String id = '/category_page';
  final TransactionCategory? category;
  @override
  State<CategoryPage> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  late TextEditingController controller;
  late TransactionType transactionType;
  @override
  void initState() {
    controller = TextEditingController(text: widget.category?.name);
    transactionType = widget.category?.type ?? TransactionType.expense;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context)
        .primaryTextTheme
        .bodyLarge
        ?.copyWith(color: ColorPalette.textColor);
    return Scaffold(
      appBar: AppBar(
        leading: const CustomLeadingIcon(),
        title:
            Text('${transactionType.name.toCapitalizedFirstLater()} Category'),
      ),
      body: BlocListener<CategoryListBloc, CategoryListState>(
        listener: (context, state) {
          if (state is CategoryLoadedState) {
            customSnackBar(context,
                label: widget.category == null
                    ? 'Category added'
                    : 'Category updated');
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Category',
                    style: titleStyle,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorPalette.backgroundColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(5)),
                        child: Form(
                          key: _formState,
                          child: _CustomCategoryTextFields(
                            controller: controller,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    'Transaction',
                    style: titleStyle,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 3,
                    child: DropdownButton(
                        isExpanded: true,
                        value: transactionType,
                        items: TransactionType.values
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    e.name.toCapitalizedFirstLater(),
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: ColorPalette.textColor),
                                  ),
                                )))
                            .toList(),
                        onChanged: (value) {
                          transactionType = value!;
                          setState(() {});
                        }),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (!_formState.currentState!.validate()) {
                    return;
                  }
                  widget.category == null
                      ? _onSaveCategory()
                      : _onUpdateCategory();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: ColorPalette.primaryColor,
                      borderRadius: BorderRadius.circular(6)),
                  width: double.maxFinite,
                  child: Text(
                    'Save',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyLarge
                        ?.copyWith(color: ColorPalette.brighterTextColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSaveCategory() {
    Uuid uuid = const Uuid();
    final transactionCategory = TransactionCategory(
        id: uuid.v1(), name: controller.text, type: transactionType);
    context
        .read<CategoryListBloc>()
        .add(AddCategoryEvent(category: transactionCategory));
    Navigator.of(context).pop();
  }

  void _onUpdateCategory() {
    final transactionCategory =
        widget.category?.copyWith(name: controller.text, type: transactionType);
    context.read<CategoryListBloc>().add(UpdateCategoryEvent(
        category: transactionCategory as TransactionCategory));
    context
        .read<TransactionBloc>()
        .add(TrnCategoryUpdatedEvent(category: transactionCategory));
    Navigator.of(context).pop();
  }
}

class _CustomCategoryTextFields extends StatelessWidget {
  const _CustomCategoryTextFields({required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        style: Theme.of(context)
            .primaryTextTheme
            .bodyMedium
            ?.copyWith(color: ColorPalette.textColor),
        controller: controller,
        validator: Validate.categoryName,
        decoration: const InputDecoration(
            hintText: 'eg. Salary', border: InputBorder.none),
      ),
    );
  }
}
