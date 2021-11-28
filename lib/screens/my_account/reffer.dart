import 'package:dotted_border/dotted_border.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/my_accout_screen_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/screens/my_account/Account_screen.dart';
import 'package:quikk_customer/widgets/custom_back_button.dart';

class ReferScreen extends StatelessWidget {
  const ReferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<MyAccountScreenController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(Constant.KSecondaryColor),
        leading: CustomBackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 32,
                ),
                height: MediaQuery.of(context).size.height * .55,
                decoration: BoxDecoration(
                    color: Color(Constant.KSecondaryColor),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(64),
                      bottomRight: Radius.circular(64),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 8),
                        blurRadius: 8,
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Refer your friends and Earn',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Lottie.asset(
                          Constant.KLottieAsset + 'invite_gif.json',
                          width: 100,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          controller.getAccountReferModel!.referalCoin
                              .toString(),
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          'Quikk coins',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Cheers! A new offer coming on your way '
                              '\nYou win ${controller.getAccountReferModel!.referalCoin
                              .toString()} coins on every referral',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => controller.onReferCodeClick(),
                      child: Column(
                        children: [
                          DottedBorder(
                            color: Colors.white,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(8),
                            padding: EdgeInsets.all(6),
                            child: Container(
                              height: 32,
                              width: 120,
                              // color: Colors.amber,
                              child: Center(
                                child: Text(
                                  controller.getAccountReferModel!.userRefcode
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Tap here to share this code',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Frequently Asked Questions',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                      alignment: Alignment.center,
                      headerAlignment: ExpandablePanelHeaderAlignment.center),
                  header: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      // vertical: 16,
                    ),
                    child: Text(
                      'What is Refer and Earn Program?',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      Constant.KWhatReferProgram,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black38,
                          ),
                      softWrap: true,
                    ),
                  ),
                  collapsed: SizedBox(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                      alignment: Alignment.center,
                      headerAlignment: ExpandablePanelHeaderAlignment.center),
                  header: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      // vertical: 16,
                    ),
                    child: Text(
                      'How it work?',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      Constant.KReferHowToUse,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black38,
                          ),
                      softWrap: true,
                    ),
                  ),
                  collapsed: SizedBox(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                      alignment: Alignment.center,
                      headerAlignment: ExpandablePanelHeaderAlignment.center),
                  header: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      // vertical: 16,
                    ),
                    child: Text(
                      'How to Redeem?',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      Constant.KReferHowToRedeem,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black38,
                          ),
                      softWrap: true,
                    ),
                  ),
                  collapsed: SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
