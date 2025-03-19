import 'package:auto_size_text/auto_size_text.dart';
import 'package:comfortex_ai/layout/components/title_widget.dart';
import 'package:comfortex_ai/utils/file_listing.dart';
import 'package:comfortex_ai/utils/parse_json.dart';
import 'package:flutter/material.dart';

///CenterWidget is a desktop specific widget displayed among the widgets in
///"desktop_screen_1.dart".
class CenterWidget extends StatefulWidget {
  ///Constructor for the CenterWidget.
  const CenterWidget({super.key});

  //TODO Smaller arrows for the PageView.
  //TODO: better spacing the texts.
  @override
  State<CenterWidget> createState() => _CenterWidgetState();
}

///ShirtType to help us better clarify with the selection later.
enum ShirtType { polo, t_shirt }

class _CenterWidgetState extends State<CenterWidget> {
  String? _type;
  final PageController _pageController = PageController();
  List<String> _textiles = [];
  int _currentPage = 0;
  Map<String, dynamic>? _materialsDescriptions;

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
    if (_currentPage < _textiles.length / 8 - 1) {
      _goToPage(_currentPage + 1);
    }
  }

  ///A method [getAssets] to get the images found in 'assets/textile/' and then
  ///setState and thus updating screen.
  Future<void> getAssets() async {
    final result = await listAssets('assets/textile/$_type/');
    setState(() {
      _textiles = result;
    });
  }

  Future<void> getMaterialDescription() async {
    final result = await parseJson();
    setState(() {
      _materialsDescriptions = result;
    });
  }

  @override
  void initState() {
    getMaterialDescription();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  ///[changeBackGround] is easily used in setState and thus
  ///to animate the container [imgContainer].
  void changeBackGround(ShirtType newType) {
    switch (newType) {
      case ShirtType.polo:
        _type = ShirtType.polo.name;
      case ShirtType.t_shirt:
        _type = ShirtType.t_shirt.name;
    }
    getAssets();
    setState(() {
      _currentPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(
                child: TitleWidget(
                  iconPath: 'assets/icons/Shirt_2.png',
                  title: 'Garment Type',
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          hoverColor: Colors.black,
                          hoverDuration: const Duration(milliseconds: 350),
                          onTap: () {
                            changeBackGround(ShirtType.polo);
                          },
                          child: ImgContainer(
                            selected: _type == ShirtType.polo.name,
                            child: Image.asset(
                              fit: BoxFit.scaleDown,
                              'assets/icons/polo.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          hoverDuration: const Duration(milliseconds: 350),
                          hoverColor: Colors.black,
                          onTap: () {
                            changeBackGround(ShirtType.t_shirt);
                          },
                          child: ImgContainer(
                            selected: _type == ShirtType.t_shirt.name,
                            child: Image.asset(
                              fit: BoxFit.scaleDown,
                              'assets/icons/t_shirt.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(
                child: TitleWidget(iconPath: 'assets/icons/19.png', title: 'Material'),
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: _type == null
                    ? const Center(
                        child: AutoSizeText(
                          'Select the Garment Type to display the materials',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      )
                    : PageView.builder(
                        key: ValueKey(_type),
                        controller: _pageController,
                        itemCount: (_textiles.length / 8).ceil(),
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildExpandedButton(
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.grey.shade600,
                                ),
                                _previousPage,
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: _loadTextiles(index),
                                ),
                              ),
                              buildExpandedButton(
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey.shade600,
                                ),
                                _nextPage,
                              ),
                            ],
                          );
                          //Column(
                          //   children: getTextiles(index),
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded buildExpandedButton(Icon icon, VoidCallback? onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: FittedBox(
          fit: BoxFit.fill,
          child: icon,
        ),
      ),
    );
  }

  ///Locks 4 Items inside the [PageView].
  ///Its result is returned to be used in PageView.
  List<Widget> _loadTextiles(int page) {
    final imgIndex = page * 8;
    return [
      Expanded(
        child: Row(
          children: [
            Expanded(
              child: getItem(
                img: _textiles.elementAtOrNull(imgIndex),
                img2: _textiles.elementAtOrNull(imgIndex + 1),
              ),
            ),
            const SizedBox(width: 36),
            Expanded(
              child: getItem(
                img: _textiles.elementAtOrNull(imgIndex + 2),
                img2: _textiles.elementAtOrNull(imgIndex + 3),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Row(
          children: [
            Expanded(
              child: getItem(
                img: _textiles.elementAtOrNull(imgIndex + 4),
                img2: _textiles.elementAtOrNull(imgIndex + 5),
              ),
            ),
            const SizedBox(width: 36),
            Expanded(
              child: getItem(
                img: _textiles.elementAtOrNull(imgIndex + 6),
                img2: _textiles.elementAtOrNull(imgIndex + 7),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  ///Item inside a PageView widget, I have 4 of these to start inside each
  ///PageView. Contains 2 assets and a text under them.

  Widget getItem({String? img, String? img2}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Row(
            children: [
              if (img != null)
                Expanded(
                  child: Image.asset(
                    fit: BoxFit.fill,
                    'assets/textile/$_type/$img',
                  ),
                )
              else
                Expanded(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              const SizedBox(
                width: 12,
              ),
              if (img2 != null)
                Expanded(
                  child: Image.asset(
                    fit: BoxFit.fill,
                    'assets/textile/$_type/$img2',
                  ),
                )
              else
                Expanded(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
        AutoSizeText(
          _materialsDescriptions?[img?.split('_').sublist(0, 2).join(' ')]
                      ?['composition']
                  .toString() ??
              '',
          style: const TextStyle(fontSize: 14),
          maxLines: 2,
          minFontSize: 10,
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}

/// A decoratedContainer to make the identification easier of selectedImage from
/// [polo,tShirt].
class ImgContainer extends StatelessWidget {
  ///Constructor for the ImgContainer.
  const ImgContainer({required Widget child, super.key, bool selected = false})
      : _child = child,
        _selected = selected;

  final bool _selected;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        border:
            _selected ? Border.all(width: 4, color: Colors.lightBlue) : null,
        borderRadius: BorderRadius.circular(16),
      ),
      child: _child,
    );
  }
}
