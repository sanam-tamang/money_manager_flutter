import 'package:flutter/material.dart';
import 'show_category_page.dart';
import 'stats_page.dart';

import '../../blocs/exports.dart';
import 'show_transaction_page.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});
  static const String id = '/customNavigationbar';

  final List<Widget> _pages = const [
    ShowTransaction(),
    StatsPage(),
    ShowCategoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TransactionsScrollCubit()),
        BlocProvider(create: (context) => NavigationBarIndexCubit())
      ],
      child: BlocBuilder<NavigationBarIndexCubit, NavigationBarIndexState>(
        builder: (context, state) {
          return Scaffold(
            body: _pages[state.index],
            bottomNavigationBar: NavigationBar(
                height: 75,
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                selectedIndex: state.index,
                onDestinationSelected: (int index) {
                  context.read<NavigationBarIndexCubit>().changeIndex(index);
                },
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.dashboard_customize_outlined),
                      label: "Trans"),
                  NavigationDestination(
                      icon: Icon(Icons.analytics_outlined), label: "Stats"),
                  NavigationDestination(
                      icon: Icon(Icons.category_outlined), label: "Categories")
                ]),
          );
        },
      ),
    );
  }
}
