import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indian_hoax_news/app/routes/app_pages.dart';
import 'package:indian_hoax_news/utils/app_colors.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}
class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    // 1. Setup Animation Controller (Durasi 2 detik)
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    // 2. Definisi Animasi Fade (Muncul Perlahan)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    // 3. Definisi Animasi Scale (Membesar dari 0.8 ke 1.0)
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    // 4. Mulai Animasi
    _animationController.forward();
    // 5. Pindah Halaman ke Home setelah 3 detik
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed(Routes.HOME);
    });
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 6. Background Gradient agar lebih estetik (Biru ke transparansi)
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 7. Icon Logo dengan lingkaran putih & bayangan
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle, 
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5)),
                      ],
                    ),
                    child: Icon(
                      Icons.newspaper_rounded, // Gunakan rounded icon
                      size: 64,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 24),
                  
                  // 8. Teks Judul Aplikasi
                  Text(
                    'News App',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  
                  // 9. Tagline Kecil di bawah judul
                  Text(
                    'Your Daily Dose of News',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
