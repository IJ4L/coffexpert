import 'package:coffe_brain/cubit/updown_cubit.dart';
import 'package:coffe_brain/shared/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/theme.dart';

class InfoHamaPage extends StatelessWidget {
  const InfoHamaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: kBlackColor,
            size: 18.r,
          ),
        ),
        title: Text(
          'Hama Dan Penyakit info',
          style: cocolateTextStyle,
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          var condition = context.read<UpdownCubit>();
          return GestureDetector(
            onTap: () => condition.klik(index),
            child: BlocBuilder<UpdownCubit, int>(
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        borderRadius: state == index
                            ? BorderRadius.vertical(top: Radius.circular(8.r))
                            : BorderRadius.circular(8.r),
                        color: state == index ? kPrimaryColor : kWhiteColor,
                        border: Border.all(
                          color: kPrimaryColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            penyakit[index],
                            style: cocolateTextStyle,
                          ),
                          state == index
                              ? const Icon(
                                  Icons.arrow_drop_down,
                                  color: kWhiteColor,
                                )
                              : const Icon(
                                  Icons.arrow_drop_up,
                                  color: kPrimaryColor,
                                )
                        ],
                      ),
                    ),
                    state != index
                        ? Container()
                        : Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(8.r),
                              ),
                              color: kPrimaryColor,
                            ),
                            child: Text(
                              deskripsi[index],
                              style:
                                  cocolateTextStyle.copyWith(fontSize: 10.sp),
                            ),
                          ),
                  ],
                );
              },
            ),
          );
        },
        separatorBuilder: (_, index) => SizedBox(height: 8.h),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        itemCount: penyakit.length,
      ),
    );
  }
}
