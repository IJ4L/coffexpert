import 'package:coffe_brain/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Menuscreen extends StatelessWidget {
  const Menuscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 300.h,
                decoration: const BoxDecoration(color: kWhiteColor),
              ),
              Container(
                height: 300.h,
                width: double.infinity,
                padding: EdgeInsets.all(36.r),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sistem Pakar\nPenyakit Tanaman Kopi',
                        style: cocolateTextStyle.copyWith(
                          fontSize: 20.sp,
                          fontWeight: semiBold,
                        ),
                        textScaleFactor: 1,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 26.h),
                        child: Text(
                          'Lorem ipsum dolor sit amet consectetur. Aliquam duis odio mattis risus felis nibh. Elit imperdiet aliquam odio urna amet pulvinar ultrices. Integer ultrices in quis pellentesque eu in convallis. ',
                          style: cocolateTextStyle.copyWith(
                            fontWeight: regular,
                          ),
                          textScaleFactor: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -30.h,
                left: -30.w,
                child: Container(
                  height: 102.r,
                  width: 102.r,
                  decoration: BoxDecoration(
                    color: kSkinColor,
                    borderRadius: BorderRadius.circular(102.r / 2),
                  ),
                ),
              ),
              Positioned(
                bottom: 30.h,
                right: -120.w,
                child: Container(
                  height: 156.r,
                  width: 156.r,
                  decoration: BoxDecoration(
                    color: kSkinColor,
                    borderRadius: BorderRadius.circular(156.r / 2),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                height: 290.h,
                decoration: const BoxDecoration(color: kPrimaryColor),
              ),
              Container(
                height: 350.h,
                width: double.infinity,
                padding: EdgeInsets.all(30.r),
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/diagnosis',
                      ),
                      child: Container(
                        width: 140.w,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Diagnosa\nPenyakit',
                                style: cocolateTextStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Test Now', style: cocolateTextStyle),
                                const Icon(
                                  Icons.arrow_forward_outlined,
                                  color: kSecondColor,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 140.h,
                            width: 140.w,
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Hama dan\nPenyakit',
                                  style: cocolateTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 140.h,
                          width: 140.w,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.logout_outlined,
                              color: kSecondColor,
                              size: 30.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}