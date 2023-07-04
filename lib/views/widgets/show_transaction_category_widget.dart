import 'package:flutter/material.dart';

import '../../models/transaction_category.dart';

import '../../blocs/exports.dart';

class ShowTransactionCategory extends StatelessWidget {
  const ShowTransactionCategory({
    Key? key,
    required this.transactionCategory,
  }) : super(key: key);
  final void Function(TransactionCategory category) transactionCategory;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<FilterCategoryListBloc, FilterCategoryListState>(
        builder: (context, state) {
          if (state is FilterCategoryListLoadedState) {
            return Wrap(
                children: List.generate(state.filteredCategories.length, (index) {
              return GestureDetector(
                onTap: () {
                  ///sends back the tapped value
                  transactionCategory(state.filteredCategories[index]);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Text(state.filteredCategories[index].name),
                ),
              );
            }));
          } else {
            return const Text('Erro: Bloc');
          }
        },
      ),
    );
  }
}
