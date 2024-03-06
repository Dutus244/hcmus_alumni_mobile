  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';

  import '../../common/values/colors.dart';

  class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
  }

  class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Column(
        children: [
          // First container with background image
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFC6E0FD), // Start color
                  Color(0x00C6E0FD), // End color (fully transparent)
                ],
              ),
            ),
            margin: EdgeInsets.only(top: 100.h),
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child:
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: 100.w,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ALUMVERSE HCMUS",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Hệ thống kết nối sinh viên",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 180.w,
                          child: Image.asset(
                            "assets/images/landing/banner.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.w),
                        width: 60.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                            color: const Color(0xFF343F52),
                            borderRadius: BorderRadius.all(Radius.circular(15.w)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 10,
                                blurRadius: 20,
                                offset: Offset(0, 1),
                              )
                            ]),
                        child: Center(
                          child: Text(
                            "Xem chi tiết >",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 8.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                // First column with two text widgets
                Container(
                  width: 140.w,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      "GIỚI THIỆU",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Kết nối cộng đồng cựu sinh viên từ các khoa ngành khác nhau. Điều này tạo nên một nền tảng để chia sẻ kinh nghiệm, cơ hội nghề nghiệp và hỗ trợ lẫn nhau trong sự nghiệp.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                  ),
                ),
                Container(
                  child: Image.asset(
                    "assets/images/landing/introduction.png",
                    width: 200.0,
                  ),
                ),],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Column(
                children: [
                  const Text(
                    "TIN TỨC & SỰ KIỆN",
                    style: TextStyle(
                      color: Color(0xFF055ABC),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          _card(
                              context,
                              "Hội nghị Liên ban Cộng đồng Cựu sinh viên Khoa học lần 1 - Nhiệm kỳ 2022 - 2025",
                              "",
                              "assets/images/landing/event1.jpg"
                          ),
                          _card(
                              context,
                              "Thư mời tham gia diễn đàn Khoa học – Doanh nghiệp và Đổi mới Sáng tạo",
                              "",
                              "assets/images/landing/event2.jpg"
                          ),
                          _card(
                              context,
                              "Trường Đại học Khoa học tự nhiên mở diễn đàn đổi mới sáng tạo",
                              "",
                              "assets/images/landing/event3.jpg"
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.w),
                    width: 80.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFF055ABC),
                        borderRadius: BorderRadius.all(Radius.circular(15.w)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 10,
                            blurRadius: 20,
                            offset: Offset(0, 1),
                          )
                        ]),
                    child: Center(
                      child: Text(
                        "Xem thêm",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Column(
                  children: [
                    const Text(
                      "CỰU SINH VIÊN TIÊU BIỂU",
                      style: TextStyle(
                        color: Color(0xFF055ABC),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            _card(
                                context,
                                "Lê Yên Thanh",
                                "Khóa 2014 - Khoa Công nghệ thông tin",
                                "assets/images/landing/csv1.jpg"
                            ),
                            _card(
                                context,
                                "Nguyễn Thị Thanh Mai",
                                "Khóa 2006 - Khoa Hóa học",
                                "assets/images/landing/csv2.jpg"
                            ),
                            _card(
                                context,
                                "Trần Thị Như Hoa",
                                "Khóa 2013 - Khoa Hóa học",
                                "assets/images/landing/csv3.jpg"
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.w),
                      width: 80.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                          color: const Color(0xFF055ABC),
                          borderRadius: BorderRadius.all(Radius.circular(15.w)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 10,
                              blurRadius: 20,
                              offset: Offset(0, 1),
                            )
                          ]),
                      child: Center(
                        child: Text(
                          "Xem thêm",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            Container(
            margin: EdgeInsets.only(top: 20.h),
            child: Column(
                children: [
                  const Text(
                    "HỖ TRỢ VÀ TƯ VẤN",
                    style: TextStyle(
                      color: Color(0xFF055ABC),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                      color: const Color.fromRGBO(0, 93, 253, 0.08),
                      height: 240.w,
                      child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                            "assets/images/landing/advisory.png",
                            width: 200.w,
                            fit: BoxFit.cover,
                          ),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              width: 100.w,
                              child: const Text(
                                "Giải đáp thắc mắc và tư vấn cùng đội ngũ cựu sinh viên xịn xò",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          )
                        ],
                        ),
                  ),
                ]
            ),
          ),
        ],),
        ],
      ),
    );
  }
  Widget _card(BuildContext context, String title, String subTitle,String imagePath) {
    return Container(
      child: Column(
        children: [
          // First column in the container
          Container(
            margin: EdgeInsets.only(top: 0.h, left: 2.w, right: 2.w),
            width: 115.w,
            child: Column(
              children: [
                Image.asset(
                  imagePath,
                  width: 110.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),),
                Text(
                  subTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                  ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
  }
