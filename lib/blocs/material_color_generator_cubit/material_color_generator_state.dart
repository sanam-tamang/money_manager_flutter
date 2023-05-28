// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'material_color_generator_cubit.dart';

class MaterialColorGeneratorState extends Equatable {
  const MaterialColorGeneratorState({
    this.colors = const []
  });
  final List<Color> colors;
  @override
  List<Object> get props => [colors];
}
