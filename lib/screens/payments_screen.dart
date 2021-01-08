// Created by AMIT JANGID on 08/01/21.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housing_society_app/blocs/blocs.dart';
import 'package:housing_society_app/firebase/payments_methods.dart';
import 'package:housing_society_app/models/payments.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:housing_society_app/widgets/custom_app_bar.dart';
import 'package:housing_society_app/widgets/raised_button.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:provider/provider.dart';

class PaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UsersBloc _usersBloc = Provider.of<UsersBloc>(context);

    return Scaffold(
      appBar: CustomAppBar(title: kPayments),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder<QuerySnapshot>(
          stream: PaymentsMethod.getPaymentDetails(userId: _usersBloc.users.uid),
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
                  Payments _payments = Payments.fromJson(_docList[_position].data());

                  return _ItemPayment(payments: _payments);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _ItemPayment extends StatelessWidget {
  final Payments payments;

  _ItemPayment({@required this.payments});

  @override
  Widget build(BuildContext context) {
    return MaterialCard(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichTextWidget(
                  isDescNewLine: true,
                  caption: payments.description,
                  description: '$kRupeeSymbol ${payments.amount.toString()}',
                  descriptionStyle: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 10),
                RichTextWidget(
                  isDescNewLine: true,
                  caption: kBillMonth,
                  description: '${payments.billMonth}',
                  descriptionStyle: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Expanded(
            child: payments.paid
                ? RichTextWidget(
                    caption: kPaidOn,
                    isDescNewLine: true,
                    descriptionStyle: Theme.of(context).textTheme.headline6,
                    description: formatDateTime(
                      payments.paidOn.toDate().toString(),
                      newDateTimeFormat: kFullDateDisplayFormat,
                    ),
                  )
                : CustomButton(text: kPayNow, onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
