import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCoupon extends StatelessWidget {
  final color;
  final code;
  final description;

  CustomCoupon({
    Key? key,
    required this.color,
    this.code,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 152.7, 197.8),
          size: Size(152.7, 197.8),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: SvgPicture.string(
            _svg_kvrdd1,
            color: Color(color).withOpacity(.2),
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 10,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Color(color),
            child: Text('%'),
          ),
        ),
        Positioned(
          top: 50,
          child: SizedBox(
            width: 80,
            child: Text(
              code,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(color),
                  ),
            ),
          ),
        ),
        Positioned(
          top: 70,
          child: SizedBox(
            width: 80,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(color),
                  ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 10,
          child: CircleAvatar(
            radius: 4,
            backgroundColor: Color(color).withOpacity(.4),
          ),
        ),
        Positioned(
          top: 32,
          left: 16,
          child: CircleAvatar(
            radius: 6,
            backgroundColor: Color(color).withOpacity(.4),
          ),
        ),
        Positioned(
          top: 12,
          right: 16,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Color(color).withOpacity(.4),
          ),
        ),
        Positioned(
          bottom: 32,
          left: 8,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Color(color).withOpacity(.4),
          ),
        ),
        Positioned(
          bottom: 24,
          right: 32,
          child: CircleAvatar(
            radius: 5,
            backgroundColor: Color(color).withOpacity(.4),
          ),
        ),
      ],
    );
  }
}

const String _svg_kvrdd1 =
    '<svg viewBox="0.0 0.0 152.7 197.8" ><path transform="translate(-76.71, -275.95)" d="M 76.71222686767578 275.94580078125 L 76.71222686767578 473.7251586914063 L 102.8888931274414 449.0027160644531 L 121.7942657470703 473.7251586914063 L 142.1539154052734 449.0027160644531 L 159.6049957275391 473.7251586914063 L 174.1475982666016 449.0027160644531 L 193.0530242919922 473.7251586914063 L 210.5040893554688 449.0027160644531 L 229.4095153808594 473.7251586914063 L 229.4095153808594 275.94580078125 L 76.71222686767578 275.94580078125 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
