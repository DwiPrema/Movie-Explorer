class ResponsiveHelper {
  static double viewportFraction(double width) {
    if (width >= 1200) return 0.15;
    if (width >= 900) return 0.2;
    if (width >= 700) return 0.3;
    return 0.45;
  }

  static double heightCarousel(double width) {
  if (width >= 1200) return width * 0.3;
  if (width >= 900) return width * 0.45;
  if (width >= 700) return width * 0.6;
  return width * 0.95;
}

}
