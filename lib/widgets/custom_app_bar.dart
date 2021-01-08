// Created by AMIT JANGID on 08/01/21.

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_society_app/blocs/blocs.dart';
import 'package:housing_society_app/firebase/auth_methods.dart';
import 'package:housing_society_app/routes/routes.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:housing_society_app/utils/utils.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isHomePage, centerTitle, showActionBtn;

  CustomAppBar({
    @required this.title,
    this.isHomePage = false,
    this.centerTitle = false,
    this.showActionBtn = false,
  });

  @override
  Widget build(BuildContext context) {
    String _profilePhoto = '';
    final UsersBloc _usersBloc = Provider.of<UsersBloc>(context);

    if (_usersBloc.users != null && _usersBloc.users.profilePhoto != null && _usersBloc.users.profilePhoto.isNotEmpty) {
      _profilePhoto = _usersBloc.users.profilePhoto;
    }

    return AppBar(
      elevation: 4,
      title: Text(title),
      centerTitle: centerTitle,
      brightness: Brightness.dark,
      leading: isHomePage
          ? Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                      width: 24,
                      height: 24,
                      image: _profilePhoto.isNotEmpty
                          ? CachedNetworkImageProvider(_profilePhoto)
                          : AssetImage(kIconPerson)),
                ),
                onTap: () {},
              ),
            )
          : IconButton(
              onPressed: () => isHomePage ? onWillPop() : Navigator.pop(context),
              icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
            ),
      actions: [
        if (showActionBtn) ...[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              if (await AuthMethods.signOut()) {
                Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);
              }
            },
          ),
        ],
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
