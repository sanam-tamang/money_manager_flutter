import 'package:flutter/material.dart';
import 'package:money_manager/models/transaction_category.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:money_manager/views/pages/add_person.dart';
import 'package:money_manager/views/pages/add_or_update_category_page.dart';
import 'package:money_manager/views/pages/navigation_bar.dart';
import 'package:money_manager/views/pages/show_category_page.dart';
import 'package:money_manager/views/pages/stats_page.dart';
import 'package:money_manager/views/pages/transaction_detail_page.dart';

import '../views/pages/transaction_add_or_edit_page.dart';

class RouteService {
  static Route onGeneratedRoute(RouteSettings? settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings?.name) {
        case TransactionAddOrEditPage.id:
          Map? transaction = settings?.arguments as Map?;

          return TransactionAddOrEditPage(
            transaction: transaction?['transaction'] as Transaction?,
          );
        case AddPersonPage.id:
          return const AddPersonPage();
        case CustomNavigationBar.id:
          return const CustomNavigationBar();
        case StatsPage.id:
          return const StatsPage();
        case CategoryPage.id:
          Map? category = settings?.arguments as Map?;

          return  CategoryPage(category: category?['category'] as TransactionCategory?,);
        case TransactionDetailPage.id:
          Map transaction = settings?.arguments as Map;

          return TransactionDetailPage(
              transaction: transaction['transaction'] as Transaction);
        case ShowCategoryPage.id:
          return const ShowCategoryPage();
        default:
          return const Text('Erro: Route');
      }
    });
  }
}
