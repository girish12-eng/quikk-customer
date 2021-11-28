import 'package:flutter/material.dart';
import 'package:zendesk2/chat2/model/provider_enums.dart';
import 'package:zendesk2/chat2/zendesk_chat2.dart';

import 'dddddddddddddddddd.dart';

class Homelll extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Homelll> {
  void zendesk(bool isNativeChat, BuildContext context) async {
    String accountKey = '1YEEURxhUvlhgIomBTlw9lxja9WOGl8H';
    String appId = '61a7c55b-8d27-41e6-9b40-74b5fc483209';

    String name = 'name';
    String email = 'name@lol.789';
    String phoneNumber = '4455445544';

    Zendesk2Chat z = Zendesk2Chat.instance;

    await z.logger(true);

    await z.init(accountKey, appId, iosThemeColor: Colors.yellow);

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
      print('rrrrrrrrrrrrrr');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ZendeskChat()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Text('Press on FAB to start chat'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'customChat',
        // icon: Icon(FontAwesomeIcons.comments),
        label: Text('Custom Chat'),
        onPressed: () => zendesk(false, context),
      ),
    );
  }
}
