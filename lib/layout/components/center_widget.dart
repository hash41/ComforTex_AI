import 'package:flutter/material.dart';
import '../../utils/file_listing.dart';
import 'package:auto_size_text/auto_size_text.dart';

///CenterWidget is a desktop specific widget displayed among the widgets in
///"desktop_screen_1.dart".
class CenterWidget extends StatefulWidget {
  const CenterWidget({super.key});

  @override
  State<CenterWidget> createState() => _CenterWidgetState();
}

///ShirtType to help us better clarify with the selection later.
enum ShirtType { polo, tShirt }

class _CenterWidgetState extends State<CenterWidget> {
  String? _type;
  final PageController _pageController = PageController(initialPage: 0);
  List<String> _textiles = [];
  int _currentPage = 0;

  ///Method _goToPage takes @index to instruct the _pageController to go to the
  ///previous page in PageView.
  void _goToPage(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 10), curve: Curves.fastOutSlowIn);
    setState(() {
      _currentPage = index;
    });
  }

  ///method to take the page 1 step backward by calling _goToPage in PageView.
  void _previousPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }

  ///method to take the page 1 step forward by calling _goToPage in PageView
  void _nextPage() {
    if (_currentPage < _textiles.length ~/ 8) {
      _goToPage(_currentPage + 1);
    }
  }

  ///Prepares the Textiles to be inserted in actual page of PageView
  List<Widget> getTextiles(int page) {
    int imgIndex = page * 4;
    return _loadTextiles(
      _textiles[imgIndex],
      _textiles[imgIndex + 1],
      _textiles[imgIndex + 2],
      _textiles[imgIndex + 3],
      _textiles[imgIndex + 4],
      _textiles[imgIndex + 5],
      _textiles[imgIndex + 6],
      _textiles[imgIndex + 7],
    );
  }

  ///A method [getAssets] to get the images found in 'assets/textile/' and then
  ///setState and thus updating screen.
  void getAssets() async {
    List<String> t = await listAssets('assets/textile/');
    setState(() {
      _textiles = t;
    });
  }

  @override
  void initState() {
    getAssets();
    super.initState();
  }


  ///[changeBackGround] is easily used in setState and thus
  ///to animate the container [imgContainer].
  void changeBackGround(ShirtType newType) {
    switch (newType) {
      case ShirtType.polo:
        _type = ShirtType.polo.name;
        break;
      case ShirtType.tShirt:
        _type = ShirtType.tShirt.name;
        break;
    }
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
              Row(children: [
                Flexible(
                    fit: FlexFit.loose,
                    child: Image.asset(width: 48, height: 48, 'icons/Shirt_2.png')),
                const SizedBox(
                  width: 24.0,
                  height: 24.0,
                ),
                const Flexible(
                  fit: FlexFit.loose,
                  child: AutoSizeText(
                    "Garment Type",
                    style: TextStyle(fontSize: 24.0, color: Colors.blue),
                    maxLines: 2,

                  ),
                ),
              ]),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: ImgContainer(
                        selected: _type == ShirtType.polo.name,
                        child: InkWell(
                          child: Image.asset(
                            fit: BoxFit.scaleDown,
                            'icons/polo.png',
                          ),
                          onTap: () {
                            setState(() {
                              changeBackGround(ShirtType.polo);
                            });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ImgContainer(
                        selected: _type == ShirtType.tShirt.name,
                        child: InkWell(
                          child: Image.asset(
                            fit: BoxFit.scaleDown,
                            'icons/t_shirt.png',
                          ),
                          onTap: () {
                            setState(() {
                              changeBackGround(ShirtType.tShirt);
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 48.0,
                  ),
                  Image.asset(height: 24.0, width: 24.0, 'icons/19.png'),
                  const Text(
                    "Material",
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _textiles.length ~/ 4,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: _previousPage,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: getTextiles(index),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: _nextPage,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                    //Column(
                    //   children: getTextiles(index),
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

/// A decoratedContainer to make the identification easier of selectedImage from
/// [polo,tShirt].
class ImgContainer extends StatelessWidget {
  final bool selected;
  final Widget child;

  const ImgContainer({required this.child, super.key, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        border:
            selected ? Border.all(width: 4.0, color: Colors.lightBlue) : null,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }
}

///Locks 4 Items inside the [PageView].
///Its result is returned to used in [getTextiles] method.
List<Widget> _loadTextiles(
    String img,
    String img2,
    String img3,
    String img4,
    String img5,
    String img6,
    String img7,
    String img8) {
  return [
    Expanded(
      child: Row(
        children: [
          Expanded(
            child: Item(
              img: img,
              img2: img2,
            ),
          ),
          const SizedBox(width: 36.0),
          Expanded(
            child: Item(
              img: img3,
              img2: img4,
            ),
          ),
        ],
      ),
    ),
    Expanded(
      child: Row(
        children: [
          Expanded(
            child: Item(
              img: img5,
              img2: img6,
            ),
          ),
          const SizedBox(width: 36.0),
          Expanded(
            child: Item(
              img: img7,
              img2: img8,
            ),
          ),
        ],
      ),
    ),
  ];
}

///Item inside a PageView widget, I have 4 of these to start inside each PageView.
///Contains 2 assets and a text under them.

class Item extends StatelessWidget {
  final String img;
  final String img2;

  const Item({super.key, required this.img, required this.img2});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Image.asset(
                  fit: BoxFit.fill,
                  'textile/$img',
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Image.asset(
                  fit: BoxFit.fill,
                  'textile/$img2',
                ),
              ),
            ],
          ),
        ),
        const AutoSizeText(
          "Material Type",
          style: TextStyle(fontSize: 14.0),
          maxLines: 2,
          minFontSize: 10,
        ),
        const SizedBox(
          height: 6,
        )
      ],
    );
  }
}
