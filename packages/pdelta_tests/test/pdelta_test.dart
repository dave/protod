import 'dart:io';

String assetPath(String name) {
  if (Directory.current.path.endsWith("/test")) {
    // flutter tests run in the test dir?
    return "../assets/$name";
  } else {
    // intellij tests run in the project root
    return "assets/$name";
  }
}
