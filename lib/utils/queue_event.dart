import 'package:demoufirst/models/user.dart';

abstract class QueueEvent {}

class AddUsersEvent extends QueueEvent {
  final List<User> data;

  AddUsersEvent(this.data);
}

class DecrementEvent extends QueueEvent {}
