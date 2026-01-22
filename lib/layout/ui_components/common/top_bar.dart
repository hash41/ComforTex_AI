import 'package:comfortex_ai/layout/screens/screen.dart';
import 'package:comfortex_ai/layout/ui_components/common/Options.dart';
import 'package:comfortex_ai/layout/ui_components/common/log_out.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

///The top part of the screen refactored here to implement in different sizes
///among desktop and mobile screens.
class TopBar extends StatelessWidget implements PreferredSizeWidget {

  ///Constructor for the TopBar.
  TopBar({super.key,  Widget? leading, double? height,
    bool? loggedIn, bool? options})
      : _leading = leading, _height = height, _loggedIn = loggedIn??false,
        _options = options??false;
  final Widget? _leading;
  final double? _height;
  final bool _loggedIn;
  final bool _options;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(_height??0),
      child: AppBar(
        leadingWidth: _leading != null ? 300 : 128,
        leading: Row(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                color: Colors.grey.shade200,
                child: _leading,),
            const Gap(8),
            if(_loggedIn)
              const LogOut(),
            if(_options)
              ...[const Gap(12), const Options()]
          ],
        ),
        backgroundColor: Colors.grey.shade200,
        actionsPadding: const EdgeInsets.only(right: 16),
        actions: [
          const Gap(48),
          Image.asset('assets/icons/logo.png',
              alignment: Alignment.bottomCenter,
              width: _height != null && _height >= 1080 ? 128 : 72,
              height: _height != null && _height >= 1080 ? 64 : 96,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    if(_height != null) {
      return Size(0 , _height);
    }
    if(_height != null && _height >= 1080) {
      return Size(0 , _height);//84
    }
    return const Size(0 , 62);
  }
}
