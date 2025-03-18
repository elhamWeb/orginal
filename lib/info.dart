import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // خلفية متدرجة للصفحة مثل الصفحة الرئيسية
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
          child: Column(
            children: [
              // شريط التنقل العلوي مع زر العودة
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // زر العودة للصفحة الرئيسية
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF2E7D32),
                        size: 24,
                      ),
                    ),
                    // عنوان الصفحة
                    const Text(
                      "معلومات الاستدامة",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    // زر إضافي للتوازن (يمكن استبداله بأي وظيفة أخرى)
                    IconButton(
                      onPressed: () {
                        _showInstructionsDialog(context);
                      },
                      icon: const Icon(
                        Icons.help_outline,
                        color: Color(0xFF2E7D32),
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),

              // محتوى الصفحة الرئيسي
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // عنوان كبير للمحتوى
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "أهمية الاستدامة البيئية",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20), // مسافة بين العنوان والمحتوى

                    // معلومات عن الاستدامة البيئية
                    _buildInfoCard(
                      "1. الاستدامة البيئية",
                      "تعني استخدام الموارد الطبيعية بطريقة تلبي احتياجات الحاضر دون المساس بقدرة الأجيال القادمة على تلبية احتياجاتهم. تشمل الاستدامة البيئية الحفاظ على التنوع البيولوجي، وتقليل التلوث، وإدارة الموارد الطبيعية بشكل مستدام.",
                    ),

                    _buildInfoCard(
                      "2. أهمية التنوع البيولوجي",
                      "هو تنوع الحياة على الأرض، ويعتبر عنصراً أساسياً للاستدامة البيئية. يساعد التنوع البيولوجي في تحسين استقرار الأنظمة البيئية، ويعزز القدرة على التكيف مع التغيرات المناخية ويضمن استمرارية الموارد الطبيعية.",
                    ),

                    _buildInfoCard(
                      "3. الطاقة المتجددة",
                      "تعتبر الطاقة المتجددة، مثل الطاقة الشمسية والرياح والمياه، جزءاً مهماً من الاستدامة البيئية. تساعد هذه المصادر في تقليل الاعتماد على الوقود الأحفوري، مما يقلل من انبعاثات الكربون ويعزز الأمن الطاقي.",
                    ),

                    _buildInfoCard(
                      "4. إدارة النفايات",
                      "إدارة النفايات بشكل فعال هي جزء أساسي من الاستدامة البيئية. يشمل ذلك تقليل إنتاج النفايات، وإعادة التدوير، والتخلص السليم من النفايات. يساعد ذلك في تقليل التلوث والحفاظ على الموارد الطبيعية.",
                    ),

                    _buildInfoCard(
                      "5. الزراعة المستدامة",
                      "الزراعة المستدامة تهدف إلى إنتاج الغذاء بطريقة تحافظ على البيئة. تشمل تقنيات مثل الزراعة العضوية، والزراعة المتنوعة، واستخدام الموارد المائية بشكل فعال، مما يساعد في الحفاظ على التربة والمياه.",
                    ),

                    _buildInfoCard(
                      "6. التغير المناخي",
                      "التغير المناخي هو أحد أكبر التحديات التي تواجه الاستدامة البيئية. يتسبب في تغيرات في أنماط الطقس، وارتفاع مستويات البحار، وتدهور الأنظمة البيئية. يتطلب التصدي لهذا التحدي جهوداً عالمية للحد من انبعاثات الغازات الدفيئة وتعزيز التكيف مع التغيرات المناخية.",
                    ),

                    // زر العودة إلى الصفحة الرئيسية في نهاية المحتوى
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
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
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
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
            ],
          ),
        ),
      ),
    );
  }

  // دالة لبناء بطاقة معلوماتية
  Widget _buildInfoCard(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ],
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
            "معلومات إضافية",
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
                  "• يمكنك الضغط على زر العودة للرجوع إلى الصفحة الرئيسية.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• اسحب لأسفل لقراءة المزيد من المعلومات حول الاستدامة البيئية.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• تعلّم المزيد عن الطرق العملية للمساهمة في الاستدامة البيئية في حياتك اليومية.",
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
