import 'package:comfortex_ai/exception/bad_request_exception.dart';
import 'package:comfortex_ai/exception/many_requests_exception.dart';
import 'package:comfortex_ai/exception/server_exception.dart';
import 'package:comfortex_ai/exception/unauthorized_exception.dart';
import 'package:comfortex_ai/layout/screens/select_ai_screen.dart';
import 'package:comfortex_ai/layout/ui_components/common/top_bar.dart';
import 'package:comfortex_ai/utils/auth_api_mobile.dart';
import 'package:comfortex_ai/utils/auth_api_v2.dart';
import 'package:comfortex_ai/utils/auth_api_web.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:comfortex_ai/utils/navigation_helper_stub.dart'
    if (dart.library.html) 'package:comfortex_ai/utils/navigation_helper_web.dart'
    as navigation_helper;
import 'package:http/http.dart';

class DesktopLoginScreen extends StatefulWidget {
  const DesktopLoginScreen({super.key});

  @override
  State<DesktopLoginScreen> createState() => _DesktopLoginScreenState();
}

class _DesktopLoginScreenState extends State<DesktopLoginScreen> with TickerProviderStateMixin {
  String username = '';
  String password = '';
  String? message;
  var _scale = 1.0;
  var _scale2 = 1.0;
  var _buttonEnabled = true;
  late AnimationController _controller;
  late AnimationController _controller2;

  void submit() async {
    setState(() {
    _buttonEnabled = false;
    message = '';
    });
    AuthApiv2 authApi;
    if(kIsWeb) {
    authApi = AuthApiWeb();
    } else {
      authApi = AuthApiMobile();
    }
    if (username == '' || password == '') {
      setState(() {
        _buttonEnabled = true;
        message = 'username and password cannot be empty';
      });
      return;
    } else if (username.length < 4 || password.length < 8) {
      setState(() {
        _buttonEnabled = true;
        message = 'username or password too short';
      });
      return;
    } else {
      try {
        final groups = await authApi.login(username, password);
        if (groups.contains('admin')) {
          try {
            //For diversity i will keep this redirect.. It is implemented via different auth and a JSP interface..
            return navigation_helper.redirectToAdminboard();
          } catch (e) {
            setState(() {
              message = 'Admins login is done via web browsers';
            });
          }
        } else if (groups.contains('user')) {
          setState(() {
            _controller.forward().whenComplete(() {
              _controller2.forward().whenComplete(() {
                _controller.reverse().whenComplete(() {_controller2.reverse();});});
            });
          });
          await Future.delayed(const Duration(milliseconds: 2350), (){});
          await Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(seconds: 2,),
                reverseTransitionDuration: const Duration(seconds: 2,),
                pageBuilder: (_, __, ___) => SelectAiScreen(),
                transitionsBuilder: (context, animation1, animation2, child) {
                  final curved = CurvedAnimation(parent: animation1, curve: Curves.decelerate);
                  return FadeTransition(
                    opacity: curved,
                    child: child,
                  );
                }
            ),
          );
        } else {
          if (kDebugMode) {
            print('Backend error');
          }
        }
      } on UnauthorizedException catch (e) {
        setState(() {
          message = 'Invalid credentials';
        });
        if(kDebugMode) {
        print(e);
        }
      } on ManyRequestsException catch (e) {
        setState(() {
          message = e.message;
        });
      } on ServerException catch (e) {
        setState(() {
          message = e.message;
        });
      } on ClientException {
        setState(() {
          message = "The connection to the server couldn't be established";
        });
      } on BadRequestException {
        setState(() {
          message = "The request you've sent is not correct..";
        });
      }
      on Exception catch (e) {
        if(kDebugMode)
          {
        print(e);
          }
        setState(() {
          message = 'Generic error, possible reasons:\n - Browser CORS issues \n'
              ' - Server under maintenance \n..\n'
              '--> we apologize for this inconvenience <--';
        });
      }
    }
    setState(() {
    _buttonEnabled = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
      upperBound: 64,
    )..addListener((){setState(() {

    });});
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
      upperBound: 64,
    )..addListener((){
      setState(() {
    });});
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: TopBar(
          height: Style.topBarHeightDesktop,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              children: [
                Text('±'),
                Spacer(),
                Text('±'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '~ ',
                  style: GoogleFonts.roboto(
                    textStyle:
                        Style.desktopSubtitle.copyWith(color: Colors.red),
                  ),
                ),
                Text(
                  'Please enter your username and password to access our AI',
                  style: GoogleFonts.roboto(
                    textStyle: Style.desktopSubtitle,
                  ),
                ),
                Text(
                  ' ~',
                  style: GoogleFonts.roboto(
                    textStyle:
                        Style.desktopSubtitle.copyWith(color: Colors.red),
                  ),
                ),
              ],
            ),
            const Gap(16),
            AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 400),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Spacer(),
                  Flexible(
                    child: Text(
                      'Username:',
                      style: GoogleFonts.roboto(
                        textStyle: Style.bodyTextDesktop,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Flexible(
                    child: TextField(
                      maxLength: 16,
                      onChanged: (String value) => username = value,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.next,
                      onTap: () {
                        setState(() {
                          _scale = 1.05;
                          _scale2 = 0.95;
                        });
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            AnimatedScale(
              duration: const Duration(milliseconds: 400),
              scale: _scale2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Spacer(),
                  Flexible(
                    child: Text(
                      'Password:',
                      style: GoogleFonts.roboto(
                        textStyle: Style.bodyTextDesktop,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Flexible(
                    child: TextField(
                      maxLength: 16,
                      obscureText: true,
                      onChanged: (String value) => password = value,
                      decoration: const InputDecoration(filled: true),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => submit(),
                      onTap: () {
                        setState(() {
                          _scale = 0.95;
                          _scale2 = 1.05;
                        });
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(_controller.value, _controller2.value),
              child: Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: MaterialButton(
                      elevation: 12,
                      hoverElevation: 24,
                      height: 48,
                      minWidth: MediaQuery.sizeOf(context).width / 4,
                      splashColor: Colors.orange,
                      color: _controller.value != 0 && _controller2.value == 0 ? Colors.purpleAccent :
                      _controller.value != 0 && _controller2.value != 0 ?
                        Colors.greenAccent : _controller.value == 0 && _controller2.value != 0 ? Colors.green :
                      Colors.blueAccent,
                      hoverColor: Colors.black,
                      onPressed: _buttonEnabled ? submit: (){},
                      shape: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            16,
                          ),
                        ),
                        borderSide: BorderSide(
                          width: 0,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.roboto(
                          textStyle: Style.buttonTextDesktop
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const Row(
              children: [
                Text('<<'),
                Spacer(),
                Text('>>'),
              ],
            ),
            if (message != null)
              Text(
                message!,
                style: GoogleFonts.roboto(
                  textStyle: Style.bodyTextDesktop.copyWith(
                    color: Colors.red,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
