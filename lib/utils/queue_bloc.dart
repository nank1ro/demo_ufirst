import 'dart:async';
import 'package:demoufirst/models/user.dart';
import 'queue_event.dart';

class QueueBloc {
  int _queue = 0;
  List<User> _users = [];

  static final QueueBloc _singleton = QueueBloc._internal();

  factory QueueBloc() {
    return _singleton;
  }

  QueueBloc._internal() {
    _queueEventController.stream.listen(_mapEventToState);
    _usersEventController.stream.listen(_mapEventToState);
  }

  // queue (int) stream
  final _queueStateController = StreamController<int>();
  StreamSink<int> get _inQueue => _queueStateController.sink;

  Stream<int> get queue => _queueStateController.stream;

  final _queueEventController = StreamController<QueueEvent>();

  Sink<QueueEvent> get queueEventSink => _queueEventController.sink;

  // users (List<user>) stream
  final _usersStateController = StreamController<List<User>>();
  StreamSink<List<User>> get _inUsers => _usersStateController.sink;

  Stream<List<User>> get users => _usersStateController.stream;

  final _usersEventController = StreamController<QueueEvent>();

  Sink<QueueEvent> get usersEventSink => _usersEventController.sink;

  void _mapEventToState(QueueEvent event) {
    if (event is AddUsersEvent) {
      _queue += event.data.length;
      for (User user in event.data) {
        _users.add(user);
      }
    } else {
      _queue--;
      _users.removeAt(0);
    }
    _inQueue.add(_queue);
    _inUsers.add(_users);
  }

  void dispose() {
    _queueEventController.close();
    _queueStateController.close();

    _usersEventController.close();
    _usersStateController.close();
  }
}
