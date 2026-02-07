// admin_redirect.dart

// 1. By default, use the stub (mobile) version
// 2. If the library 'dart:js_interop' exists (meaning we are on Web), use the
// web version
export 'navigation_helper_stub.dart'
if (dart.library.js_interop) 'navigation_helper_web.dart';
