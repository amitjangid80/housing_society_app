// Created by AMIT JANGID on 07/01/21.

import 'package:async/async.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:housing_society_app/blocs/blocs.dart';
import 'package:housing_society_app/screens/screens.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:housing_society_app/utils/utils.dart';
import 'package:housing_society_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
  }

  @override
  Widget build(BuildContext context) {
    final UsersBloc _usersBloc = Provider.of<UsersBloc>(context);

    // calling get current user details method
    _asyncMemoizer.runOnce(() async {
      await _usersBloc.getCurrentUserDetails();

      _animationController.forward();
    });

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(isHomePage: true, title: kDashboard, showActionBtn: true),
        body: _usersBloc.isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Text(
                      '$kWelcome ${_usersBloc.users?.name ?? ''}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.all(15),
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _GridViewItem(
                        title: kFacilities,
                        icon: kIconFacilities,
                        animationController: _animationController,
                        openBuilder: (context, VoidCallback openContainer) => FacilitiesScreen(),
                      ),
                      _GridViewItem(
                        title: kVisitors,
                        icon: kIconVisitors,
                        animationController: _animationController,
                        openBuilder: (context, VoidCallback openContainer) => VisitorsScreen(uId: _usersBloc.users.uid),
                      ),
                      _GridViewItem(
                        title: kPayments,
                        icon: kIconPayments,
                        animationController: _animationController,
                        openBuilder: (context, VoidCallback openContainer) => PaymentsScreen(uId: _usersBloc.users.uid),
                      ),
                    ],
                  ),
                ],
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

class _GridViewItem extends StatelessWidget {
  final String title, icon;
  final Function openBuilder;
  final AnimationController animationController;

  _GridViewItem({
    @required this.icon,
    @required this.title,
    @required this.openBuilder,
    @required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
      child: OpenContainer(
        tappable: true,
        closedElevation: 4,
        openBuilder: openBuilder,
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 600),
        openShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        closedBuilder: (context, VoidCallback openContainer) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(width: 60, height: 60, image: AssetImage(icon)),
              const SizedBox(height: 10),
              Text(title, style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.normal)),
            ],
          );
        },
      ),
    );
  }
}
