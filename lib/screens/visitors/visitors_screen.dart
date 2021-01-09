// Created by AMIT JANGID on 08/01/21.

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housing_society_app/app_theme.dart';
import 'package:housing_society_app/firebase/visitors_method.dart';
import 'package:housing_society_app/models/visitor.dart';
import 'package:housing_society_app/screens/screens.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:housing_society_app/widgets/custom_app_bar.dart';
import 'package:housing_society_app/widgets/image_from_network.dart';
import 'package:multiutillib/multiutillib.dart';

class VisitorsScreen extends StatefulWidget {
  final String uId;

  VisitorsScreen({@required this.uId});

  @override
  _VisitorsScreenState createState() => _VisitorsScreenState();
}

class _VisitorsScreenState extends State<VisitorsScreen> with SingleTickerProviderStateMixin {
  Stream _visitorsStream;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    // calling get payment details method
    _getPaymentDetails();
  }

  _getPaymentDetails() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _visitorsStream = VisitorsMethod.getVisitorsDetails(userId: widget.uId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: kVisitors),
      floatingActionButton: OpenContainer(
        tappable: true,
        closedElevation: 4,
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 600),
        openBuilder: (context, openContainer) => AddVisitorScreen(),
        openShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        closedBuilder: (context, openContainer) {
          return FloatingActionButton(elevation: 0, onPressed: null, child: Icon(Icons.add, size: 36));
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder<QuerySnapshot>(
          stream: _visitorsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var _docList = snapshot.data.docs;

              if (_docList.isEmpty) {
                return Center(child: Text(kNoRecords, style: Theme.of(context).textTheme.headline6));
              }

              return ListView.builder(
                itemCount: _docList.length,
                padding: const EdgeInsets.only(bottom: 80),
                itemBuilder: (context, _position) {
                  int _itemCount = _docList.length > 15 ? 15 : _docList.length;
                  Visitor _visitor = Visitor.fromJson(_docList[_position].data());

                  return SlideAnimation(
                    position: _position,
                    itemCount: _itemCount,
                    child: _ItemVisitor(visitor: _visitor),
                    slideDirection: SlideDirection.fromTop,
                    animationController: _animationController,
                  );
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}

class _ItemVisitor extends StatelessWidget {
  final Visitor visitor;

  _ItemVisitor({@required this.visitor});

  @override
  Widget build(BuildContext context) {
    String _visitingDate = '';

    if (!visitor.dailyVisitor) {
      _visitingDate = formatDateTime(visitor.visitingDate.toDate().toString(), newDateTimeFormat: kTimeDateFormat);
    }

    return MaterialCard(
      padding: const EdgeInsets.all(0),
      borderRadiusGeometry: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(12),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Text(
                    visitor.visitorType,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    color: visitor.approved ? kPrimaryColor : Colors.red,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                  ),
                  child: Text(
                    visitor.approved ? kApproved : kUnApproved,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: ImageFromNetwork(imageUrl: visitor.visitorPhoto, imageWidth: 60, imageHeight: 60)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(visitor.visitorName, style: Theme.of(context).textTheme.headline6),
                          const SizedBox(height: 5),
                          if (!visitor.dailyVisitor) ...[
                            RichTextWidget(
                              isDescNewLine: true,
                              caption: kVisitingDate,
                              description: _visitingDate,
                              captionStyle: Theme.of(context).textTheme.bodyText2,
                              descriptionStyle: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(height: 5),
                          ],
                          RichTextWidget(
                            caption: kDailyVisitor,
                            description: visitor.dailyVisitor ? kYes : kNo,
                            captionStyle: Theme.of(context).textTheme.bodyText2,
                            descriptionStyle: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(height: 1, color: kPrimaryColor),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.help_outline_outlined),
                    label: Text(kWrongEntry, style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
                Container(width: 0.5, height: 36, color: kPrimaryColor),
                Expanded(
                  child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(visitor.approved ? Icons.clear : Icons.check_circle_outline),
                    label: Text(visitor.approved ? kRefuse : kApprove, style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
