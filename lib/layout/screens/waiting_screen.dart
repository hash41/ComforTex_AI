import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:comfortex_ai/exception/bad_request_exception.dart';
import 'package:comfortex_ai/exception/endpoint_not_found_exception.dart';
import 'package:comfortex_ai/exception/many_requests_exception.dart';
import 'package:comfortex_ai/exception/server_exception.dart';
import 'package:comfortex_ai/exception/unauthorized_exception.dart';
import 'package:comfortex_ai/exception/unprocessable_entity_exception.dart';
import 'package:comfortex_ai/layout/screens/desktop_login_screen.dart';
import 'package:comfortex_ai/layout/screens/desktop_results_screen.dart';
import 'package:comfortex_ai/layout/screens/mobile_login_screen.dart';
import 'package:comfortex_ai/layout/screens/mobile_results_screen.dart';
import 'package:comfortex_ai/layout/screens/screen.dart';
import 'package:comfortex_ai/layout/ui_components/common/top_bar.dart';
import 'package:comfortex_ai/layout/ui_components/mobile/back_button.dart';
import 'package:comfortex_ai/model/properties.dart';
import 'package:comfortex_ai/utils/Networking.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class WaitingScreen extends StatefulWidget {
  Properties properties;
  WaitingScreen(this.properties, {super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen>
    with SingleTickerProviderStateMixin {
  String status = 'Loading AI results';
  late AnimationController? _controller;
  Widget? _leading;

  Future<void> getUseCase() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final networking = Networking();
      await networking.httpGet(widget.properties);
      if (mounted) {
        _controller?.dispose();
        _controller = null;
        await Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(
                seconds: 2,
              ),
              reverseTransitionDuration: const Duration(
                seconds: 2,
              ),
              pageBuilder: (_, __, ___) => Screen(
                    desktop: DesktopResultsScreen(widget.properties),
                    mobile: MobileResultsScreen(widget.properties),
                  ),
              transitionsBuilder: (context, animation1, animation2, child) {
                final curved = CurvedAnimation(
                    parent: animation1, curve: Curves.easeInOut);
                return FadeTransition(
                  opacity: curved,
                  child: child,
                );
              }),
        );
      }
    } on http.ClientException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        status = 'Client error occurred, please try again later';
      });
    } on TimeoutException catch (e) {
      setState(() {
        status = 'Request timed out, please try again later';
      });
    } on UnauthorizedException catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute<DesktopLoginScreen>(
          builder: (context) {
            return Screen(
              desktop: DesktopLoginScreen(),
              mobile: MobileLoginScreen(),
            );
          },
        ),
      );
      //navigation_helper.redirectToLogin();
    } on ServerException catch (e) {
      setState(() {
        status = 'Server error, we appologize for this inconvenience';
      });
    } on ManyRequestsException catch (e) {
      setState(() {
        status = e.message;
      });
    } on BadRequestException catch (e) {
      setState(() {
        status = e.message;
      });
    } on EndpointNotFoundException catch (e) {
      setState(() {
        status = e.message;
      });
    } on UnprocessableEntityException catch (e) {
      setState(() {
        status = e.message;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        status = e.toString().replaceFirst('Exception:', '');
      });
    } finally {
      _controller?.reset();
      if (mounted) {
        setState(() {
          _leading = const MaterialBackButton();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _controller!.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
    getUseCase();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    final orientation = MediaQuery.of(context).orientation;
    double topBarheight;
    if(height < 650) {
      if(orientation == Orientation.portrait) {
        topBarheight = Style.topBarHeightPortrait;
      } else {
        topBarheight = Style.topBarHeightLandscape;
      }
    }
    else if(height > 650 && height < 1200) {
      topBarheight = Style.topBarHeightDesktop;
    }
    else {
      topBarheight = Style.topBarOver1200;
    }
    return SafeArea(
      child: Scaffold(
        appBar: TopBar(
          height: topBarheight,
          leading: _leading,
          loggedIn: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 0,
            ),
            child: Opacity(
              opacity: _controller?.status == AnimationStatus.dismissed
                  ? 1.0
                  : _controller!.value,
              child: AutoSizeText(
                status,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                    color: Colors.black,
                  ),
                ),
                minFontSize: 30,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
