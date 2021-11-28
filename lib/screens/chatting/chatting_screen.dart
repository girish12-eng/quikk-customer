import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quikk_customer/controller/chat_controller/chatting_controller.dart';
import 'package:quikk_customer/helper/constants.dart';
import 'package:quikk_customer/widgets/custom_message_box.dart';
import 'package:quikk_customer/widgets/custom_message_bubble.dart';
import 'package:zendesk2/chat2/model/provider_enums.dart';
import 'package:zendesk2/chat2/model/provider_model.dart';
import 'package:intl/intl.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({Key? key}) : super(key: key);

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ChattingController>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ChattingController>(context);
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ChattingController>(context, listen: false).disp();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Constant.KPrimary1Color,
            ),
            onPressed: () {
              Provider.of<ChattingController>(context, listen: false).disp();
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Quikk Support',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          actions: [
            if (controller.providerModel != null)
              Icon(
                Icons.circle,
                color: controller.providerModel!.connectionStatus ==
                        CONNECTION_STATUS.CONNECTED
                    ? Colors.green
                    : controller.providerModel!.connectionStatus ==
                            CONNECTION_STATUS.CONNECTING
                        ? Colors.yellow
                        : Colors.red,
              )
          ],
          centerTitle: true,
        ),
        body: controller.providerModel!.connectionStatus !=
                CONNECTION_STATUS.CONNECTED
            ? Center(
                child: SizedBox(
                    width: 250,
                    child: Lottie.asset(
                        Constant.KLottieAsset + 'connecting.json')),
              )
            : Stack(
                children: [
                  if (controller.providerModel != null)
                    ListView.builder(
                      padding: EdgeInsets.only(bottom: 200),
                      itemCount: controller.providerModel!.logs.length,
                      itemBuilder: (context, index) {
                        ChatLog log = controller.providerModel!.logs[index];
                        ChatMessage chatMessage = log.chatLogType.chatMessage;
                        String message = chatMessage.message ?? '';

                        String name = log.displayName ?? '';

                        bool isAttachment = false;
                        bool isJoinOrLeave = false;
                        bool isRatingReview = false;
                        bool isRatingComment = false;
                        bool isAgent = log.chatLogParticipant.chatParticipant ==
                            CHAT_PARTICIPANT.AGENT;

                        Agent? agent;
                        if (isAgent)
                          agent = controller.providerModel!.agents.firstWhere(
                              (element) => element.displayName == name);

                        switch (log.chatLogType.logType) {
                          case LOG_TYPE.ATTACHMENT_MESSAGE:
                            message = 'Attachment';
                            isAttachment = true;
                            break;
                          case LOG_TYPE.CHAT_COMMENT:
                            ChatComment chatComment =
                                log.chatLogType.chatComment;
                            final comment = chatComment.comment ?? '';
                            final newComment = chatComment.newComment ?? '';
                            message = 'Rating comment: $comment\n'
                                'New comment: $newComment';
                            isRatingComment = true;
                            break;
                          case LOG_TYPE.CHAT_RATING:
                            message = 'Rating review: ' +
                                log.chatLogType.chatRating.rating
                                    .toString()
                                    .replaceAll('RATING.', '');
                            isRatingReview = true;
                            break;
                          case LOG_TYPE.CHAT_RATING_REQUEST:
                            message = 'Rating request';
                            break;
                          case LOG_TYPE.MEMBER_JOIN:
                            message = '$name Joined!';
                            isJoinOrLeave = true;
                            break;
                          case LOG_TYPE.MEMBER_LEAVE:
                            message = '$name Left!';
                            isJoinOrLeave = true;
                            break;
                          case LOG_TYPE.MESSAGE:
                            message = message;
                            break;
                          case LOG_TYPE.OPTIONS_MESSAGE:
                            message = 'Options message';
                            break;
                          case LOG_TYPE.UNKNOWN:
                            message = 'Unknown';
                            break;
                          case null:
                            message = 'LogType=null';
                            break;
                        }

                        bool isVisitor =
                            log.chatLogParticipant.chatParticipant ==
                                CHAT_PARTICIPANT.VISITOR;

                        final imageUrl = log.chatLogType.chatAttachment.url;

                        final mimeType = log.chatLogType.chatAttachment
                            .chatAttachmentAttachment.mimeType
                            ?.toLowerCase();
                        final isImage = mimeType == null
                            ? false
                            : (mimeType.contains('jpg') ||
                                mimeType.contains('png') ||
                                mimeType.contains('jpeg') ||
                                mimeType.contains('gif'));

                        return isJoinOrLeave ||
                                isRatingReview ||
                                isRatingComment
                            ? Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : isAttachment
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Column(
                                        children: [
                                          Image.network(
                                            imageUrl!,
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          Text(
                                            DateFormat(' kk:mm a')
                                                .format(log.createdTimestamp),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: isVisitor
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      CustomMessageBubble(
                                        user: isVisitor,
                                        name: log.displayName ?? '',
                                        message: chatMessage.message ?? 'dada',
                                        time: DateFormat(' kk:mm a')
                                            .format(log.createdTimestamp),
                                      ),
                                    ],
                                  );
                      },
                    ),
                  // Container(
                  //   // color: Colors.black12,
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           SizedBox(),
                  //           CustomMessageBubble(
                  //             user: true,
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           CustomMessageBubble(
                  //             user: false,
                  //           ),
                  //           SizedBox(),
                  //         ],
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           CustomMessageBubble(
                  //             user: false,
                  //           ),
                  //           SizedBox(),
                  //         ],
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           SizedBox(),
                  //           CustomMessageBubble(
                  //             user: true,
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           SizedBox(),
                  //           CustomMessageBubble(
                  //             user: true,
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Positioned(
                    bottom: 0,
                    child: CustomSendMessageBox(
                      send: controller.send,
                      attach: () => controller.attach(context),
                      tEDController: controller.chatTextTED,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
