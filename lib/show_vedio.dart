import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideoScreen extends StatefulWidget {
  const ShowVideoScreen({super.key});

  @override
  _ShowVideoScreenState createState() => _ShowVideoScreenState();
}

class _ShowVideoScreenState extends State<ShowVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // تحميل الفيديو من مجلد "vedios"
    _controller = VideoPlayerController.asset('vedios/HALA.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // استخدام خلفية متدرجة مشابهة للصفحات الأخرى
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
                    // زر العودة للصفحة السابقة
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
                      "عرض الفيديو",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    // مساحة فارغة لتوازن التصميم
                    const SizedBox(width: 48), // نفس حجم زر العودة تقريبًا
                  ],
                ),
              ),

              // عنوان الفيديو
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'فيديو توعوي عن الاستدامة البيئية',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // محتوى الفيديو
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: _controller.value.isInitialized
                        ? _buildVideoPlayer()
                        : _buildLoadingIndicator(),
                  ),
                ),
              ),

              // زر العودة للصفحة الرئيسية في أسفل الصفحة
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
                        "العودة",
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
    );
  }

  // بناء عنصر مشغل الفيديو
  Widget _buildVideoPlayer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // إطار الفيديو
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // أزرار التحكم
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // زر الرجوع 10 ثواني
            _buildControlButton(
              Icons.replay_10,
              () {
                final currentPosition = _controller.value.position;
                final newPosition =
                    currentPosition - const Duration(seconds: 10);
                _controller.seekTo(newPosition);
              },
            ),

            const SizedBox(width: 20),

            // زر التشغيل/الإيقاف
            _buildControlButton(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              large: true,
            ),

            const SizedBox(width: 20),

            // زر التقدم 10 ثواني
            _buildControlButton(
              Icons.forward_10,
              () {
                final currentPosition = _controller.value.position;
                final newPosition =
                    currentPosition + const Duration(seconds: 10);
                _controller.seekTo(newPosition);
              },
            ),
          ],
        ),

        const SizedBox(height: 20),

        // شريط التقدم
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // شريط التقدم
              VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                colors: VideoProgressColors(
                  playedColor: const Color(0xFF2E7D32),
                  bufferedColor: const Color(0xFF2E7D32).withOpacity(0.3),
                  backgroundColor: Colors.grey.withOpacity(0.5),
                ),
              ),

              const SizedBox(height: 4),

              // عرض الوقت الحالي والوقت الكلي
              ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, VideoPlayerValue value, child) {
                  final currentPosition = _formatDuration(value.position);
                  final totalDuration = _formatDuration(value.duration);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentPosition,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        totalDuration,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // بناء زر التحكم
  Widget _buildControlButton(IconData icon, VoidCallback onPressed,
      {bool large = false}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D32).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
          size: large ? 36 : 24,
        ),
        padding: EdgeInsets.all(large ? 12 : 8),
        constraints: BoxConstraints(
          minWidth: large ? 60 : 40,
          minHeight: large ? 60 : 40,
        ),
      ),
    );
  }

  // بناء مؤشر التحميل
  Widget _buildLoadingIndicator() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
          ),
          const SizedBox(height: 16),
          const Text(
            "جاري تحميل الفيديو...",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // تنسيق المدة الزمنية
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
