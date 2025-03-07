import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sleepcyclesapp/components/CustompaperContent/build_text_section.dart';
import 'package:sleepcyclesapp/entitys/text_paragraph.dart';

class CustomPaperContent extends StatefulWidget {
  final PaperTextContent content;

  const CustomPaperContent({super.key, required this.content});

  @override
  State<CustomPaperContent> createState() => _CustomPaperContentState();
}

class _CustomPaperContentState extends State<CustomPaperContent> {
  List<GlobalKey<BuildTextSectionWidgetState>> _keys = [];

  GlobalKey<BuildTextSectionWidgetState> _addKey() {
    final key = GlobalKey<BuildTextSectionWidgetState>();
    _keys.add(key);
    return key;
  }

  drawSection(int index) {
    _keys[index].currentState!.drawParagraphs();
  }

  @override
  void initState() {
    Future.delayed(200.ms, () => drawSection(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.content.length,
      itemBuilder: (_, index) {
        return BuildTextSectionWidget(
          key: _addKey(),
          autoDraw: false,
          section: widget.content[index],
          onContentCompletelyVisible: (state) {
            if (index != widget.content.length - 1) {
              drawSection(index + 1);
              // _keys[index + 1].currentState!.drawParagraphs();
            }
          },
        );
      },
      separatorBuilder: (_, index) => SizedBox(height: 30),
    );
  }
}
