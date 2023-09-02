import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:riverpod_todo/common/widgets/appstyle.dart';
import 'package:riverpod_todo/common/widgets/height_spacer.dart';
import 'package:riverpod_todo/common/widgets/reuseable_text.dart';
import 'package:riverpod_todo/common/widgets/width_spacer.dart';

class BottomTitles extends StatelessWidget {
  final String text;
  final String text2;
  final Color? clr;
  const BottomTitles({super.key, required this.text, required this.text2,this.clr});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.kwidth,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(builder: (context, ref, child) {
              return Container(
                height: 80,
                width: 5,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppConst.kRadius)),
                    color: AppConst.kGreen),
              );
            }),
            const WidthSpacer(width: 15),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(
                      text: text,
                      style: appstyle(24, AppConst.kLight, FontWeight.bold)),
                  const HeightSpacer(height: 24),
                  ReuseableText(
                      text: text2,
                      style: appstyle(12, AppConst.kLight, FontWeight.normal)),
                  const HeightSpacer(height: 24),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
