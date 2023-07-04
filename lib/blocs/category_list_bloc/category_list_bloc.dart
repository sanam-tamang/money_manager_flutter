import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../enum/category_type.dart';
import '../../models/transaction_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

///this [CategoryListBloc]peforms crud operations on the category
class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState>
    with HydratedMixin {
  CategoryListBloc() : super(const CategoryInitialState()) {
    on<LoadCategoryEvent>(_loadCategories);
    on<AddCategoryEvent>(_onAddCategoryEvent);
    on<UpdateCategoryEvent>(_onUpdateCategoryEvent);
    on<DeleteCategoryEvent>(_onDeleteCategoryEvent);
    on<EmptyCategoryEvent>(_onEmptyCategoryEvent);
  }

  void _loadCategories(
      LoadCategoryEvent event, Emitter<CategoryListState> emit) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? username = sharedPreferences.getString('username');
    if (username == '' || username == null) {
      emit(const CategoryLoadedState(categories: __categories));
    }
  }

  void _onAddCategoryEvent(
      AddCategoryEvent event, Emitter<CategoryListState> emit) {
    final state = this.state;
    if (state is CategoryLoadedState) {
      emit(CategoryLoadedState(
          categories: List.from(state.categories)..add(event.category)));
    }
  }

  void _onUpdateCategoryEvent(
      UpdateCategoryEvent event, Emitter<CategoryListState> emit) {
    final state = this.state;
    if (state is CategoryLoadedState) {
      Iterable<TransactionCategory> categories =
          List.from(state.categories).map((category) {
        if (category.id == event.category.id) {
          return event.category;
        } else {
          return category;
        }
      });
      emit(CategoryLoadedState(categories: categories.toList()));
    }
  }

  void _onDeleteCategoryEvent(
      DeleteCategoryEvent event, Emitter<CategoryListState> emit) {
    final state = this.state;
    if (state is CategoryLoadedState) {
      emit(CategoryLoadedState(
          categories: List.from(state.categories)..remove(event.category)));
    }
  }

  void _onEmptyCategoryEvent(
      EmptyCategoryEvent event, Emitter<CategoryListState> emit) {
    emit(const CategoryLoadedState(categories: []));
  }

  @override
  CategoryListState? fromJson(Map<String, dynamic> json) {
    return CategoryLoadedState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoryListState state) {
    if (state is CategoryLoadedState) {
      return state.toMap();
    } else {
      return {};
    }
  }
}

const List<TransactionCategory> __categories = [
  ///income categories are here #########################
  TransactionCategory(id: '1101', name: 'Salary', type: TransactionType.income),
  TransactionCategory(id: '1102', name: 'Sale', type: TransactionType.income),
  TransactionCategory(
      id: '1103', name: 'Divident', type: TransactionType.income),
  TransactionCategory(id: '1104', name: 'Rental', type: TransactionType.income),
  TransactionCategory(id: '1105', name: 'Bonus', type: TransactionType.income),
  TransactionCategory(id: '1106', name: 'Awards', type: TransactionType.income),
  TransactionCategory(
      id: '1107', name: 'Coupons', type: TransactionType.income),
  TransactionCategory(
      id: '1108', name: 'Refunds', type: TransactionType.income),
  TransactionCategory(id: '1109', name: 'Grands', type: TransactionType.income),
  TransactionCategory(id: '1110', name: 'Others', type: TransactionType.income),

  ///expense categoriess is here ################
  TransactionCategory(id: '2201', name: 'Food', type: TransactionType.expense),
  TransactionCategory(
      id: '2202', name: 'Education', type: TransactionType.expense),
  TransactionCategory(
      id: '2203', name: 'Clothing', type: TransactionType.expense),
  TransactionCategory(
      id: '2204', name: 'Transportation', type: TransactionType.expense),
  
  TransactionCategory(id: '2208', name: 'Shopping', type: TransactionType.expense),
  TransactionCategory(id: '2209', name: 'Household', type: TransactionType.expense),
  TransactionCategory(id: '2211', name: 'Health', type: TransactionType.expense),
  TransactionCategory(id: '2212', name: 'Beauty', type: TransactionType.expense),
  TransactionCategory(id: '2213', name: 'Book', type: TransactionType.expense),
  TransactionCategory(id: '2216', name: 'Entertainment', type: TransactionType.expense),
  TransactionCategory(id: '2217', name: 'Tax', type: TransactionType.expense),
  TransactionCategory(id: '2221', name: 'Electronics', type: TransactionType.expense),
  TransactionCategory(id: '2222', name: 'Social Life', type: TransactionType.expense),
  TransactionCategory(id: '2225', name: 'Gift', type: TransactionType.expense),
  TransactionCategory(id: '2226', name: 'Culture', type: TransactionType.expense),
  TransactionCategory(id: '2227', name: 'Drinks', type: TransactionType.expense),
  TransactionCategory(id: '2229', name: 'Other', type: TransactionType.expense),
];
