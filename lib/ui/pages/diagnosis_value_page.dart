import 'package:coffe_brain/cubit/naive_bayes/naive_bayes_proces_cubit.dart';
import 'package:coffe_brain/cubit/select_gejala_cubit.dart';
import 'package:coffe_brain/cubit/updown_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/theme.dart';

class Diagnosisvalue extends StatelessWidget {
  const Diagnosisvalue({super.key});

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
              top: 10.h,
              child: BlocBuilder<NaiveBayesProcesCubit, NaiveBayesProcesState>(
                builder: (context, state) {
                  if (state is NaiveBayesProcesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is NaiveBayesProcesLoaded) {
                    return Column(
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
                          state.prediction,
                          style: blackTextStyle.copyWith(
                            fontSize: 18.sp,
                            fontWeight: semiBold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        BlocBuilder<UpdownCubit, bool>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      context.read<UpdownCubit>().klik(),
                                  child: Container(
                                    height: 39.h,
                                    width: 310.w,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 25.h),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
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
                                        state == true
                                            ? const Icon(
                                                Icons.arrow_drop_up_outlined)
                                            : const Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                                state == true
                                    ? Container(
                                        width: 310.w,
                                        padding: EdgeInsets.all(22.r),
                                        decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        child: Text(
                                          'Lorem ipsum dolor sit amet consectetur. Metus donec interdum enim sem id montes. Risus malesuada feugiat amet mi dignissim. Viverra pellentesque ut arcu rhoncus eu. Ac morbi nunc arcu suspendisse lacinia. Vivamus vulputate hac vel velit at facilisis lectus at diam. Lorem habitant eu.',
                                          style: blackTextStyle,
                                        ),
                                      )
                                    : Container(),
                              ],
                            );
                          },
                        )
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
