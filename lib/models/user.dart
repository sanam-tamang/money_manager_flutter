import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  const User({
    required this.name,
  });
  @override
  List<Object?> get props => [name];

  
}
