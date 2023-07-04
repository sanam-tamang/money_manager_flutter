import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_bar_index_state.dart';
///helps to change the index of navigationbar 
class NavigationBarIndexCubit extends Cubit<NavigationBarIndexState> {
  NavigationBarIndexCubit() : super(const NavigationBarIndexState());
  void changeIndex(int index) => emit(NavigationBarIndexState(index: index));
}
