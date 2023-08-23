import 'dart:io';

void main() {
  print("Running post-process steps after 'flutter pub get'...");

  Process.runSync('chmod', ['+x', '../scripts/*.sh']);
  Process.runSync('sh', ['../scripts/gitHookInstall.sh']);

  print("Shell script has been executed.");
}
