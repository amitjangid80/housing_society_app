// Created by AMIT JANGID on 08/01/21.

import 'package:flutter/material.dart';
import 'package:housing_society_app/models/facitility.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:housing_society_app/widgets/custom_app_bar.dart';
import 'package:housing_society_app/widgets/custom_button.dart';
import 'package:housing_society_app/widgets/image_from_network.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacilitiesScreen extends StatefulWidget {
  @override
  _FacilitiesScreenState createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  List<Facility> _facilitiesList = [];

  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    // calling get shared preferences data method
    _getSharedPreferencesData();

    // calling get facilities from db method
    _getFacilitiesFromDb();
  }

  _getSharedPreferencesData() async {
    final _prefs = await SharedPreferences.getInstance();
    bool _isFacilityDataInserted = _prefs.getBool(kPrefsIsFacilityDataInserted);

    if (_isFacilityDataInserted == null) {
      for (int i = 0; i < facilitiesList.length; i++) {
        // calling insert into facility table method
        await FacilityDb.insertIntoFacilityTable(facility: facilitiesList[i]);
      }

      _prefs.setBool(kPrefsIsFacilityDataInserted, true);
    }
  }

  _getFacilitiesFromDb() async {
    await Future.delayed(const Duration(seconds: 1));

    await FacilityDb.getFacilitiesList().then((facilitiesList) {
      setState(() {
        _isLoading = false;
        _facilitiesList = facilitiesList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: kFacilities),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _facilitiesList?.length ?? 0,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemBuilder: (context, _position) {
                Facility _facility = _facilitiesList[_position];
                int _itemCount = _facilitiesList.length > 15 ? 15 : _facilitiesList.length;

                return SlideAnimation(
                  position: _position,
                  itemCount: _itemCount,
                  slideDirection: SlideDirection.fromBottom,
                  animationController: _animationController,
                  child: _ItemFacility(facility: _facility),
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}

class _ItemFacility extends StatelessWidget {
  final Facility facility;

  _ItemFacility({this.facility});

  @override
  Widget build(BuildContext context) {
    return MaterialCard(
      borderRadius: 15,
      padding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          Positioned.fill(child: ImageFromNetwork(borderRadius: 0, imageUrl: facility.facilityImage)),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 120),
            color: Colors.transparent.withOpacity(0.6),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        facility.facilityName,
                        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      RichTextWidget(
                        caption: kCharges,
                        description: '$kRupeeSymbol ${facility.facilityCharges.toStringAsFixed(0)}',
                        captionStyle: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                        descriptionStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      RichTextWidget(
                        caption: kAvailable,
                        description: facility.facilityAvailable == 1 ? kYes : kNo,
                        captionStyle: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                        descriptionStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(child: CustomButton(text: kBook, onPressed: () {}, margin: const EdgeInsets.all(0))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
