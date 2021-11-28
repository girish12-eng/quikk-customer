import 'package:flutter/material.dart';
import 'package:quikk_customer/controller/chat_controller/customer_chatting_controller.dart';
import 'package:quikk_customer/helper/constants.dart';

class CustomerChatting extends StatefulWidget {
  const CustomerChatting({Key? key}) : super(key: key);

  @override
  _CustomerChattingState createState() => _CustomerChattingState();
}

class _CustomerChattingState extends State<CustomerChatting> {
  final CustomerChattingController controller = CustomerChattingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('This is customer klefdnkdsf'),
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () => controller.zendesk(false, context),
        //   label: Text('Start Chatting'),
        // ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(Constant.KAsset + 'chat_icon.jpg'),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'How can we help you?',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.black54,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xff649176),
                      ),
                    ),
                    onPressed: () => controller.zendesk(false, context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Start Chatting'),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xff7eaf92),
                    child: Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Send us an e-mail',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  Text(
                    'info.quikkdelivery@gmail.com',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
