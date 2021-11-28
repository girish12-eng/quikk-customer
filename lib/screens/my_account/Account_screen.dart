import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/my_accout_screen_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/screens/chatting/customer_chat_intro.dart';
import 'package:quikk_customer/screens/my_account/address/manage_address.dart';
import 'package:quikk_customer/screens/my_account/help_support/web_view.dart';
import 'package:quikk_customer/screens/my_account/reffer.dart';
import 'package:quikk_customer/widgets/custom_loading.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MyAccountScreenController>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<MyAccountScreenController>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: controller.getLoading
              ? Center(
                  child: CustomLoading(),
                )
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey.withOpacity(.4),
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '${controller.getName}',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Text(
                        '${controller.getEmail}',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black38,
                            ),
                      ),
                      Text(
                        '${controller.getPhone}',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black38,
                            ),
                      ),
                      SizedBox(
                        height: 16,
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        leading: Icon(
                          Icons.home_outlined,
                          color: Color(Constant.KSecondaryColor),
                        ),
                        title: Text(
                          'Manage Address',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        onTap: () =>
                            Future.delayed(Duration(milliseconds: 400)).then(
                          (value) => pushNewScreen(
                            context,
                            screen: ManageAddressScreen(),
                            withNavBar: false,
                            // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        leading: Icon(
                          Icons.supervisor_account_outlined,
                          color: Color(Constant.KSecondaryColor),
                        ),
                        title: Text(
                          'Refer & Earn',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        onTap: () =>
                            Future.delayed(Duration(milliseconds: 400)).then(
                          (value) => pushNewScreen(
                            context,
                            screen: ReferScreen(),
                            withNavBar: false,
                            // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        leading: Icon(
                          Icons.assignment_outlined,
                          color: Color(Constant.KSecondaryColor),
                        ),
                        title: Text(
                          'Terms & Conditions',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        onTap: () =>
                            Future.delayed(Duration(milliseconds: 400)).then(
                          (value) => pushNewScreen(
                            context,
                            screen: WebViewMobileScreen(
                              url: 'https://quikkdelivery.com/mobileterms',
                            ),
                            withNavBar: false,
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        leading: Icon(
                          Icons.loop_outlined,
                          color: Color(Constant.KSecondaryColor),
                        ),
                        title: Text(
                          'Return Policies',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        onTap: () =>
                            Future.delayed(Duration(milliseconds: 400)).then(
                          (value) => pushNewScreen(
                            context,
                            screen: WebViewMobileScreen(
                              url: 'https://quikkdelivery.com/mobilereturns',
                            ),
                            withNavBar: false,
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        leading: Icon(
                          Icons.policy_outlined,
                          color: Color(Constant.KSecondaryColor),
                        ),
                        title: Text(
                          'Privacy',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        onTap: () =>
                            Future.delayed(Duration(milliseconds: 400)).then(
                          (value) => pushNewScreen(
                            context,
                            screen: WebViewMobileScreen(
                              url: 'https://quikkdelivery.com/mobileprivacy',
                            ),
                            withNavBar: false,
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        leading: Icon(
                          Icons.support_agent_outlined,
                          color: Color(Constant.KSecondaryColor),
                        ),
                        title: Text(
                          'Customer Support',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        onTap: () =>
                            Future.delayed(Duration(milliseconds: 400)).then(
                          (value) => pushNewScreen(
                            context,
                            screen: CustomerChatting(),
                            withNavBar: false,
                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        leading: Icon(
                          Icons.logout_outlined,
                          color: Color(Constant.KSecondaryColor),
                        ),
                        title: Text(
                          'Logout',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        onTap: () =>
                            Future.delayed(Duration(milliseconds: 400)).then(
                          (value) => controller.onLogOutButtonPressed(context),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
