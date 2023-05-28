// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final User user;
  const AddUserEvent({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class UpdateUserEvent extends UserEvent {
  final User user;
  const UpdateUserEvent({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}


class DeleteUserEvent extends UserEvent{
  
}