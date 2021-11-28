import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quikk_customer/helper/constants.dart';

class CustomMessageBubble extends StatelessWidget {
  final bool user;
  final name;
  final message;
  final time;

  const CustomMessageBubble({
    Key? key,
    required this.user, required this.name,required this.message,required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          // color: Colors.white,
        color:user? Constant.KPrimary1Color:Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 10,
                    color: user ? Colors.white60 : Colors.black54,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .6),
                  child: Text(
                    message,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: user ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              time,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption!.copyWith(
                fontSize: 10,
                color: user ? Colors.white60 : Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
