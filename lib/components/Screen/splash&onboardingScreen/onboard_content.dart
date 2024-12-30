import 'package:app/components/Screen/MainBottomNavScreen.dart';
import 'package:app/components/Screen/authscreen/forgetpass_screen.dart';
import 'package:app/components/Screen/authscreen/sign_Up_form.dart';
import 'package:app/components/Screen/authscreen/sing_in_form.dart';
import 'package:app/components/Screen/splash&onboardingScreen/landed_content.dart';
import 'package:flutter/material.dart';

class OnboardContent extends StatefulWidget {
  const OnboardContent({super.key});

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}

class _OnboardContentState extends State<OnboardContent> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
  }

  void _navigateToMainBottomNavScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainBottomNavScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _pageController.hasClients ? (_pageController.page ?? 0) : 0;
    final int currentPage = progress.round();

    return SizedBox(
      height: 340 + progress * 160,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    const LandingContent(),
                    SigninForm(
                      pageController: _pageController,
                      onCreateAccount: _navigateToMainBottomNavScreen,
                    ),
                    const SignupForm(),
                  ],
                ),
              ),
            ],
          ),
          // Show the "Get Started" button only on the first page
          if (currentPage == 0)
            Positioned(
              height: 56,
              bottom: 48 + progress * 100,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.4, 0.8],
                      colors: [
                        Color.fromARGB(255, 22, 108, 207),
                        Color.fromARGB(255, 22, 108, 207),
                      ],
                    ),
                  ),
                  child: const DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Get Started"),
                        Icon(
                          Icons.chevron_right,
                          size: 24,
                          color: Colors.white,
                        ),
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
