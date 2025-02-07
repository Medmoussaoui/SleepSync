import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sleepcyclesapp/components/custom_icon.dart';
import 'package:sleepcyclesapp/components/primary_button.dart';
import 'package:sleepcyclesapp/controllers/background_image.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/symbols.dart';
import 'package:sleepcyclesapp/utils/images.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/say_good_night_or_morning.dart';
import 'package:sleepcyclesapp/view/widgets/homeScreen/sleep_information.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  testLoadIcon() async {
    try {
      await rootBundle.load('assets/icons/sleep.png');
      print("✅ Asset exists!");
    } catch (e) {
      print("❌ Asset not found: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    testLoadIcon();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          BackgroundImageTimeState()
              .animate(delay: 200.ms)
              .fade(duration: 1000.ms, curve: Curves.easeInOut),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                SayGoodMorningOrNightWithTime(),
                SizedBox(height: Get.height * 0.1),
                SleepInformation(),
                SizedBox(height: 20),
                Wrap(
                  spacing: 15, // Spacing between items horizontally
                  runSpacing: 15, // Spacing between rows vertically
                  children: List.generate(
                    4,
                    (index) => SizedBox(
                      // Key change: Wrap each item in a SizedBox
                      width: (MediaQuery.of(context).size.width - 40 - 15) /
                          2, // Calculate width (40 is the horisantal padding and 15 is Wrap.spacing)
                      child: SleepMitrexItem(
                        value: '10 hrs, 30 Min',
                        metrix: "Sleep time",
                        icon: CustomIcon(icon: AppIcons.moon),
                      ),
                    ),
                  ),
                ),
                // Wrap(
                //   spacing: 10,
                //   runSpacing: 10,
                //   children: List.generate(
                //     4,
                //     (index) => SleepMitrexItem(
                //       value: '10 hrs, 30 Min', // Or use your dynamic data here
                //       metrix: "Sleep time", // Or use your dynamic data here
                //       icon: CustomIcon(
                //         icon: AppIcons.moon, // Or use your dynamic data here
                //       ),
                //     ),
                //   ),
                // ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: PrimaryButton(
                    text: "Begin Sleep Cycles",
                    onPressed: () {},
                  ),
                ),
                // Expanded(
                //   child: GridView.builder(
                //     // Use GridView.builder for dynamic content
                //     shrinkWrap:
                //         true, // Important: This tells GridView to take only the space it needs
                //     physics:
                //         NeverScrollableScrollPhysics(), // Prevent GridView from scrolling (if it's inside a scrollable view)
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2, // Number of columns
                //       childAspectRatio:
                //           1.5, // Adjust this ratio to control item shape (width/height)
                //     ),
                //     itemCount: 3, // Or your actual item count
                //     itemBuilder: (context, index) {
                //       return SleepMitrexItem(
                //         value:
                //             '10 hrs, 30 Min', // Or use your dynamic data here
                //         metrix: "Sleep time", // Or use your dynamic data here
                //         icon: CustomIcon(
                //           icon: AppIcons.moon, // Or use your dynamic data here
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // Expanded(
                //   child: GridView.builder(
                //     // shrinkWrap: true,
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       crossAxisSpacing: 15,
                //       mainAxisSpacing: 15,
                //     ),
                //     itemCount: 4,
                //     itemBuilder: (_, index) {
                //       return ;
                //     },
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SleepMitrexItem extends StatelessWidget {
  final String value;
  final String metrix;
  final Widget icon;

  const SleepMitrexItem({
    super.key,
    required this.value,
    required this.metrix,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(height: 10),
          Text(
            "7 hrs, 30 Min",
            style: AppTextStyles.headline4medium,
          ),
          SizedBox(height: 7),
          Text(
            "Sleep duration",
            style: AppTextStyles.subtitle4Regular,
          ),
        ],
      ),
    );
  }
}

// class CustomGridView extends StatelessWidget {
//   const CustomGridView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: LayoutBuilder(
//         // 1. Use LayoutBuilder to get grid width
//         builder: (BuildContext context, BoxConstraints constraints) {
//           return GridView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               // 2. Calculate max item height dynamically
//               mainAxisExtent:
//                   _calculateMaxItemHeight(context, constraints.maxWidth / 2),
//               // or use this if you want to use it for all items
//               // mainAxisExtent: 150, // example fixed height
//             ),
//             itemCount: yourItemCount,
//             itemBuilder: (context, index) {
//               return SleepMitrexItem(
//                   // ... your data
//                   );
//             },
//           );
//         },
//       ),
//     );
//   }

//   double _calculateMaxItemHeight(BuildContext context, double itemWidth) {
//     double maxHeight = 0;
//     List<GlobalKey> keys = []; // Store keys for all temporary items

//     // 1. Create temporary items and store keys
//     for (var itemData in yourItemList) {
//       GlobalKey key = GlobalKey();
//       keys.add(key);

//       tempItems.add(SizedBox(
//         key: key,
//         width: itemWidth, // Important: Set the width
//         child: SleepMitrexItem(
//           value: itemData.value,
//           metrix: itemData.metrix,
//           icon: CustomIcon(icon: itemData.icon),
//         ),
//       ));
//     }

//     // 2. Add a post-frame callback to measure heights
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       for (GlobalKey key in keys) {
//         RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
//         if (box != null) {
//           double height = box.size.height;
//           maxHeight = height > maxHeight ? height : maxHeight;
//         }
//       }
//       // 3. Update the state to rebuild GridView with the correct height
//       if (mounted) {
//         // Check if the widget is still mounted
//         setState(() {}); // Trigger a rebuild
//       }
//     });

//     return maxHeight; // Initial value; will be updated later
//   }

//   List<Widget> tempItems = []; // list of temp widget for measure height
// }
