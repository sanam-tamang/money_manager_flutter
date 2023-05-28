part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadedState extends UserState {
  final User user;
  const UserLoadedState({
    required this.user,
  });

  @override
  List<Object> get props => [];
}
