import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:taskland/consts/illustrations.dart';
import 'package:taskland/screens/home/home_screen.dart';
import 'package:taskland/services/storage.dart';
import 'package:taskland/widgets/page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Expanded(
              flex: 3,
              child: _getCarousel(),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PageIndicator(totalPages: 2, currentIndex: currentIndex),
                FilledButton(
                  onPressed: () => _nextPageButtonTapped(context),
                  child: Text(currentIndex == 0 ? "Sonraki" : "Başla"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCarousel() {
    return LayoutBuilder(builder: (context, constraints) {
      return CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          viewportFraction: 1,
          height: constraints.maxHeight,
          scrollPhysics: const NeverScrollableScrollPhysics(),
        ),
        carouselController: carouselController,
        items: [0, 1].map((i) => _getWelcomePage(i)).toList(),
      );
    });
  }

  Widget _getWelcomePage(int index) {
    assert(index < 2);

    // TODO: Refactor this code when multi-language support arrives

    const titleText1 = "Görev listesi oluşturun";
    const titleText2 = "İyi alışkanlıklar edinin";

    const descText1 =
        "Görevlerinizi organize edin, hatırlatıcılar ayarlayın ve son tarihleri belirleyin.";
    const descText2 =
        "Başarmak istediğiniz hedeflerinizi kaydedin ve bunlara eğlenceli şekilde ulaşın.";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: index == 0 ? svgTask : svgHabit,
        ),
        const SizedBox(height: 32),
        Text(
          index == 0 ? titleText1 : titleText2,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          index == 0 ? descText1 : descText2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _nextPageButtonTapped(BuildContext context) {
    if (currentIndex == 0) {
      carouselController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCirc,
      );

      setState(() {
        currentIndex++;
      });

      return;
    }

    StorageService.settingsBox.put("isWelcomeScreenPassed", true);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }
}
