import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'blocs/exports.dart';

import 'services/route_service.dart';
import 'views/pages/add_person.dart';
import 'views/pages/navigation_bar.dart';
import 'package:path_provider/path_provider.dart';

import 'core/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc()..add(LoadUserEvent()),
          ),

          BlocProvider(
              create: (context) =>
                  CategoryListBloc()..add(LoadCategoryEvent())),
          BlocProvider(
              create: (context) => FilterCategoryListBloc(
                  bloc: BlocProvider.of<CategoryListBloc>(context))),
          BlocProvider(create: (context) => TransactionBloc()),
          BlocProvider(create: (context) => FrequencyCubit()),
          BlocProvider(
              create: (context) => DateCounterBloc(
                  cubit: BlocProvider.of<FrequencyCubit>(context))
                ..add(const LoadDateCounter())),
          BlocProvider(
              create: (context) => FilteredTransactionBloc(
                  dateCouterBLoc: BlocProvider.of<DateCounterBloc>(context),
                  bloc: BlocProvider.of<TransactionBloc>(context),
                  frequencyCubit: BlocProvider.of<FrequencyCubit>(context))),
          BlocProvider(create: (context) => CurrentTransactionTypeCubit()),
          BlocProvider(
              create: (context) => FilterCategoryWithAmountBloc(
                  bloc: BlocProvider.of<FilteredTransactionBloc>(context),
                  cubit:
                      BlocProvider.of<CurrentTransactionTypeCubit>(context))),
          BlocProvider(
              create: (context) => MaterialColorGeneratorCubit(
                  bloc:
                      BlocProvider.of<FilterCategoryWithAmountBloc>(context))),
          BlocProvider(create: (context) => CurrencyFormatterCubit()),
          BlocProvider(create: (context) => TempFrequencyCubit()),
        ],
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadedState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Money Manager',
                theme: CustomThemeData.lightTheme(),
                onGenerateRoute: RouteService.onGeneratedRoute,
                home: state.user.name.isEmpty
                    ?const  AddPersonPage()
                    :const  CustomNavigationBar(),
              );
            } else {
              return const MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Text("loading"));
            }
          },
        ));
  }
}
