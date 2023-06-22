import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:coffe_brain/cubit/naive_bayes/naive_bayes_proces_cubit.dart';
import 'package:coffe_brain/cubit/select_gejala_cubit.dart';
import 'package:coffe_brain/shared/theme.dart';

import '../../shared/string.dart';

class DiagnosisValue extends StatelessWidget {
  const DiagnosisValue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectEvent = context.read<SelectGejalaCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            selectEvent.unselectAll();
          },
          child: const Icon(Icons.arrow_back_ios_outlined, color: kBlackColor),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GestureDetector(
              onTap: () {
                selectEvent.unselectAll();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/menu-utama',
                  (route) => false,
                );
              },
              child: Icon(
                Icons.close_outlined,
                color: kBlackColor,
                size: 24.r,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            BlocBuilder<NaiveBayesProcesCubit, NaiveBayesProcesState>(
              builder: (context, state) {
                if (state is NaiveBayesProcesLoaded) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.w,
                              vertical: 16.h,
                            ),
                            margin: EdgeInsets.only(top: 20.h),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: kPrimaryColor),
                            ),
                            child: Text(
                              penyakit[state.prediction.penyakit[index]
                                  ['penyakit']],
                              style: blackTextStyle.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 25.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    state.prediction.penyakit[index]
                                                ['penyakit'] >
                                            5
                                        ? "Penyakit"
                                        : "Hama",
                                    style: blackTextStyle.copyWith(
                                      fontSize: 12.sp,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 25.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    state.prediction.penyakit[index]['akurasi']
                                        .toString()
                                        .substring(0, 10),
                                    style: blackTextStyle.copyWith(
                                        fontSize: 12.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                child: Container(
                                  height: 39.h,
                                  width: 310.w,
                                  margin:
                                      EdgeInsets.only(top: 30.h, bottom: 10.h),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Solusi',
                                        style: blackTextStyle,
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 380.h,
                                width: 310.w,
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: NotificationListener(
                                  onNotification: (notification) {
                                    if (notification
                                        is OverscrollIndicatorNotification) {
                                      notification.disallowIndicator();
                                    }
                                    return false;
                                  },
                                  child: ListView(
                                    children: [
                                      Text(
                                        solusi[penyakit[state.prediction
                                                .penyakit[index]['penyakit']]]
                                            .toString(),
                                        style: blackTextStyle.copyWith(
                                          fontSize: 12.sp,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50.0),
                        ],
                      );
                    },
                    separatorBuilder: (_, index) => const SizedBox(
                      width: 10.0,
                    ),
                    itemCount: state.prediction.tampilkan,
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
