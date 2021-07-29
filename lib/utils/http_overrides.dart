import 'dart:io';

/*
? Handling CERTIFICATE_VERIFY_FAILED when API is in localhost.

* When calling HTTP responses API gets the following exception:
[VERBOSE-2:ui_dart_state.cc(199)] Unhandled Exception: HandshakeException:
Handshake error in client (OS Error: CERTIFICATE_VERIFY_FAILED: application
verification failure(handshake.cc:359))
*/

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          true;
  }
}
