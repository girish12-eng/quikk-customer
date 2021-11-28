import 'package:flutter/material.dart';
import 'package:quikk_customer/helper/constants.dart';

class CustomSendMessageBox extends StatelessWidget {
  final Function send;
  final Function attach;
  final  tEDController;

  CustomSendMessageBox({Key? key, required this.send, required this.attach, this.tEDController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => attach(),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  color: Constant.KPrimary1Color,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              child: TextField(
                controller: tEDController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write a response...',
                  hintStyle: Theme.of(context).textTheme.caption,
                ),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            // ElevatedButton(
            //   style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all<Color>(
            //         Color(0xffF8F9FC),
            //       ),
            //       shape:
            //           MaterialStateProperty.all<CircleBorder>(CircleBorder())),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Icon(
            //       Icons.send,
            //       color: Color(0xff7F7DFA),
            //     ),
            //   ),
            //   onPressed: () {
            //     data.onSendButtonPressed(roomId, userId);
            //   },
            // )
            Material(
              color: Colors.white,
              child: Container(
                color: Colors.transparent,
                child: InkWell(
                  splashFactory: InkRipple.splashFactory,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.send,
                        color: Constant.KPrimary1Color,
                      ),
                    ),
                  ),
                  onTap: () => send(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
