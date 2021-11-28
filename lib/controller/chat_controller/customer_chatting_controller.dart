import 'package:flutter/material.dart';
import 'package:quikk_customer/screens/chatting/chatting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zendesk2/chat2/model/provider_enums.dart';
import 'package:zendesk2/chat2/zendesk_chat2.dart';

class CustomerChattingController {
  late SharedPreferences _preferences;

  void zendesk(bool isNativeChat, BuildContext context) async {
    _preferences = await SharedPreferences.getInstance();
    String name = _preferences.getString('name')!;
    String email = _preferences.getString('email')!;
    String phoneNumber = _preferences.getString('phone')!;
    print(name);
    print(email);
    print(phoneNumber);
    String accountKey = '1YEEURxhUvlhgIomBTlw9lxja9WOGl8H';
    String appId = '342977214746222593';

    Zendesk2Chat z = Zendesk2Chat.instance;

    await z.logger(true);

    await z.init(accountKey, appId, );

    await z.setVisitorInfo(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      tags: ['app', 'zendesk2_plugin'],
    );
    await z.customize(
      departmentFieldStatus: PRE_CHAT_FIELD_STATUS.HIDDEN,
      emailFieldStatus: PRE_CHAT_FIELD_STATUS.HIDDEN,
      nameFieldStatus: PRE_CHAT_FIELD_STATUS.HIDDEN,
      phoneFieldStatus: PRE_CHAT_FIELD_STATUS.HIDDEN,
      transcriptChatEnabled: true,
      agentAvailability: true,
      endChatEnabled: true,
      offlineForms: true,
      preChatForm: true,
      transcript: true,
    );

    if (isNativeChat) {
      await z.startChatProviders();
    } else {
      await Zendesk2Chat.instance.startChatProviders();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChattingScreen(),
        ),
      );
    }
  }
}
