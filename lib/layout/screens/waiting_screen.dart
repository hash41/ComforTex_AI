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
import 'package:comfortex_ai/model/Properties_v2.dart';
import 'package:comfortex_ai/utils/Networking.dart';
import 'package:comfortex_ai/utils/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

/// The waiting screen widget which can render on both mobile and desktop
class WaitingScreen extends StatefulWidget {
  /// Almost a default constructor with the properties
  const WaitingScreen(this.properties, {super.key});
  /// Properties to pass to the results screen
  final PropertiesV2 properties;

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen>
    with SingleTickerProviderStateMixin {
  String status = 'Loading AI results';
  late AnimationController? _controller;
  Widget? _leading;

  Future<void> getUseCase() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    try {
      final networking = Networking();
      await networking.httpGet(widget.properties);
      if (mounted) {
        _controller?.dispose();
        _controller = null;
        await Navigator.pushReplacement(
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
                    desktopScreen: DesktopResultsScreen(widget.properties),
                    mobileScreen: MobileResultsScreen(widget.properties),
                  ),
              transitionsBuilder: (context, animation1, animation2, child) {
                final curved = CurvedAnimation(
                    parent: animation1, curve: Curves.easeInOut,);
                return FadeTransition(
                  opacity: curved,
                  child: child,
                );
              },),
        );
      }
    } on http.ClientException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        status = 'Client error occurred, please try again later';
      });
    } on TimeoutException {
      setState(() {
        status = 'Request timed out, please try again later';
      });
    } on UnauthorizedException  {
      if(mounted) {
        await Navigator.push(
            context,
            MaterialPageRoute<DesktopLoginScreen>(
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
      //navigation_helper.redirectToLogin();
    } on ServerException {
      setState(() {
        status = 'Server error, we apologize for this inconvenience';
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
    } on Exception catch (e) {
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
          _leading = Center(
            child: MaterialButton(
              height: 48,
              color: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Back to Selection',
                style:
                GoogleFonts.roboto(
                  textStyle: Style.buttonTextDesktop,
                ),
              ),
            ),
          );
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
    final height = MediaQuery.sizeOf(context).height;
    final orientation = MediaQuery.of(context).orientation;
    double topbarHeight;
    if(height < 650) {
      if(orientation == Orientation.portrait) {
        topbarHeight = Style.topBarHeightPortrait;
      } else {
        topbarHeight = Style.topBarHeightLandscape;
      }
    }
    else if(height > 650 && height < 1200) {
      topbarHeight = Style.topBarHeightDesktop;
    }
    else {
      topbarHeight = Style.topBarOver1200;
    }
    return SafeArea(
      child: Scaffold(
        appBar: TopBar(
          height: topbarHeight,
          leading: _leading,
          loggedIn: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
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
