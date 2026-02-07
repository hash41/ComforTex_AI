import 'package:comfortex_ai/exception/bad_request_exception.dart';
import 'package:comfortex_ai/exception/many_requests_exception.dart';
import 'package:comfortex_ai/exception/server_exception.dart';
import 'package:comfortex_ai/exception/unauthorized_exception.dart';
import 'package:comfortex_ai/layout/screens/select_ai_screen.dart';
import 'package:comfortex_ai/layout/ui_components/common/top_bar.dart';
import 'package:comfortex_ai/utils/auth_api_mobile.dart';
import 'package:comfortex_ai/utils/auth_api_v2.dart';
import 'package:comfortex_ai/utils/auth_api_web.dart';
import 'package:comfortex_ai/utils/navigation_helper.dart' as navigation_helper;
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

///Mobile screen widget able to display multiple objects related to
/// the login process
class MobileLoginScreen extends StatefulWidget {
  /// default constructor
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  String username = '';
  String password = '';
  String? message;
  bool _buttonEnabled = true;
  Color? _loggingIn;

  //We can add context and refactor this message.
  Future<void> submit() async {
    setState(() {
      _buttonEnabled = false;
      _loggingIn = Colors.red;
      message = '';
    });
    await Future.delayed(const Duration(milliseconds: 550), () {});
    AuthApiV2 authApi;
    if (kIsWeb) {
      authApi = AuthApiWeb();
    } else {
      authApi = AuthApiMobile();
    }
    if (username == '' || password == '') {
      setState(() {
        message = 'username and password cannot be empty';
        _buttonEnabled = true;
      });
    } else if (username.length < 4 || password.length < 8) {
      setState(() {
        message = 'username or password too short';
        _buttonEnabled = true;
      });
    } else {
      try {
        final groups = await authApi.login(username, password);
        if (groups.contains('admin')) {
          try {
            //For diversity i will keep this redirect.. It is implemented via
            // different auth and a JSP interface..
            navigation_helper.redirectToAdminBoard();
          } on Exception {
            setState(() {
              message = 'Admins login is done via web browsers';
            });
          }
        } else if (groups.contains('user')) {
          setState(() {
            _loggingIn = Colors.yellow.shade600;
          });
          await Future.delayed(const Duration(milliseconds: 550), () {});
          setState(() {
            _loggingIn = Colors.green;
          });
          await Future.delayed(const Duration(milliseconds: 550), () {});
          if (mounted) {
            await Navigator.push(
              context,
              PageRouteBuilder<SelectAiScreen>(
                transitionDuration: const Duration(
                  seconds: 2,
                ),
                reverseTransitionDuration: const Duration(
                  seconds: 2,
                ),
                pageBuilder: (_, __, ___) => SelectAiScreen(),
                transitionsBuilder: (context, animation1, animation2, child) {
                  final curved = CurvedAnimation(
                      parent: animation1, curve: Curves.decelerate,);
                  return FadeTransition(
                    opacity: curved,
                    child: child,
                  );
                },
              ),
            );
          }
        } else {
          if (kDebugMode) {
            print('Backend error');
          }
        }
      } on UnauthorizedException catch (e) {
        setState(() {
          message = e.message;
        });
        if (kDebugMode) {
          print(e);
        }
      } on ManyRequestsException catch (e) {
        setState(() {
          message = e.message;
        });
      } on BadRequestException {
        setState(() {
          message = "The request you've sent is not correct..";
        });
      } on ServerException catch (e) {
        setState(() {
          message = e.message;
        });
      } on ClientException {
        setState(() {
          message = "The connection to the server couldn't be established";
        });
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e);
        }
        setState(() {
          message =
              'Generic error, possible reasons:\n - Browser CORS issues \n'
              ' - Server under maintenance \n..\n'
              '--> we apologize for this inconvenience <--';
        });
      } finally {
        setState(() {
          _buttonEnabled = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: TopBar(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? Style.topBarHeightPortrait
              : Style.topBarHeightLandscape,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(
                color: Colors.black,
              ),
              Text(
                'Please enter your username and password to access our AI',
                style: GoogleFonts.roboto(
                  textStyle: Style.mobileSubtitle,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Gap(16),
                  Flexible(
                    child: Text(
                      'Username:',
                      style: GoogleFonts.roboto(
                        textStyle: Style.mobileSubtitle,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Flexible(
                    child: TextField(
                      maxLength: 16,
                      onChanged: (String value) => username = value,
                      style: GoogleFonts.roboto(
                        textStyle: Style.bodyTextMobile,
                      ),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                  const Gap(16),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Gap(16),
                  Flexible(
                      child: Text(
                    'Password:',
                    style: GoogleFonts.roboto(
                      textStyle: Style.mobileSubtitle,
                    ),
                  ),),
                  const Gap(16),
                  Flexible(
                    child: TextField(
                      maxLength: 16,
                      obscureText: true,
                      style: GoogleFonts.roboto(
                        textStyle: Style.bodyTextMobile,
                      ),
                      onChanged: (String value) => password = value,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                  const Gap(16),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _buttonEnabled ? '' : '··',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: _loggingIn,
                      fontSize: 18,
                    ),
                  ),
                  MaterialButton(
                    elevation: 12,
                    hoverElevation: 24,
                    height: 34,
                    hoverColor: Colors.black,
                    splashColor: Colors.orange,
                    color: Colors.blueAccent,
                    minWidth: MediaQuery.sizeOf(context).width / 1.2,
                    shape: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        width: 0,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    onPressed: _buttonEnabled
                        ? () async {
                            await submit();
                          }
                        : () {},
                    child: Text(
                      'Login',
                      style: GoogleFonts.roboto(
                        textStyle: Style.buttonTextMobile
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Text(
                    _buttonEnabled ? '' : '··',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: _loggingIn,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black,
              ),
              if (message != null)
                Text(
                  message!,
                  style: GoogleFonts.roboto(
                    textStyle: Style.bodyTextMobile.copyWith(color: Colors.red),
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
