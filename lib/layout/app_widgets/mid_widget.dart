import 'package:flutter/material.dart';
import '../../utils/file_listing.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MidWidget extends StatefulWidget {
  const MidWidget({super.key});

  @override
  State<MidWidget> createState() => _MidWidgetState();
}

enum ShirtType { polo, tShirt }

class _MidWidgetState extends State<MidWidget> {
  String? _type;
  final PageController _pageController = PageController(initialPage: 0);
  List<String> _textiles = [];
  int _currentPage = 0;

  void _goToPage(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 10), curve: Curves.fastOutSlowIn);
    setState(() {
      _currentPage = index;
    });
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }

  void _nextPage() {
    if (_currentPage < _textiles.length ~/ 8) {
      _goToPage(_currentPage + 1);
    }
  }

  List<Widget> getTextiles(int page) {
    int imgIndex = page * 4;
    return _loadTextiles(
        _textiles[imgIndex],
        _textiles[imgIndex + 1],
        _textiles[imgIndex + 2],
        _textiles[imgIndex + 3],
        _textiles[imgIndex],
        _textiles[imgIndex + 1],
        _textiles[imgIndex + 2],
        _textiles[imgIndex + 3]);
  }

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
                Image.asset(width: 48, height: 48, 'icons/Shirt_2.png'),
                SizedBox(
                  width: 24,
                  height: 24,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: AutoSizeText(
                    "Garment Type",
                    style: TextStyle(fontSize: 24, color: Colors.blue),
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
                  SizedBox(width: 48.0,),
                  Image.asset(height: 24.0, width: 24.0, 'icons/19.png'),
                  Text(
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

class ImgContainer extends StatelessWidget {
  final bool selected;
  final Widget child;

  const ImgContainer({required this.child, super.key, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      decoration: BoxDecoration(
        border:
            selected ? Border.all(width: 4.0, color: Colors.lightBlue) : null,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: child,
    );
  }
}

///try

List<Widget> _loadTextiles(
    String imageName,
    String image2Name,
    String image3Name,
    String image4Name,
    String image5Name,
    String image6Name,
    String image7Name,
    String image8Name) {
  return [
    Expanded(
      child: Row(
        children: [
          Expanded(
            child: Item(
              imageName: imageName,
              imageName2: image2Name,
            ),
          ),
          SizedBox(width: 36.0),
          Expanded(
            child: Item(
              imageName: image3Name,
              imageName2: image4Name,
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
              imageName: image5Name,
              imageName2: image6Name,
            ),
          ),
          SizedBox(width: 36.0),
          Expanded(
            child: Item(
              imageName: image7Name,
              imageName2: image8Name,
            ),
          ),
        ],
      ),
    ),
  ];
}

///Item inside a MaterialType widget.
///Contains 2 assets and a text under them.

class Item extends StatelessWidget {
  final String imageName;
  final String imageName2;

  //TODO description
  const Item({super.key, required this.imageName, required this.imageName2});

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
                  'textile/$imageName',
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(

                child: Image.asset(
                  fit: BoxFit.fill,
                  'textile/$imageName2',
                ),
              ),
            ],
          ),
        ),
        AutoSizeText(
          "Material Type",
          style: TextStyle(fontSize: 14.0),
          maxLines: 2,
          minFontSize: 10,
        ),
        SizedBox(height: 6,)
      ],
    );
  }
}