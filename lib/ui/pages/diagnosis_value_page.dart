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
              top: 70.h,
              left: (MediaQuery.of(context).size.width / 18).w,
              child: BlocBuilder<NaiveBayesProcesCubit, NaiveBayesProcesState>(
                builder: (context, state) {
                  if (state is NaiveBayesProcesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is NaiveBayesProcesLoaded) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: kPrimaryColor),
                          ),
                          child: Text(
                            state.prediction.penyakit,
                            style: blackTextStyle.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          height: 25.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10.r),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${state.prediction.akurasi}%',
                              style: blackTextStyle.copyWith(),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 39.h,
                                width: 310.w,
                                margin: EdgeInsets.symmetric(vertical: 30.h),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(50.r),
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
                                borderRadius: BorderRadius.circular(20.r),
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
                                      solusi[state.prediction.penyakit]!,
                                      style: blackTextStyle.copyWith(
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 100.0,
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
