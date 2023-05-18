import 'package:coffe_brain/cubit/select_gejala_cubit.dart';
import 'package:coffe_brain/shared/string.dart';
import 'package:coffe_brain/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Diagnosisscreen extends StatelessWidget {
  const Diagnosisscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_outlined, color: kBlackColor),
        ),
        actions: [
          BlocBuilder<SelectGejalaCubit, List<int>>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/diagnosis-value'),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: SvgPicture.asset(
                    'assets/icons/ico_science.svg',
                    width: 22.r,
                    height: 22.r,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 16.h),
        child: Column(
          children: [
            Container(
              height: 48.h,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 30.h),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                ),
              ),
              child: Center(
                child: Text(
                  'Gejala Penyakit Kopi',
                  style: cocolateTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return BlocBuilder<SelectGejalaCubit, List<int>>(
                    builder: (context, state) {
                      final isSelected = state.contains(index);
                      final selectEvent = context.read<SelectGejalaCubit>();
                      return GestureDetector(
                        onTap: () => isSelected != true
                            ? selectEvent.select(index)
                            : selectEvent.unselect(index),
                        child: Container(
                          padding: EdgeInsets.all(14.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected ? kGreenColor : kPrimaryColor,
                                offset: const Offset(0, 2),
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text('${index + 1}.', style: blackTextStyle),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  gejala[index],
                                  style: blackTextStyle,
                                ),
                              ),
                              isSelected != false
                                  ? SvgPicture.asset(
                                      'assets/icons/ico_succses.svg',
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (_, index) => SizedBox(height: 16.h),
                itemCount: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}




//081527029703