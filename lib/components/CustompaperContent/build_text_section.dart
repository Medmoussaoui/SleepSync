import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sleepcyclesapp/components/CustompaperContent/fade_visibility.dart';
import 'package:sleepcyclesapp/components/with_separate_size.dart';
import 'package:sleepcyclesapp/entitys/text_paragraph.dart';
import 'package:sleepcyclesapp/utils/colors.dart';
import 'package:sleepcyclesapp/utils/text_styles.dart';

class BuildTextSectionWidget extends StatefulWidget {
  final TextSection section;
  final Function onContentCompletelyVisible;
  final bool autoDraw;

  const BuildTextSectionWidget({
    super.key,
    required this.section,
    required this.onContentCompletelyVisible,
    required this.autoDraw,
  });

  @override
  State<BuildTextSectionWidget> createState() => BuildTextSectionWidgetState();
}

class BuildTextSectionWidgetState extends State<BuildTextSectionWidget> {
  bool isContentVisible = false;
  final List<GlobalKey<FadeWidgetVisibilityState>> _keys = [];

  Future<void> _drawNextParagraph(int nextKey) async {
    final key = _keys[nextKey];
    await key.currentState!.drawContent();
  }

  GlobalKey<FadeWidgetVisibilityState> _addKey() {
    final key = GlobalKey<FadeWidgetVisibilityState>();
    _keys.add(key);
    return key;
  }

  Future<void> drawParagraphs() async {
    if (isContentVisible) return;
    setState(() => isContentVisible = true);
    Future.delayed(200.ms).then((value) => _drawNextParagraph(0));
  }

  @override
  void initState() {
    if (widget.autoDraw) {
      isContentVisible = true;
      Future.delayed(200.ms).then((value) => _drawNextParagraph(0));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isContentVisible) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.section.title,
          textAlign: TextAlign.left,
          style: AppTextStyles.headline2medium.copyWith(fontSize: 20),
        ).animate().fade(),
        SizedBox(height: 20),

        /// Paragraphs
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: widget.section.paragraphs.length,
          itemBuilder: (_, index) {
            return FadeWidgetVisibility(
              interferenceDelay: 100,
              duration: 400,
              key: _addKey(),
              onContentCompletelyVisible: (state) {
                if (index == widget.section.paragraphs.length - 1) {
                  widget.onContentCompletelyVisible(state);
                } else {
                  _drawNextParagraph(index + 1);
                }
              },
              child: WithSeparateSize(
                size: 15,
                enable: index != widget.section.paragraphs.length - 1,
                child: Text(
                  widget.section.paragraphs[index],
                  textAlign: TextAlign.left,
                  style: AppTextStyles.subtitle4Light.copyWith(
                    fontSize: 14,
                    color: AppColors.primaryTextColor,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
