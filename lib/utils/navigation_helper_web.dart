import 'package:web/web.dart' as web;

void redirectToAdminboard() {
  // This uses the browser's native API to change the page location.
  final origin = web.window.location.origin;
  web.window.location.href = '$origin/comfortex_admin';//under the same hood we use relative path..
  //but when launching through android studio its a differrent server, hence different host..
}