import 'package:sleepcyclesapp/models/onboarding_model.dart';
import 'package:sleepcyclesapp/utils/images.dart';

const List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    assetImage: AppImages.welcome,
    title: "Wake up refreshed",
    description: "sync with your natural sleep cyclesfor a better morning",
    imageSize: 180,
  ),
  OnBoardingModel(
    imageSize: 106,
    assetImage: AppImages.timer,
    title: "Why 90-Minute Cycles?",
    description:
        "Waking up at the end of a sleep cycle boosts energy, while mid-cycle wake ups cause grogginess",
  ),
  OnBoardingModel(
    imageSize: 126,
    assetImage: AppImages.why,
    title: "How It Works",
    description:
        "Choose your sleep cycles, let the app track your sleep, and wake up feeling great!",
  ),
  OnBoardingModel(
    imageSize: 126,
    assetImage: AppImages.lamba,
    title: "Smart Sleep Detection",
    description:
        "A gentle vibration checks if you're awake. No response? The app starts tracking your sleep",
  ),
];
