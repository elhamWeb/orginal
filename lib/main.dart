import 'package:flutter/material.dart';
import 'secon_screen.dart'; // استيراد الشاشة الثانية

// الدالة الرئيسية لتشغيل التطبيق
void main() {
  runApp(const MyApp());
}

// الكلاس الرئيسي للتطبيق
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق الاستدامة البيئية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2E7D32), // اللون الأخضر الداكن
        fontFamily: 'Cairo', // خط عربي مناسب
      ),
      home: const MyHomePage(),
    );
  }
}

// الصفحة الرئيسية للتطبيق
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // للتأكد من توافق التطبيق مع مختلف أحجام الشاشات
      final screenSize = MediaQuery.of(context).size;
      final isSmallScreen = screenSize.width < 360;
      final isMediumScreen = screenSize.width < 600 && screenSize.width >= 360;

      // تحديد حجم الشعار بناءً على حجم الشاشة
      final logoRadius = isSmallScreen
          ? constraints.maxWidth * 0.25
          : isMediumScreen
              ? constraints.maxWidth * 0.30
              : constraints.maxWidth * 0.20;

      // تحديد حجم النص بناءً على حجم الشاشة
      final titleFontSize = isSmallScreen
          ? 18.0
          : isMediumScreen
              ? 22.0
              : 26.0;
      final subtitleFontSize = isSmallScreen
          ? 14.0
          : isMediumScreen
              ? 16.0
              : 18.0;
      final contactInfoFontSize = isSmallScreen
          ? 14.0
          : isMediumScreen
              ? 16.0
              : 18.0;

      return Scaffold(
        // خلفية متدرجة للصفحة
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFE8F5E9), // أخضر فاتح
                Color(0xFFB3E5FC), // أزرق فاتح
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenSize.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenSize.height * 0.02,
                  ),
                  child: Column(
                    children: [
                      // شريط التنقل العلوي
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenSize.height * 0.02,
                          bottom: screenSize.height * 0.01,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // شعار التطبيق
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "الاستدامة البيئية",
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF2E7D32),
                                  ),
                                ),
                              ),
                            ),
                            // زر التعليمات
                            IconButton(
                              onPressed: () {
                                _showInstructionsDialog(context);
                              },
                              icon: const Icon(
                                Icons.help_outline,
                                color: Color(0xFF2E7D32),
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenSize.height * 0.02),

                      // صورة الشعار الرئيسية
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: logoRadius,
                          backgroundColor: Colors.white,
                          backgroundImage: const AssetImage(
                              "images/ONCE-removebg-preview.png"),
                        ),
                      ),

                      SizedBox(height: screenSize.height * 0.03),

                      // العنوان الرئيسي
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: screenSize.height * 0.015,
                            horizontal: screenSize.width * 0.05),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'لنستدم بيئتنا معاً',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenSize.height * 0.015),

                      // وصف قصير للتطبيق
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.04,
                            vertical: screenSize.height * 0.015),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'تطبيق شامل يساعدك على تبني نمط حياة مستدام والحفاظ على البيئة للأجيال القادمة',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: subtitleFontSize,
                            color: const Color(0xFF2E7D32),
                          ),
                        ),
                      ),

                      SizedBox(height: screenSize.height * 0.025),

                      // معلومات التواصل
                      _buildContactInfo(
                        context,
                        Icons.email_outlined,
                        'eco.Sustainability@gmail.com',
                        isSmallScreen,
                        contactInfoFontSize,
                      ),

                      SizedBox(height: screenSize.height * 0.01),

                      _buildContactInfo(
                        context,
                        Icons.phone_outlined,
                        '0795683629',
                        isSmallScreen,
                        contactInfoFontSize,
                      ),

                      SizedBox(height: screenSize.height * 0.04),

                      // زر بدء الاستخدام
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: screenSize.height * 0.03),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SecondScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.08,
                                vertical: screenSize.height * 0.02),
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                            elevation: 8,
                            shadowColor:
                                const Color(0xFF2E7D32).withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "ابدأ الآن",
                                style: TextStyle(
                                  fontSize: subtitleFontSize + 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: screenSize.width * 0.02),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: subtitleFontSize - 2,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // دالة لبناء معلومات التواصل
  Widget _buildContactInfo(BuildContext context, IconData icon, String text,
      bool isSmallScreen, double fontSize) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF2E7D32),
            size: 24,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // دالة لعرض مربع حوار التعليمات
  void _showInstructionsDialog(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;
    final dialogFontSize = isSmallScreen ? 14.0 : 16.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "تعليمات الاستخدام",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
              fontSize: dialogFontSize + 2,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• اضغط على زر 'ابدأ الآن' للانتقال إلى الصفحة الرئيسية للتطبيق.",
                  style: TextStyle(fontSize: dialogFontSize),
                ),
                SizedBox(height: screenSize.height * 0.01),
                Text(
                  "• استكشف المعلومات المتنوعة حول الاستدامة البيئية.",
                  style: TextStyle(fontSize: dialogFontSize),
                ),
                SizedBox(height: screenSize.height * 0.01),
                Text(
                  "• تعرف على النصائح العملية للحفاظ على البيئة في حياتك اليومية.",
                  style: TextStyle(fontSize: dialogFontSize),
                ),
                SizedBox(height: screenSize.height * 0.01),
                Text(
                  "• اكتشف المزيد من الموارد وطرق المساهمة في الاستدامة البيئية.",
                  style: TextStyle(fontSize: dialogFontSize),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2E7D32),
              ),
              child: Text(
                "حسناً",
                style: TextStyle(
                    fontSize: dialogFontSize + 2, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
