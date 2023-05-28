import 'package:flutter/material.dart';

import 'package:money_manager/blocs/exports.dart';
import 'package:money_manager/core/extention.dart';
import 'package:money_manager/enum/category_type.dart';
import 'package:money_manager/models/transaction_category.dart';
import 'package:money_manager/views/widgets/custom_alert_dialog.dart';

import '../../core/color_pallete.dart';
import 'add_or_update_category_page.dart';

class ShowCategoryPage extends StatelessWidget {
  static const String id = '/show_categories_page';
  const ShowCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 30,
        title: const Text(
          'Category Setting',
        ),
      ),
      body: BlocBuilder<CategoryListBloc, CategoryListState>(
        builder: (context, state) {
          if (state is CategoryLoadedState) {
            return CategoryListTile(categories: state.categories);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: ElevatedButton.icon(
        style: ButtonStyle(
            shape: const MaterialStatePropertyAll(BeveledRectangleBorder()),
            backgroundColor:
                const MaterialStatePropertyAll(ColorPalette.primaryColor),
            textStyle: MaterialStatePropertyAll(
                Theme.of(context).primaryTextTheme.bodyMedium),
            foregroundColor:
                const MaterialStatePropertyAll(ColorPalette.brighterTextColor)),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(CategoryPage.id);
        },
        label: const Text(
          'Add Category',
        ),
      ),
    );
  }
}

class CategoryListTile extends StatefulWidget {
  const CategoryListTile({super.key, required this.categories});
  final List<TransactionCategory> categories;

  @override
  State<CategoryListTile> createState() => _CategoryListTileState();
}

class _CategoryListTileState extends State<CategoryListTile> {
  TransactionType currentTransactionType = TransactionType.expense;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: TransactionType.values
              .map((e) => InkWell(
                  onTap: () {
                    currentTransactionType = e;
                    setState(() {});
                  },
                  child: Chip(
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .titleMedium
                          ?.copyWith(
                              color: e == currentTransactionType
                                  ? ColorPalette.brighterTextColor
                                  : ColorPalette.textColor),
                      backgroundColor: e == currentTransactionType
                          ? ColorPalette.primaryColor
                          : ColorPalette.backgroundColor,
                      labelPadding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 4),
                      label: Text(e.name.toCapitalizedFirstLater()))))
              .toList(),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                if (currentTransactionType == widget.categories[index].type) {
                  return Card(
                    color: Colors.white,
                    elevation: 0.4,
                    child: ListTile(
                      leading: IconButton(
                          onPressed: () {
                            customAlertDialog(context,
                                yesOptionLabel: 'Delete',
                                label:
                                    'Related bills will be deleted. Do you want to delete this category?',
                                onPressedYesOption: () {
                              context.read<CategoryListBloc>().add(
                                  DeleteCategoryEvent(
                                      category: widget.categories[index]));

                              context.read<TransactionBloc>().add(
                                  TrnCategoryDeletedEvent(
                                      category: widget.categories[index]));
                            });
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: ColorPalette.primaryColor,
                            size: 20,
                          )),
                      title: Text(widget.categories[index].name),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(CategoryPage.id,
                                arguments: {
                                  'category': widget.categories[index]
                                });
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            size: 20,
                          )),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
        ),
      ],
    );
  }
}
