String truncateWithEllipsis(String text, {int maxLength = 20}) {
  return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
}
