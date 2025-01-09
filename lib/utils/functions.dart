String getIdFromDriveLink(String url) {
  final RegExp regex =
      RegExp(r"https://drive\.google\.com/file/d/([^/]+)/view");
  final match = regex.firstMatch(url);
  if (match != null) {
    return match.group(1)!;
  } else {
    return "";
  }
}
