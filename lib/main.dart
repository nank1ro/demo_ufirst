import 'dart:async';

import 'package:demoufirst/components/user_item.dart';
import 'package:demoufirst/utils/queue_bloc.dart';
import 'package:demoufirst/utils/randomInRange.dart';
import 'package:demoufirst/utils/users_api.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  QueueBloc _bloc;
  Timer _timer;
  UsersApi _usersApi;

  @override
  void initState() {
    _bloc = QueueBloc();
    _usersApi = UsersApi();
    _usersApi.getUsers(3);
    _timer =
        Timer.periodic(Duration(seconds: 5), (Timer t) => getRandomUsers());
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  getRandomUsers() {
    int random = randomInRange(0, 2);
    _usersApi.getUsers(random);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
            stream: _bloc.queue,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              int value = snapshot.data;
              return RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: new TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'In coda: '),
                    TextSpan(
                        text: '$value',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    value == 1
                        ? TextSpan(text: ' persona')
                        : TextSpan(text: ' persone'),
                  ],
                ),
              );
            }),
      ),
      body: Center(
          child: StreamBuilder<List<User>>(
              stream: _bloc.users,
              initialData: [],
              builder:
                  (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.only(bottom: 5),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? UserItem(
                              user: snapshot.data[index],
                              isActive: true,
                            )
                          : UserItem(user: snapshot.data[index]);
                    });
              })),
    );
  }
}
