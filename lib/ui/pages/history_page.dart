// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:coffe_brain/cubit/history/history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../shared/theme.dart';

class HistoryLoadedPage extends StatelessWidget {
  const HistoryLoadedPage({Key? key}) : super(key: key);

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
          'History',
          style: cocolateTextStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoaded) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  DateTime dateTime =
                      DateTime.parse(state.history[index].at.toString());
                  String formattedDateTime =
                      DateFormat('dd MMM yyyy, HH:mm:ss').format(dateTime);
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(4.r),
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: kPrimaryColor,
                        ),
                        child: ListTile(
                          title: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Text(
                              state.history[index].penyakit,
                              style: blackTextStyle,
                            ),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.history[index].gejala.toString(),
                                style:
                                    cocolateTextStyle.copyWith(fontSize: 12.sp),
                              ),
                              Text(
                                formattedDateTime,
                                style:
                                    cocolateTextStyle.copyWith(fontSize: 10.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, index) => SizedBox(height: 8.h),
                itemCount: state.history.length,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
