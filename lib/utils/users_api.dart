import 'package:demoufirst/models/user.dart';
import 'package:demoufirst/utils/queue_bloc.dart';
import 'package:demoufirst/utils/queue_event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersApi {
  Future<List<User>> getUsers([int number = 1]) async {
    if (number > 0) {
      final result =
          await http.Client().get("https://randomuser.me/api/?results=$number");

      if (result.statusCode != 200) throw Exception();

      return parsedJson(result.body);
    }
    return null;
  }

  List<User> parsedJson(final response) {
    final jsonDecoded = json.decode(response);

    final dynamic jsonUsers = jsonDecoded["results"];

    List<User> users = [];

    // converting JSON into user model
    jsonUsers.forEach((user) => users.add(User.fromJson(user)));

    final _bloc = QueueBloc();

    // adding users
    _bloc.queueEventSink.add(AddUsersEvent(users));

    return users;
  }
}
