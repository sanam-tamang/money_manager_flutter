// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'navigation_bar_index_cubit.dart';

class NavigationBarIndexState extends Equatable {
  const NavigationBarIndexState({this.index = 0});
  final int index;
  @override
  List<Object> get props => [index];
}
