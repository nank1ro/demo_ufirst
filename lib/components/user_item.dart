import 'dart:ui';
import 'package:demoufirst/models/user.dart';
import 'package:demoufirst/utils/queue_bloc.dart';
import 'package:demoufirst/utils/queue_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/capitalize.dart';

class UserItem extends StatelessWidget {
  final User user;

  // check if the user is served now
  final bool isActive;

  final QueueBloc _bloc = QueueBloc();

  UserItem({@required this.user, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: new BoxDecoration(
        color: isActive ? Colors.white : Colors.grey[200],
        borderRadius: new BorderRadius.all(
          const Radius.circular(40.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: isActive ? Colors.lightBlueAccent : Colors.grey[300],
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(user.profileImage),
          ),
        ),
        title: Row(
          children: <Widget>[
            Text(
              "${user.firstName.capitalize} ${user.lastName.capitalize}",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.black : Colors.grey),
            ),
          ],
        ),
        subtitle: Row(
          children: <Widget>[
            Icon(
              Icons.phone_iphone,
              size: 12,
            ),
            Text(
              "${user.phoneNumber}",
              style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: isActive ? Colors.black : Colors.grey),
            ),
          ],
        ),
        trailing: isActive
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 40,
                height: 40,
                child: ClipOval(
                  child: Material(
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blueAccent, Colors.lightBlueAccent],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: InkWell(
                        splashColor: Colors.white, // inkwell color
                        child: Tooltip(
                          message: "Servito",
                          child: Icon(
                            Icons.done_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        onTap: () {
                          // user served, it's time for the next
                          _bloc.queueEventSink.add(DecrementEvent());
                        },
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
