import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/theme.dart';

class Diagnosisvalue extends StatelessWidget {
  const Diagnosisvalue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_outlined, color: kBlackColor),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
              ),
            ),
            Positioned(
              top: 10.h,
              child: Column(
                children: [
                  Container(
                    height: 180.h,
                    width: MediaQuery.of(context).size.width - 32.w,
                    margin: EdgeInsets.only(
                      right: 16.w,
                      left: 16.w,
                      bottom: 25.h,
                    ),
                    decoration: BoxDecoration(
                      color: kSecondColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  Text(
                    'Karat Daun\n(Hemilia Vasatrix)',
                    style: blackTextStyle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: semiBold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 39.h,
                    width: 310.w,
                    margin: EdgeInsets.symmetric(vertical: 25.h),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Solusi',
                          style: blackTextStyle,
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                  Container(
                    width: 310.w,
                    padding: EdgeInsets.all(22.r),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'Lorem ipsum dolor sit amet consectetur. Metus donec interdum enim sem id montes. Risus malesuada feugiat amet mi dignissim. Viverra pellentesque ut arcu rhoncus eu. Ac morbi nunc arcu suspendisse lacinia. Vivamus vulputate hac vel velit at facilisis lectus at diam. Lorem habitant eu.',
                      style: blackTextStyle,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}