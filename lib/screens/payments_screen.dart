// Created by AMIT JANGID on 08/01/21.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housing_society_app/firebase/payments_methods.dart';
import 'package:housing_society_app/models/payments.dart';
import 'package:housing_society_app/utils/constants.dart';
import 'package:housing_society_app/widgets/custom_app_bar.dart';
import 'package:housing_society_app/widgets/custom_button.dart';
import 'package:multiutillib/multiutillib.dart';

class PaymentsScreen extends StatefulWidget {
  final String uId;

  PaymentsScreen({@required this.uId});

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> with SingleTickerProviderStateMixin {
  Stream _paymentsStream;
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

    setState(() => _paymentsStream = PaymentsMethod.getPaymentDetails(userId: widget.uId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: kPayments),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder<QuerySnapshot>(
          stream: _paymentsStream,
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
                  int _itemCount = _docList.length > 15 ? 15 : _docList.length;
                  Payments _payments = Payments.fromJson(_docList[_position].data());

                  return SlideAnimation(
                    position: _position,
                    itemCount: _itemCount,
                    child: _ItemPayment(payments: _payments),
                    slideDirection: SlideDirection.fromRight,
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

class _ItemPayment extends StatelessWidget {
  final Payments payments;

  _ItemPayment({@required this.payments});

  @override
  Widget build(BuildContext context) {
    return MaterialCard(
      borderRadius: 15,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichTextWidget(
                  isDescNewLine: true,
                  caption: payments.description,
                  descriptionStyle: Theme.of(context).textTheme.bodyText1,
                  description: '$kRupeeSymbol ${payments.amount.toString()}',
                ),
                const SizedBox(height: 10),
                RichTextWidget(
                  isDescNewLine: true,
                  caption: kBillMonth,
                  description: '${payments.billMonth}',
                  descriptionStyle: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          Expanded(
            child: payments.paid
                ? RichTextWidget(
                    caption: kPaidOn,
                    isDescNewLine: true,
                    descriptionStyle: Theme.of(context).textTheme.bodyText1,
                    description: formatDateTime(
                      payments.paidOn.toDate().toString(),
                      newDateTimeFormat: kFullDateDisplayFormat,
                    ),
                  )
                : CustomButton(text: kPayNow, onPressed: () {}, margin: const EdgeInsets.all(0)),
          ),
        ],
      ),
    );
  }
}
