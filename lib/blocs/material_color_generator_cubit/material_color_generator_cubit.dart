import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../filter_category_with_amount_bloc/filter_category_with_amount_bloc.dart';

part 'material_color_generator_state.dart';

class MaterialColorGeneratorCubit extends Cubit<MaterialColorGeneratorState> {
  MaterialColorGeneratorCubit({required FilterCategoryWithAmountBloc bloc})
      : _bloc = bloc,
        super(const MaterialColorGeneratorState()) {
    _bloc.stream.listen((state) {
      generateMaterialColor();
    });
  }
  final FilterCategoryWithAmountBloc _bloc;

  void generateMaterialColor() {
    List<Color> colors2 = [
      Colors.green,
      Colors.red,
      Colors.pink,
      Colors.indigo,
      Colors.blue,
      Colors.deepOrange,
      Colors.teal,
      Colors.cyan,
      Colors.brown,
      Colors.blueGrey,
      Colors.deepPurple,
      Colors.lightGreen,
      Colors.lightBlue,
      Colors.amber,
      Colors.purple
    ];

    // //if there is more than 12 categories list , we need to provide more core for them
    // //so making random color generator here
    if (_bloc.state.filteredList.length >= 12) {
      List<Color> colors1 =
          List.generate(_bloc.state.filteredList.length, (index) {
        return Color((Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0);
      });
      colors2.addAll(colors1);
    }

    emit(MaterialColorGeneratorState(colors: colors2));
  }
}
