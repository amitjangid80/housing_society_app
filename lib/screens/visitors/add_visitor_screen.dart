// Created by AMIT JANGID on 08/01/21.

import 'package:flutter/material.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:housing_society_app/widgets/custom_app_bar.dart';

class AddVisitorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: kAddVisitor),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(kUpcoming, style: Theme.of(context).textTheme.headline6),
            Expanded(
              child: ListView.builder(
                itemCount: 0,
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, _position) {

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
