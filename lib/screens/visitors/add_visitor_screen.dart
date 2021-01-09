// Created by AMIT JANGID on 08/01/21.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_society_app/app_theme.dart';
import 'package:housing_society_app/blocs/blocs.dart';
import 'package:housing_society_app/firebase/visitors_method.dart';
import 'package:housing_society_app/models/visitor.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:housing_society_app/widgets/custom_app_bar.dart';
import 'package:housing_society_app/widgets/custom_button.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:provider/provider.dart';

class AddVisitorScreen extends StatefulWidget {
  @override
  _AddVisitorScreenState createState() => _AddVisitorScreenState();
}

class _AddVisitorScreenState extends State<AddVisitorScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _visitingDateController = TextEditingController();

  List<bool> _isSelected;
  List<String> _visitorTypeList = [kGuest, kMaid, kParcel];

  DateTime _visitingDate;
  String _visitorsName, _visitorsType;
  bool _dailyVisitor = false, _approved = false;

  @override
  void initState() {
    super.initState();

    _isSelected = [true, false, false];
    _visitorsType = _visitorTypeList[0];
  }

  @override
  Widget build(BuildContext context) {
    final UsersBloc _usersBloc = Provider.of<UsersBloc>(context);

    return Scaffold(
      appBar: CustomAppBar(title: kAddVisitor),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeAnimation(
                        delay: 1,
                        child: TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          onSaved: (_input) => _visitorsName = _input,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(labelText: kVisitorsName),
                          validator: (_input) {
                            if (_input.isEmpty) {
                              return kEnterVisitorsName;
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeAnimation(
                        delay: 1.2,
                        child: Center(
                          child: ToggleButtons(
                            borderWidth: 1,
                            color: kPrimaryColor,
                            isSelected: _isSelected,
                            borderColor: kPrimaryColor,
                            splashColor: Colors.white24,
                            fillColor: kPrimaryLightColor,
                            selectedBorderColor: kPrimaryColor,
                            borderRadius: BorderRadius.circular(30),
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(kGuest, style: Theme.of(context).textTheme.bodyText2),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(kMaid, style: Theme.of(context).textTheme.bodyText2),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(kParcel, style: Theme.of(context).textTheme.bodyText2),
                              ),
                            ],
                            onPressed: (int _selectedIndex) {
                              setState(() {
                                for (int i = 0; i < _isSelected.length; i++) {
                                  _isSelected[i] = i == _selectedIndex;
                                }

                                _visitorsType = _visitorTypeList[_selectedIndex];
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeAnimation(
                        delay: 1.4,
                        child: TextFormField(
                          readOnly: true,
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          onTap: () => _selectVisitingDate(),
                          controller: _visitingDateController,
                          decoration: InputDecoration(
                            labelText: kVisitingDate,
                            suffixIcon: Icon(FontAwesomeIcons.calendarAlt, color: kPrimaryColor),
                          ),
                          validator: (_input) {
                            if (_input.isEmpty) {
                              return kSelectVisitingDate;
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeAnimation(
                        delay: 1.6,
                        child: SwitchListTile.adaptive(
                          dense: true,
                          value: _dailyVisitor,
                          contentPadding: const EdgeInsets.all(0),
                          onChanged: (_value) => setState(() => _dailyVisitor = _value),
                          title: Text(kDailyVisitor, style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ),
                      FadeAnimation(
                        delay: 1.8,
                        child: SwitchListTile.adaptive(
                          dense: true,
                          value: _approved,
                          contentPadding: const EdgeInsets.all(0),
                          onChanged: (_value) => setState(() => _approved = _value),
                          title: Text(kApprove, style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          CustomButton(
            text: kSave,
            borderRadius: 0,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                Visitor _visitor = Visitor(
                  approved: _approved,
                  visitorName: _visitorsName,
                  visitorType: _visitorsType,
                  dailyVisitor: _dailyVisitor,
                  visitingDate: Timestamp.fromDate(_visitingDate),
                  visitorPhoto: 'https://cdn.pixabay.com/photo/2015/06/22/08/40/child-817373_960_720.jpg',
                );

                // calling add data to visitors collection method
                bool _saveResult = await VisitorsMethod.addDataToVisitorsCollection(
                  visitor: _visitor,
                  users: _usersBloc.users,
                );

                if (_saveResult) {
                  await showCustomDialog(context, title: kSuccess, description: kVisitorSavedSuccessMsg);
                  Navigator.pop(context);
                } else {
                  showCustomDialog(context, title: kError, description: kVisitorSavedFailedMsg);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  _selectVisitingDate() async {
    DateTime _datePicked = await showDatePicker(
      context: context,
      lastDate: DateTime(2100),
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (_datePicked != null) {
      TimeOfDay _timePicked = await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (_timePicked != null) {
        _visitingDate = _datePicked.add(Duration(hours: _timePicked.hour, minutes: _timePicked.minute));
        _visitingDateController.text = formatDateTime(_visitingDate.toString(), newDateTimeFormat: kTimeDateFormat);
      }
    }
  }

  @override
  void dispose() {
    _visitingDateController.dispose();

    super.dispose();
  }
}
