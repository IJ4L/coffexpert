import 'package:coffe_brain/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/hero.png",
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
                    height: 4.h,
                    width: 100.w,
                    margin: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: kGreyColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'Sistem pakar yang dikembangkan khusus untuk mendeteksi, mendiagnosis, dan memberikan solusi terkait penyakit yang mungkin menyerang tanaman kopi',
                      style: blackTextStyle.copyWith(
                        fontWeight: regular,
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      '/menu-utama',
                    ),
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
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
