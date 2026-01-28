import 'package:auto_size_text/auto_size_text.dart';
import 'package:comfortex_ai/layout/ui_components/common/img_container.dart';
import 'package:comfortex_ai/layout/screens/desktop_screen_1.dart';
import 'package:comfortex_ai/layout/screens/garment_properties_screen.dart';
import 'package:comfortex_ai/layout/screens/screen.dart';
import 'package:comfortex_ai/model/Properties_v2.dart';
import 'package:comfortex_ai/utils/assets.dart';
import 'package:comfortex_ai/utils/file_listing.dart';
import 'package:comfortex_ai/utils/parse_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

/// PageBuilder is a widget that builds a page view of textile images and text.
class PageBuilder extends StatefulWidget {
  /// Constructor for PageBuilder widget.
  const PageBuilder(
    this.properties,
    this.setDescription, {
    super.key,
    this.mobileWidget = false,
  });

  /// Properties of the PageBuilder widget.
  /// is a boolean that indicates if the widget is for mobile or not.
  final bool mobileWidget;

  ///properties passed from the parent widget.
  final PropertiesV2 properties;

  ///setDescription is a function that takes a string and returns void.
  final void Function(String description) setDescription;

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  final PageController _pageController = PageController();
  List<String> _textiles = [];
  int _currentPage = 0;
  Map<String, dynamic>? _materialsDescriptions;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getAssets();
  }

  ///Method _goToPage takes @index to instruct the _pageController to go to the
  ///previous page in PageView.
  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 10),
      curve: Curves.linear,
    );
  }

  ///method to take the page 1 step backward by calling _goToPage in PageView.
  void _previousPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }

  ///method to take the page 1 step forward by calling _goToPage in PageView
  void _nextPage() {
    if (widget.mobileWidget) {
      if (_currentPage < (_textiles.length / 4) - 1) {
        _goToPage(_currentPage + 1);
      }
    } else {
      if (_currentPage < (_textiles.length / 8) - 1) {
        _goToPage(_currentPage + 1);
      }
    }
  }

  ///A method [getAssets] to get the images found in 'assets/textile/' and then
  ///setState and thus updating screen.
  Future<void> getAssets() async {
    final resultImgAssets = await listAssets(
        '${Assets.TEXTILES_PATH}${widget.properties.shirtType!.name}/');
    final resultTextLoader = await parseJson();
    setState(() {
      _currentPage = 0;
      _textiles = resultImgAssets;
      _materialsDescriptions = resultTextLoader;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.mobileWidget
          ? (_textiles.length / 4).ceil()
          : (_textiles.length / 8).ceil(),
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildFlexibleButton(
              Icon(
                size: widget.mobileWidget ? 52 : 72,
                Icons.arrow_back_ios,
                color: Colors.grey.shade600,
              ),
              _previousPage,
            ),
            Flexible(
              flex: widget.mobileWidget ? 3 : 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _loadTextiles(index),
              ),
            ),
            buildFlexibleButton(
              Icon(
                size: widget.mobileWidget ? 52 : 72,
                Icons.arrow_forward_ios,
                color: Colors.grey.shade600,
              ),
              _nextPage,
            ),
          ],
        );
      },
    )
        .animate(
          key: ValueKey(widget.properties.shirtType),
        )
        .fadeIn(
          duration: const Duration(seconds: 1),
        );
  }

  Flexible buildFlexibleButton(Icon icon, VoidCallback? onTap) {
    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          child: icon,
        ),
      ),
    );
  }

  ///Locks 4(mobile) - 8(desktop) Items inside the [PageView].
  ///Its result is returned to be used in PageView.
  List<Widget> _loadTextiles(int page) {
    final int imgIndex;
    List<Widget> result = [];
    if (widget.mobileWidget) {
      imgIndex = page * 4;
      for (int i = 0; i < 4; i += 2) {
        final img1 = _textiles.elementAtOrNull(imgIndex + i);
        final img2 = _textiles.elementAtOrNull(imgIndex + i + 1);
        final fabricNum = int.tryParse(img1?.split('_')[1] ?? '0');
        final description =
            _materialsDescriptions?[img1?.split('_').sublist(0, 2).join(' ')]
                        ?['composition']
                    .toString() ??
                '';
        result.add(Expanded(
          child: Row(
            children: [
              Flexible(
                child: ImgContainer(
                  selected: widget.properties.material == description,
                  onTap: () async {
                    widget.setDescription(description);
                    widget.properties.fabricNum = fabricNum;
                    await Future.delayed(Duration(milliseconds: 500), () {});
                    Navigator.push(
                      context,
                      MaterialPageRoute<GarmentPropertiesScreen>(
                        builder: (context) {
                          return Screen(
                            desktop: DesktopScreen1(widget.properties),
                            mobile: GarmentPropertiesScreen(
                              properties: widget.properties,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: displayItem(
                    img: img1,
                    img2: img2,
                    description: description,
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    } else {
      imgIndex = page * 8;
      for (int i = 0; i < 8; i += 4) {
        String? img1 = _textiles.elementAtOrNull(imgIndex + i);
        String? img2 = _textiles.elementAtOrNull(imgIndex + i + 1);
        String? img3 = _textiles.elementAtOrNull(imgIndex + i + 2);
        String? img4 = _textiles.elementAtOrNull(imgIndex + i + 3);
        final fabricNum =
            img1 != null ? int.tryParse(img1.split('_')[1]) ?? 0 : -1;
        final fabricNum2 =
            img3 != null ? int.tryParse(img3.split('_')[1]) ?? 0 : -1;
        String? description =
            _materialsDescriptions?[img1?.split('_').sublist(0, 2).join(' ')]
                        ?['composition']
                    .toString() ??
                '';
        String? description2 =
            _materialsDescriptions?[img3?.split('_').sublist(0, 2).join(' ')]
                        ?['composition']
                    .toString() ??
                '';
        result.add(
          Flexible(
            child: Row(
              children: [
                Flexible(
                  child: ImgContainer(
                    selected: widget.properties.material == description,
                    onTap: () {
                      widget.setDescription(description);
                      widget.properties.fabricNum = fabricNum;
                      //TODO: setstate?
                    },
                    child: displayItem(
                      img: img1,
                      img2: img2,
                      description: description,
                    ),
                  ),
                ),
                const Gap(36),
                Flexible(
                  child: ImgContainer(
                    selected: widget.properties.material == description2,
                    onTap: () {
                      widget.setDescription(description2);
                      widget.properties.fabricNum = fabricNum2;
                    },
                    child: displayItem(
                      img: img3,
                      img2: img4,
                      description: description2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    return result;
  }

  ///Item inside a PageView widget, I have 4 of these to start inside each
  ///PageView. Contains 2 assets and a text under them.

  Widget displayItem({String? img, String? img2, String? description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: widget.mobileWidget ? 3 : 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (img != null)
                Flexible(
                  child: Image.asset(
                    '${Assets.TEXTILES_PATH}${widget.properties.shirtType!.name}/$img',
                  ),
                )
              else
                Expanded(
                  child: Container(),
                ),
              const Gap(16),
              if (img2 != null)
                Flexible(
                  child: Image.asset(
                    '${Assets.TEXTILES_PATH}${widget.properties.shirtType!.name}/$img2',
                  ),
                )
              else
                Expanded(
                  child: Container(),
                ),
            ],
          ),
        ),
        Flexible(
          child: AutoSizeText(
            description ?? '',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: widget.mobileWidget ? 12 : 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            maxLines: 2,
            minFontSize: widget.mobileWidget ? 11 : 12,
            overflow: TextOverflow.visible,
          ),
        ),
        Gap(
          widget.mobileWidget ? 10 : 12,
        ),
      ],
    );
  }
}
