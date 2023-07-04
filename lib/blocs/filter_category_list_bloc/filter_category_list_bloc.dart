import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../category_list_bloc/category_list_bloc.dart';
import '../../enum/category_type.dart';
import '../../models/transaction_category.dart';

part 'filter_category_list_event.dart';
part 'filter_category_list_state.dart';

///this [FilterCategoryListBloc] purpose is to show the sub category 
///inside [TransactionType] for ex.
///if you have [TransactionType.income] then it will show you the 
///sub category inside of this type like salary,sells,bonus etc are the
///sub categories inside of [TransactionType.income]
class FilterCategoryListBloc
    extends Bloc<FilterCategoryListEvent, FilterCategoryListState> {
  final CategoryListBloc _bloc;
  FilterCategoryListBloc({required CategoryListBloc bloc})
      : _bloc = bloc,
        super(const FilterCategoryListLoadedState()) {
    on<GetFilteredCategoryListEvent>(_onGetFilteredCategoryList);
  }

  void _onGetFilteredCategoryList(GetFilteredCategoryListEvent event,
      Emitter<FilterCategoryListState> emit) {
    final ctrlbState = _bloc.state;
    if (ctrlbState is CategoryLoadedState) {
      List<TransactionCategory> categories =
          List.from(ctrlbState.categories);
     
         List<TransactionCategory>  filteredCategories = categories.where((e) => e.type == event.type).toList();

      final state = this.state;
      if (state is FilterCategoryListLoadedState) {
        emit(FilterCategoryListLoadedState(
            filteredCategories: filteredCategories));
      }
    }
  }
}
