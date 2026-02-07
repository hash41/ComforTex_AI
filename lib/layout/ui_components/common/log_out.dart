import 'package:comfortex_ai/layout/screens/desktop_login_screen.dart';
import 'package:comfortex_ai/layout/screens/mobile_login_screen.dart';
import 'package:comfortex_ai/layout/screens/screen.dart';
import 'package:comfortex_ai/utils/auth_api_mobile.dart';
import 'package:comfortex_ai/utils/auth_api_v2.dart';
import 'package:comfortex_ai/utils/auth_api_web.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///A logout button class, with a logout behaviour
class LogOut extends StatelessWidget {
  ///Default StatelessWidget constructor
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          AuthApiV2 authApi;
          if (kIsWeb) {
            authApi = AuthApiWeb();
          } else {
            authApi = AuthApiMobile();
          }
          await authApi.logout();
          if (context.mounted) {
            await Navigator.push(
              context,
              PageRouteBuilder<Screen>(
                transitionDuration: const Duration(
                  seconds: 2,
                ),
                reverseTransitionDuration: const Duration(
                  seconds: 2,
                ),
                pageBuilder: (_, __, ___) => Screen.build(
                  context,
                  desktopScreen: const DesktopLoginScreen(),
                  mobileScreen: const MobileLoginScreen(),
                ),
                transitionsBuilder: (context, animation1, animation2, child) {
                  final curved = CurvedAnimation(
                    parent: animation1,
                    curve: Curves.easeInOut,
                  );
                  return FadeTransition(
                    opacity: curved,
                    child: child,
                  );
                },
              ),
            );
          }
        } on Exception catch(e) {
          if (kDebugMode) {
            print(e);
          }
          if (context.mounted) {
            await Navigator.push(
              context,
              MaterialPageRoute<Screen>(
                builder: (context) {
                  return Screen.build(
                    context,
                    desktopScreen: const DesktopLoginScreen(),
                    mobileScreen: const MobileLoginScreen(),
                  );
                },
              ),
            );
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: BoxBorder.all(color: Colors.redAccent.shade100),
        ),
        child: Text(
          'Logout',
          style: GoogleFonts.roboto(textStyle: Style.bodyTextDesktop),
        ),
      ),
    );
  }
}
