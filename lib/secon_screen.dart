import 'package:flutter/material.dart';
import 'show_vedio.dart'; // استيراد شاشة الفيديو
import 'exam.dart'; // استيراد شاشة الامتحان
import 'info.dart'; // استيراد شاشة info.dart

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  // قائمة العناصر
  List<Map<String, dynamic>> items = [
    {
      'image': 'images/مسابقه.jpg',
      'text': 'المسابقة',
      'destination': ExamScreen(),
      'icon': Icons.quiz_outlined,
    },
    {
      'image': 'images/معلومات.jpg',
      'text': 'معلومات عامة',
      'destination': InfoScreen(),
      'icon': Icons.info_outline,
    },
    {
      'image': 'images/فيديوو.jpg',
      'text': 'الفيديو',
      'destination': ShowVideoScreen(),
      'icon': Icons.play_circle_outline,
    }
  ];

  @override
  Widget build(BuildContext context) {
    // للتأكد من توافق التطبيق مع مختلف أحجام الشاشات
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // شريط التنقل العلوي
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // شعار التطبيق
                      const Text(
                        "الاستدامة البيئية",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
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

                const SizedBox(height: 20),

                // عنوان الصفحة
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    'استكشف محتوى التطبيق',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // وصف قصير للصفحة
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'اختر من المحتوى التالي لتعزيز معرفتك حول الاستدامة البيئية',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // قائمة العناصر
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      return _buildItemCard(
                        context,
                        items[index]['image'],
                        items[index]['text'],
                        items[index]['destination'],
                        items[index]['icon'],
                        isSmallScreen,
                      );
                    },
                  ),
                ),

                // زر الرجوع للصفحة الرئيسية
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      elevation: 8,
                      shadowColor: const Color(0xFF2E7D32).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "العودة للصفحة الرئيسية",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }

  // دالة لبناء بطاقة العنصر
  Widget _buildItemCard(BuildContext context, String image, String text,
      Widget destination, IconData icon, bool isSmallScreen) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(
              children: [
                // صورة العنصر
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF2E7D32).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // نص العنصر
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ),
                // أيقونة
                Icon(
                  icon,
                  color: const Color(0xFF2E7D32),
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة لعرض مربع حوار التعليمات
  void _showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "محتويات الصفحة",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "• المسابقة: اختبر معلوماتك حول الاستدامة البيئية من خلال مجموعة من الأسئلة المتنوعة.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• معلومات عامة: تعرف على معلومات قيمة تساعدك في فهم أهمية الاستدامة البيئية.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• الفيديو: شاهد مقاطع فيديو توضيحية حول موضوعات الاستدامة البيئية المختلفة.",
                  style: TextStyle(fontSize: 16),
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
              child: const Text(
                "حسناً",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
