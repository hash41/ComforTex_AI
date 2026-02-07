import 'package:web/web.dart' as web;

/// Only allow admin to access their endpoint if the platform is [web]
void redirectToAdminBoard() {
  // This uses the browser's native API to change the page location.
  final origin = web.window.location.origin;
  // under the same hood we use relative path..
  web.window.location.href = '$origin/comfortex_admin';
  // but when launching through android studio its a different server, hence
  // different host..
}
