/* import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import 'secon_screen.dart';

class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentQuestionIndex = 0;
  List<Question> questions = [];
  List<int?> selectedAnswers = [];
  bool showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    questions = [
      Question(text: "ما هي الاستدامة البيئية؟", options: ["الحفاظ على الموراد الطبيعية للاجيال القادمه", "زيادة اسهتلاك الموارد", "التلوث البيئي", "التخلص من النفايات"], correctAnswerIndex: 0),
      Question(text: "ما هو احد اسباب الاحتباس الحراري؟", options: ["زراعة الاشجار", "انبعاثات الغازات الدفيئة", "الحفاظ على البيئه", "تقليل استخدام الطاقه "], correctAnswerIndex: 1),
      Question(text: "ما هي الطاقه المتجدده ؟", options: ["الطاقه المستمده من الوقود الاحفوري", "الطاقه التي لا تنضب مثل الرياح والشمس", "الطاقه التي تتسبب في الصناعه فقط ", "الطاقه التي تتسبب في التلوث"], correctAnswerIndex: 1),
      Question(text: "ما هو تأثير قطع الاشجار على البيئه؟", options: ["زيادة نسبة الاكسجين في الهواء", "تحسين جودة الهواء", "تقليل التنوع البيولوجي", "زيادة المساحات الخضراء"], correctAnswerIndex: 2),
      Question(text: "ما هو الهدف من اعادة التدوير ؟", options: ["زيادة النفايات", "الحفاظ على الموارد وتقليل التلوث ", "زيادة استهلاك المواد الجديده", "تحسين جودة الحياه فقط "], correctAnswerIndex: 1),
      Question(text: "ما هي احدى طرق تقليل النفايات؟", options: ["شراء المزيد من المنتجات", "التخلص من النفايات بشكل عشوائي", "استخدام اكياس قابله لاعادة التدوير", "دعم اعادة تدوير المواد"], correctAnswerIndex: 2),
      Question(text: "ما هو دور الحكومات في تعزيز الاستدامه البيئيه؟", options: ["تشجيع التلوث", "وضع قوانين لحماية البيئة", "زيادة استهلاك الطاقه", "تجاهل المشاكل البيئيه"], correctAnswerIndex: 1),
      Question(text: "ما هو مفهوم التنوع البيولوجي؟", options: ["تنوع الانواع الحيه في البيئة", "زيادة عدد السكان", "تقليل المساحات الخضراء", "تلوث المياه"], correctAnswerIndex: 0),
      Question(text: "ما هي احدى فوائد استخدام وسائل النقل العام؟", options: ["زيادة التلوث", "تقليل الازدحام المروري", "زيادة استهلاك الوقود", "تقليل الراحه"], correctAnswerIndex: 1),
      Question(text: "كيف يمكن للافراد المساهمه في الاستدامه البيئيه؟", options: ["تجاهل القضايا البيئيه", "تقليل استهلاك الماء والطاقه", "زيادة النفايات", "عدم المشاركه في الانشطه البيئيه"], correctAnswerIndex: 1),
    ];
    selectedAnswers = List.filled(questions.length, null);
  }

  Future<void> _playSuccessSound() async {
    await _audioPlayer.play(AssetSource('sounds/rrr.mp3'));
  }
  
  Future<void> _playErrorSound() async {
    await _audioPlayer.play(AssetSource('sounds/error.mp3')); // أضف ملف صوت للإجابة الخاطئة
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswerIndex) {
        score++;
      }
    }
    return score;
  }

  void _checkAnswers() {
    int score = calculateScore();
    if (score >= 5) {  // تشغيل الصوت إذا كان عدد الإجابات الصحيحة 5 أو أكثر
      _playSuccessSound();
    }
    _showResultDialog(score);
  }

  void _showResultDialog(int score) {
    String message;
    Color messageColor;
    
    if (score >= 8) {
      message = "ممتاز! لديك فهم عميق لموضوعات الاستدامة البيئية.";
      messageColor = Colors.green;
    } else if (score >= 5) {
      message = "جيد! تمتلك معرفة جيدة بالاستدامة البيئية.";
      messageColor = Colors.blue;
    } else {
      message = "حاول مرة أخرى! يمكنك تحسين معرفتك بموضوعات الاستدامة.";
      messageColor = Colors.orange;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          "نتيجة الاختبار",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "لقد حصلت على $score من ${questions.length}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: messageColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SecondScreen()),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFF2E7D32),
            ),
            child: Text(
              "العودة للقائمة", 
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        showCorrectAnswer = false; // إعادة تعيين حالة عرض الإجابة الصحيحة عند الانتقال للسؤال التالي
      });
    } else {
      _checkAnswers();
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        showCorrectAnswer = false; // إعادة تعيين حالة عرض الإجابة الصحيحة عند الانتقال للسؤال السابق
      });
    }
  }

  // دالة جديدة لعرض رسالة الإجابة الصحيحة
  void _showCorrectAnswerSnackBar() {
    final question = questions[currentQuestionIndex];
    final correctAnswer = question.options[question.correctAnswerIndex];
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "الإجابة الصحيحة هي: $correctAnswer",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF2E7D32),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

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
          child: Column(
            children: [
              // شريط التنقل العلوي
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // عنوان الصفحة
                    const Text(
                      "اختبار الاستدامة",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    // زر مساعدة
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

              // تقدم الاختبار
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.quiz_rounded,
                      color: Color(0xFF2E7D32),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "السؤال ${currentQuestionIndex + 1} من ${questions.length}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerRight,
                          widthFactor: (currentQuestionIndex + 1) / questions.length,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // محتوى السؤال
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // نص السؤال
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xFF2E7D32).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Text(
                            question.text, 
                            style: TextStyle(
                              fontSize: 20, 
                              fontWeight: FontWeight.bold, 
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // عرض الإجابة الصحيحة إذا كان showCorrectAnswer = true
                        if (showCorrectAnswer)
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xFF2E7D32), width: 2),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 24),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "الإجابة الصحيحة: ${question.options[question.correctAnswerIndex]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2E7D32),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // الخيارات
                        ...List.generate(question.options.length, (optionIndex) {
                          final isSelected = selectedAnswers[currentQuestionIndex] == optionIndex;
                          final isCorrect = optionIndex == question.correctAnswerIndex;
                          // تحديد لون الخيار
                          Color optionColor = Colors.white;
                          Color textColor = Colors.black87;
                          Color borderColor = Colors.grey.withOpacity(0.3);
                          
                          if (isSelected) {
                            if (isCorrect) {
                              optionColor = Colors.green.shade100;
                              textColor = Color(0xFF2E7D32);
                              borderColor = Color(0xFF2E7D32);
                            } else if (showCorrectAnswer) {
                              optionColor = Colors.red.shade100;
                              textColor = Colors.red.shade900;
                              borderColor = Colors.red;
                            } else {
                              optionColor = Color(0xFF2E7D32).withOpacity(0.2);
                              textColor = Color(0xFF2E7D32);
                              borderColor = Color(0xFF2E7D32);
                            }
                          } else if (showCorrectAnswer && isCorrect) {
                            optionColor = Colors.green.shade100;
                            textColor = Color(0xFF2E7D32);
                            borderColor = Color(0xFF2E7D32);
                          }
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: optionColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: borderColor,
                                width: isSelected || (showCorrectAnswer && isCorrect) ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                if (selectedAnswers[currentQuestionIndex] == null) {
                                  setState(() {
                                    selectedAnswers[currentQuestionIndex] = optionIndex;
                                    // تحقق إذا كانت الإجابة خاطئة
                                    if (optionIndex != question.correctAnswerIndex) {
                                      showCorrectAnswer = true;
                                      Vibration.vibrate(); // اهتزاز الجهاز للإجابة الخاطئة
                                      _playErrorSound(); // تشغيل صوت الخطأ
                                    }
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected ? 
                                              (isCorrect ? Color(0xFF2E7D32) : Colors.red) : 
                                              (showCorrectAnswer && isCorrect ? Color(0xFF2E7D32) : Colors.grey),
                                          width: 2,
                                        ),
                                        color: isSelected ? 
                                            (isCorrect ? Color(0xFF2E7D32) : Colors.red) : 
                                            (showCorrectAnswer && isCorrect ? Color(0xFF2E7D32) : Colors.transparent),
                                      ),
                                      child: isSelected 
                                        ? Icon(
                                            isCorrect ? Icons.check : Icons.close, 
                                            size: 16, 
                                            color: Colors.white
                                          ) 
                                        : (showCorrectAnswer && isCorrect ? Icon(Icons.check, size: 16, color: Colors.white) : null),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                      child: Text(
                                        question.options[optionIndex], 
                                        style: TextStyle(
                                          fontSize: 18, 
                                          color: textColor,
                                          fontWeight: isSelected || (showCorrectAnswer && isCorrect) ? FontWeight.bold : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),

              // أزرار التنقل
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // زر العودة
                    if (currentQuestionIndex > 0) 
                      ElevatedButton.icon(
                        onPressed: _previousQuestion,
                        icon: Icon(Icons.arrow_back_ios, size: 16),
                        label: Text("السابق"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF2E7D32),
                          elevation: 2,
                          shadowColor: Color(0xFF2E7D32).withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xFF2E7D32).withOpacity(0.5)),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        ),
                      )
                    else
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.home, size: 16),
                        label: Text("الرئيسية"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF2E7D32),
                          elevation: 2,
                          shadowColor: Color(0xFF2E7D32).withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xFF2E7D32).withOpacity(0.5)),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        ),
                      ),
                    
                    // زر التالي أو الإنهاء
                    ElevatedButton.icon(
                      onPressed: selectedAnswers[currentQuestionIndex] != null ? _nextQuestion : null,
                      label: Text(currentQuestionIndex == questions.length - 1 ? "إنهاء الاختبار" : "التالي"),
                      icon: Icon(
                        currentQuestionIndex == questions.length - 1 
                            ? Icons.check_circle 
                            : Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                        disabledForegroundColor: Colors.grey,
                        elevation: 2,
                        shadowColor: Color(0xFF2E7D32).withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
  
  // دالة لعرض مربع حوار التعليمات
  void _showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "تعليمات الاختبار",
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
                  "• اختر إجابة واحدة فقط لكل سؤال.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• يمكنك الانتقال بين الأسئلة باستخدام زري التالي والسابق.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• يجب اختيار إجابة للسؤال الحالي قبل الانتقال للسؤال التالي.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• ستظهر الإجابة الصحيحة فوراً إذا اخترت إجابة خاطئة.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• ستظهر النتيجة النهائية بعد الإجابة على جميع الأسئلة.",
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
 */

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import 'secon_screen.dart';

class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentQuestionIndex = 0;
  List<Question> questions = [];
  List<int?> selectedAnswers = [];
  bool showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    questions = [
      Question(
          text: "ما هي الاستدامة البيئية؟",
          options: [
            "الحفاظ على الموراد الطبيعية للاجيال القادمه",
            "زيادة اسهتلاك الموارد",
            "التلوث البيئي",
            "التخلص من النفايات"
          ],
          correctAnswerIndex: 0),
      Question(
          text: "ما هو احد اسباب الاحتباس الحراري؟",
          options: [
            "زراعة الاشجار",
            "انبعاثات الغازات الدفيئة",
            "الحفاظ على البيئه",
            "تقليل استخدام الطاقه "
          ],
          correctAnswerIndex: 1),
      Question(
          text: "ما هي الطاقه المتجدده ؟",
          options: [
            "الطاقه المستمده من الوقود الاحفوري",
            "الطاقه التي لا تنضب مثل الرياح والشمس",
            "الطاقه التي تتسبب في الصناعه فقط ",
            "الطاقه التي تتسبب في التلوث"
          ],
          correctAnswerIndex: 1),
      Question(
          text: "ما هو تأثير قطع الاشجار على البيئه؟",
          options: [
            "زيادة نسبة الاكسجين في الهواء",
            "تحسين جودة الهواء",
            "تقليل التنوع البيولوجي",
            "زيادة المساحات الخضراء"
          ],
          correctAnswerIndex: 2),
      Question(
          text: "ما هو الهدف من اعادة التدوير ؟",
          options: [
            "زيادة النفايات",
            "الحفاظ على الموارد وتقليل التلوث ",
            "زيادة استهلاك المواد الجديده",
            "تحسين جودة الحياه فقط "
          ],
          correctAnswerIndex: 1),
      Question(
          text: "ما هي احدى طرق تقليل النفايات؟",
          options: [
            "شراء المزيد من المنتجات",
            "التخلص من النفايات بشكل عشوائي",
            "استخدام اكياس قابله لاعادة التدوير",
            "دعم اعادة تدوير المواد"
          ],
          correctAnswerIndex: 2),
      Question(
          text: "ما هو دور الحكومات في تعزيز الاستدامه البيئيه؟",
          options: [
            "تشجيع التلوث",
            "وضع قوانين لحماية البيئة",
            "زيادة استهلاك الطاقه",
            "تجاهل المشاكل البيئيه"
          ],
          correctAnswerIndex: 1),
      Question(
          text: "ما هو مفهوم التنوع البيولوجي؟",
          options: [
            "تنوع الانواع الحيه في البيئة",
            "زيادة عدد السكان",
            "تقليل المساحات الخضراء",
            "تلوث المياه"
          ],
          correctAnswerIndex: 0),
      Question(
          text: "ما هي احدى فوائد استخدام وسائل النقل العام؟",
          options: [
            "زيادة التلوث",
            "تقليل الازدحام المروري",
            "زيادة استهلاك الوقود",
            "تقليل الراحه"
          ],
          correctAnswerIndex: 1),
      Question(
          text: "كيف يمكن للافراد المساهمه في الاستدامه البيئيه؟",
          options: [
            "تجاهل القضايا البيئيه",
            "تقليل استهلاك الماء والطاقه",
            "زيادة النفايات",
            "عدم المشاركه في الانشطه البيئيه"
          ],
          correctAnswerIndex: 1),
    ];
    selectedAnswers = List.filled(questions.length, null);
  }

  Future<void> _playSuccessSound() async {
    await _audioPlayer.play(AssetSource('sounds/rrr.mp3'));
  }

  Future<void> _playErrorSound() async {
    await _audioPlayer
        .play(AssetSource('sounds/error.mp3')); // أضف ملف صوت للإجابة الخاطئة
  }

  // دالة جديدة للتحقق من دعم الاهتزاز
  Future<void> _vibrate() async {
    // تحقق مما إذا كان الجهاز يدعم الاهتزاز
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      try {
        await Vibration.vibrate(duration: 200);
      } catch (e) {
        print('خطأ في الاهتزاز: $e');
        // تجاهل الخطأ لمنع تعطل التطبيق
      }
    }
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswerIndex) {
        score++;
      }
    }
    return score;
  }

  void _checkAnswers() {
    int score = calculateScore();
    if (score >= 5) {
      // تشغيل الصوت إذا كان عدد الإجابات الصحيحة 5 أو أكثر
      _playSuccessSound();
    }
    _showResultDialog(score);
  }

  void _showResultDialog(int score) {
    String message;
    Color messageColor;

    if (score >= 8) {
      message = "ممتاز! لديك فهم عميق لموضوعات الاستدامة البيئية.";
      messageColor = Colors.green;
    } else if (score >= 5) {
      message = "جيد! تمتلك معرفة جيدة بالاستدامة البيئية.";
      messageColor = Colors.blue;
    } else {
      message = "حاول مرة أخرى! يمكنك تحسين معرفتك بموضوعات الاستدامة.";
      messageColor = Colors.orange;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          "نتيجة الاختبار",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "لقد حصلت على $score من ${questions.length}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: messageColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SecondScreen()),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFF2E7D32),
            ),
            child: Text(
              "العودة للقائمة",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        showCorrectAnswer =
            false; // إعادة تعيين حالة عرض الإجابة الصحيحة عند الانتقال للسؤال التالي
      });
    } else {
      _checkAnswers();
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        showCorrectAnswer =
            false; // إعادة تعيين حالة عرض الإجابة الصحيحة عند الانتقال للسؤال السابق
      });
    }
  }

  // دالة جديدة لعرض رسالة الإجابة الصحيحة
  void _showCorrectAnswerSnackBar() {
    final question = questions[currentQuestionIndex];
    final correctAnswer = question.options[question.correctAnswerIndex];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "الإجابة الصحيحة هي: $correctAnswer",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF2E7D32),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

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
          child: Column(
            children: [
              // شريط التنقل العلوي
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // عنوان الصفحة
                    const Text(
                      "اختبار الاستدامة",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    // زر مساعدة
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

              // تقدم الاختبار
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.quiz_rounded,
                      color: Color(0xFF2E7D32),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "السؤال ${currentQuestionIndex + 1} من ${questions.length}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerRight,
                          widthFactor:
                              (currentQuestionIndex + 1) / questions.length,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // نص السؤال
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xFF2E7D32).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Text(
                            question.text,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // عرض الإجابة الصحيحة إذا كان showCorrectAnswer = true
                        if (showCorrectAnswer)
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color(0xFF2E7D32), width: 2),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle,
                                    color: Color(0xFF2E7D32), size: 24),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "الإجابة الصحيحة: ${question.options[question.correctAnswerIndex]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2E7D32),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // الخيارات
                        ...List.generate(question.options.length,
                            (optionIndex) {
                          final isSelected =
                              selectedAnswers[currentQuestionIndex] ==
                                  optionIndex;
                          final isCorrect =
                              optionIndex == question.correctAnswerIndex;
                          // تحديد لون الخيار
                          Color optionColor = Colors.white;
                          Color textColor = Colors.black87;
                          Color borderColor = Colors.grey.withOpacity(0.3);

                          if (isSelected) {
                            if (isCorrect) {
                              optionColor = Colors.green.shade100;
                              textColor = Color(0xFF2E7D32);
                              borderColor = Color(0xFF2E7D32);
                            } else if (showCorrectAnswer) {
                              optionColor = Colors.red.shade100;
                              textColor = Colors.red.shade900;
                              borderColor = Colors.red;
                            } else {
                              optionColor = Color(0xFF2E7D32).withOpacity(0.2);
                              textColor = Color(0xFF2E7D32);
                              borderColor = Color(0xFF2E7D32);
                            }
                          } else if (showCorrectAnswer && isCorrect) {
                            optionColor = Colors.green.shade100;
                            textColor = Color(0xFF2E7D32);
                            borderColor = Color(0xFF2E7D32);
                          }

                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: optionColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: borderColor,
                                width: isSelected ||
                                        (showCorrectAnswer && isCorrect)
                                    ? 2
                                    : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                if (selectedAnswers[currentQuestionIndex] ==
                                    null) {
                                  setState(() {
                                    selectedAnswers[currentQuestionIndex] =
                                        optionIndex;
                                    // تحقق إذا كانت الإجابة خاطئة
                                    if (optionIndex !=
                                        question.correctAnswerIndex) {
                                      showCorrectAnswer = true;
                                      Vibration
                                          .vibrate(); // اهتزاز الجهاز للإجابة الخاطئة
                                      _playErrorSound(); // تشغيل صوت الخطأ
                                    }
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected
                                              ? (isCorrect
                                                  ? Color(0xFF2E7D32)
                                                  : Colors.red)
                                              : (showCorrectAnswer && isCorrect
                                                  ? Color(0xFF2E7D32)
                                                  : Colors.grey),
                                          width: 2,
                                        ),
                                        color: isSelected
                                            ? (isCorrect
                                                ? Color(0xFF2E7D32)
                                                : Colors.red)
                                            : (showCorrectAnswer && isCorrect
                                                ? Color(0xFF2E7D32)
                                                : Colors.transparent),
                                      ),
                                      child: isSelected
                                          ? Icon(
                                              isCorrect
                                                  ? Icons.check
                                                  : Icons.close,
                                              size: 16,
                                              color: Colors.white)
                                          : (showCorrectAnswer && isCorrect
                                              ? Icon(Icons.check,
                                                  size: 16, color: Colors.white)
                                              : null),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                      child: Text(
                                        question.options[optionIndex],
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: textColor,
                                          fontWeight: isSelected ||
                                                  (showCorrectAnswer &&
                                                      isCorrect)
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),

              // أزرار التنقل
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // زر العودة
                    if (currentQuestionIndex > 0)
                      ElevatedButton.icon(
                        onPressed: _previousQuestion,
                        icon: Icon(Icons.arrow_back_ios, size: 16),
                        label: Text("السابق"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF2E7D32),
                          elevation: 2,
                          shadowColor: Color(0xFF2E7D32).withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Color(0xFF2E7D32).withOpacity(0.5)),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                        ),
                      )
                    else
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.home, size: 16),
                        label: Text("الرئيسية"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF2E7D32),
                          elevation: 2,
                          shadowColor: Color(0xFF2E7D32).withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: Color(0xFF2E7D32).withOpacity(0.5)),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                        ),
                      ),

                    // زر التالي أو الإنهاء
                    ElevatedButton.icon(
                      onPressed: selectedAnswers[currentQuestionIndex] != null
                          ? _nextQuestion
                          : null,
                      label: Text(currentQuestionIndex == questions.length - 1
                          ? "إنهاء الاختبار"
                          : "التالي"),
                      icon: Icon(
                        currentQuestionIndex == questions.length - 1
                            ? Icons.check_circle
                            : Icons.arrow_forward_ios,
                        size: 16,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.withOpacity(0.3),
                        disabledForegroundColor: Colors.grey,
                        elevation: 2,
                        shadowColor: Color(0xFF2E7D32).withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

  // دالة لعرض مربع حوار التعليمات
  void _showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "تعليمات الاختبار",
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
                  "• اختر إجابة واحدة فقط لكل سؤال.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• يمكنك الانتقال بين الأسئلة باستخدام زري التالي والسابق.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• يجب اختيار إجابة للسؤال الحالي قبل الانتقال للسؤال التالي.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• ستظهر الإجابة الصحيحة فوراً إذا اخترت إجابة خاطئة.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  "• ستظهر النتيجة النهائية بعد الإجابة على جميع الأسئلة.",
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
