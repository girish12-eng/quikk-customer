import 'package:flutter/material.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';

class TrackOrderScreen extends StatelessWidget {
  final int status;
  final String statusName;

  const TrackOrderScreen(
      {Key? key, required this.status, required this.statusName})
      : super(key: key);

  // final int? statusValue;
  //
  // void getStatus() {
  //   if (widget.status == '5') {
  //     statusValue = 0;
  //   } else if (widget.status == '14') {
  //     statusValue = 1;
  //   } else if (widget.status == '15') {
  //     statusValue = 2;
  //   } else if (widget.status == '17') {
  //     statusValue = 3;
  //   } else if (widget.status == '20') {
  //     statusValue = 4;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print(status);
    print(statusName);
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(
          'Track Order',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Theme(
        data: ThemeData(
          // accentColor: Colors.orange,
          // primarySwatch: Colors.orange,
          colorScheme: ColorScheme.light(
            primary: Color(Constant.KPrimaryColor),
          ),
        ),
        child: Stepper(
          physics: ClampingScrollPhysics(),
          steps: getTrackingSteps(context, statusName, status),
          onStepContinue: () {},
          onStepCancel: () {},
          controlsBuilder: (BuildContext context,
              {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
            return Row(
              children: <Widget>[
                Container(
                  child: null,
                ),
                Container(
                  child: null,
                ),
              ],
            );
          },
          currentStep: status == 5
              ? 0
              : status == 14
                  ? 1
                  : status == 15
                      ? 2
                      : status == 17
                          ? 3
                          : status == 20
                              ? 4
                              : 0,
        ),
      ),
    );
  }

  List<Step> getTrackingSteps(BuildContext context, statusName, status) {
    List<Step> _orderStatusSteps = [];
    if (status == 10) {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'Order Cancelled',
          style: Theme.of(context).textTheme.subhead,
        ),
        content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
          ),
        ),
        isActive: (status >= 10),
      ));
    } else {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'Pending',
          style: Theme.of(context).textTheme.subhead,
        ),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
        isActive: status >= 5,
      ));
    }
    if (status == 12) {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'Reject',
          style: Theme.of(context).textTheme.subhead,
        ),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '',
            )),
        isActive: status >= 12,
      ));
    } else {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'Accepted',
          style: Theme.of(context).textTheme.subhead,
        ),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
        isActive: status >= 14,
      ));
    }
    _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'In Process ',
        style: Theme.of(context).textTheme.subhead,
      ),
      content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          )),
      isActive: status >= 15,
    ));
    _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'On The Way',
        style: Theme.of(context).textTheme.subhead,
      ),
      content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          )),
      isActive: status >= 17,
    ));
    _orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'Order Completed',
        style: Theme.of(context).textTheme.subhead,
      ),
      content: SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          )),
      isActive: status >= 20,
    ));
    return _orderStatusSteps;
  }
}
