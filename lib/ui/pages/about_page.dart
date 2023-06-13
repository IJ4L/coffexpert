import 'package:coffe_brain/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    kWhiteColor,
                    kPrimaryColor,
                  ],
                ),
              ),
            ),
          ),
          NotificationListener(
            onNotification: (notification) {
              if (notification is OverscrollIndicatorNotification) {
                notification.disallowIndicator();
              }
              return false;
            },
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                child: SafeArea(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Tentang',
                          style: blackTextStyle.copyWith(
                            fontSize: 22.sp,
                            color: kSecondColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 26.w, vertical: 14.h),
                        child: Text(
                          '''Aplikasi sistem pakar adalah sistem berbasis komputer yang menggunakan pengetahuan ,, fakta, dan tehnik penalaran dalam memecahkan masalah yang biasanya hanya dapat di pecahkan oleh seorang pakar dalam bidang tertentu. 
                      
Sistem pakar memberikan nilai tambah pada teknologi untuk membantu menangani era informasi yang semakin canggih.
                      
Aplikasi sistem pakar ini menghasilkan keluaran berupa hama dan jenis penyakit yang di derita oleh tanaman kopi berdasarkan gejala yang diinputkan oleh user. Sistem ini juga menampilkan besarnya kepercayaan gejala tersebut terhadap kemungkinan hama dan penyakit yang diderita  oleh tanaman kopi. Besarnya nilai kepercayaan tersebut merupakan hasil persitungan dengan menggunakan metode naive bayes.
                      
                      ''',
                          style: cocolateTextStyle,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Disclaimer',
                          style: blackTextStyle.copyWith(
                            fontSize: 22.sp,
                            color: kSecondColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 26.w, vertical: 14.h),
                        child: Text(
                          '''Semua informasi yang terdapat pada aplikasi ini dibuat dengan tujuan memberikan informasi, kami berusaha memberikan informasi yang akurat dan terbaru, tetapi tidak menjamin keakuratan dan validitas informasi yang disajikan .
          
Semua materi yang di publikasikan di sini berdasarkan pengetahuan dari pakar tanaman kopi yaitu Bapak Wasno Dianto dan tidak boleh di publikasikan, direproduksi, atau didistribusikan tanpa izin tertulis dari kami. 
          
Kami juga tidak bertanggung jawab atas segala bentuk kerugian atau kerusakan yang mungkin terjadi akibat dari penggunaan informasi yang diterbitkan pada aplikasi ini. 
          
Dengan menggunakan aplikasi ini , anda setuju untuk mengikuti syarat dan ketentuan yang berlaku. Jika anda tidak setuju dengan syarat dan ketentuan ini, harap meninggalkan aplikasi ini.
                      ''',
                          style: cocolateTextStyle,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child:
                              Text('v1.0.0', style: blackTextStyle.copyWith()),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
