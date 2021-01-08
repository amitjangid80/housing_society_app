// Created by AMIT JANGID on 08/01/21.

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housing_society_app/blocs/blocs.dart';
import 'package:housing_society_app/firebase/visitors_method.dart';
import 'package:housing_society_app/models/visitor.dart';
import 'package:housing_society_app/screens/screens.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:housing_society_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class VisitorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UsersBloc _usersBloc = Provider.of<UsersBloc>(context);

    return Scaffold(
      appBar: CustomAppBar(title: kVisitors),
      floatingActionButton: OpenContainer(
        tappable: true,
        closedElevation: 4,
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 600),
        openBuilder: (context, VoidCallback openContainer) => AddVisitorScreen(),
        openShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        closedBuilder: (context, VoidCallback openContainer) {
          return FloatingActionButton(
            elevation: 0,
            onPressed: null,
            clipBehavior: Clip.antiAlias,
            child: Icon(Icons.add, size: 36),
          );
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder<QuerySnapshot>(
            stream: VisitorsMethod.getVisitorsDetails(userId: _usersBloc.users.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var _docList = snapshot.data.docs;

                if (_docList.isEmpty) {
                  return Center(child: Text(kNoRecords, style: Theme.of(context).textTheme.headline6));
                }

                return ListView.builder(
                  itemCount: _docList.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, _position) {
                    Visitor _visitor = Visitor.fromJson(_docList[_position].data());

                    return _ItemVisitor(visitor: _visitor);
                  },
                );
              }

              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

class _ItemVisitor extends StatelessWidget {
  final Visitor visitor;

  _ItemVisitor({@required this.visitor});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
