import 'package:coffe_brain/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          SizedBox(
            height: 420.h,
            width: double.infinity,
            child: SvgPicture.asset('assets/images/img_splash.svg'),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300.h,
              width: double.infinity,
              padding: EdgeInsets.only(top: 28.h),
              decoration: const BoxDecoration(color: kWhiteColor),
              child: Column(
                children: [
                  Text(
                    'SISTEM PAKAR',
                    style: cocolateTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 28.sp,
                    ),
                    textScaleFactor: 1,
                  ),
                  Container(
                    height: 2.h,
                    width: 100.w,
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: kGreyColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur.\nCommodo morbi quis maecenas lacus\nvestibulum ultricies risus. ',
                    style: blackTextStyle.copyWith(
                        fontWeight: regular, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/menu-utama'),
                    child: Container(
                      height: 36.h,
                      width: 150.w,
                      margin: EdgeInsets.only(top: 28.h),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: cocolateTextStyle.copyWith(
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
