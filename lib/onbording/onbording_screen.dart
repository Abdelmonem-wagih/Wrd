import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wrd/core/utils/app_colors.dart';
import '../core/services/screen_size_helper.dart';
import 'onbording_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool lastPage = false;
  @override
  Widget build(BuildContext context) {
    ScreenSizeHelper.init(context);

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            reverse: true,
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                lastPage = (index == 2);
              });
            },
            children: [
              CustomShapeContainer(
                pageController: _controller,
                image: 'assets/onbording/Onbording-1.svg',
                title: 'أول تطبيق إسلامي يدعم بوت بالذكاء الإصطناعي لمساعدتك',
                bodyText: 'يمكنك من خلال ورد بوت أن تسأله عن أي شئ داخل التطبيق'
                    ' او في الدين الإسلامي ويجاوبك عليه إجابة تفصيلية.',
                backgroundColor: AppColors.white,
                clipperColor: AppColors.lightYellow,
                logoColor: AppColors.primary,
                space: 100,
                lastPage: lastPage,
              ),
              CustomShapeContainer(
                pageController: _controller,
                image: 'assets/onbording/Onbording-2.svg',
                title: 'أول تطبيق عربي يوجد به كل ما يخصك بخصوص الدين الإسلامي',
                bodyText:
                    'يمكنك من خلال التطبيق معرفة مواقيت الصلاة وإستخدام المسبحة والقبلة وقراءة '
                    ' وإستماع المصحف بجميع المشايخ والتذكير بالأذكار ومعرفة التقويم الهجري.',
                backgroundColor: AppColors.lightYellow,
                clipperColor: const Color(0xffedcb94),
                logoColor: AppColors.darkTone,
                space: 50,
                lastPage: lastPage,
              ),
              CustomShapeContainer(
                pageController: _controller,
                image: 'assets/onbording/Onbording-3.svg',
                title: 'التذكير الدائم بوردك وأذكار المسلم',
                bodyText:
                    'من خلال التطبيق يمكنك التحكم بالتذكير ومواقيت الصلاة و غلقها أو فتحها.',
                backgroundColor: const Color(0xffedcb94),
                clipperColor: AppColors.white,
                logoColor: AppColors.darkTone,
                space: 25,
                lastPage: lastPage,
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0.4, 0.5),
            child: SmoothPageIndicator(
              effect: const SlideEffect(
                  spacing: 5.0,
                  radius: 3.0,
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  paintStyle: PaintingStyle.stroke,
                  strokeWidth: 1,
                  dotColor: AppColors.darkTone,
                  activeDotColor: AppColors.darkTone),
              controller: _controller,
              count: 3,
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
  }
}
