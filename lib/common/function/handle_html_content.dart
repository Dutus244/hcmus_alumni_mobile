String handleHtmlContent(String content) {
  return "<span>" +
      content.replaceAllMapped(
        RegExp(r'(<img[^>]+)(h=)', caseSensitive: false),
        (match) => '${match.group(1)}_${match.group(1)}',
      ) +
      "</span>";
}
