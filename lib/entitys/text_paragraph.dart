typedef PaperTextContent = List<TextSection>;

class TextSection {
  final String title;
  final List<String> paragraphs;

  TextSection({required this.title, required this.paragraphs});
}
