int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  //The average reading speed varies depending on different sources but is usually in the 200-300 wpm range
  // so taking 225 as average
  final readingTime = wordCount / 225; // using formula speed = dis/time

  return readingTime.ceil();
}
