import 'package:flutter/material.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/translations/PromoLocalizations.dart';
import 'package:crowdproj/widgets/slider/CpCarousel.dart';
import 'package:crowdproj/widgets/slider/CpSlide.dart';

class PromoPage extends StatefulWidget {
  @override
  _PromoPageState createState() => _PromoPageState();

  static String titleFormatter(
          {BuildContext context, RouteSettings settings}) =>
      PromoLocalizations.of(context).title;

  static String pathFormatter({RouteSettings settings}) => "/promo";

  static final route = RouteDescription(
      id: "PromoPage",
      pathFormatter: PromoPage.pathFormatter,
      titleFormatter: PromoPage.titleFormatter,
      builder: (BuildContext context) {
        return PromoPage();
      });
}

class _Slide {
  const _Slide(this.img, this.txt);

  final String img;
  final String txt;
}

class _PromoPageState extends State<PromoPage> {
  @override
  Widget build(BuildContext context) {
//    AppSession.get.routes.setWindow(context);
    return new Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
//          height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 200.0,
            ),
        alignment: Alignment.center,
        child: Stack(children: [
          Container(child: CpCarousel(imgList(context))),
          Container(
            alignment: Alignment.topRight,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Container(
                color: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: () {
                    closePromo();
                  },
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void closePromo() {
    AppSession.get.setPromoShown();
    AppSession.get.authService.notify();
  }

//  @override
//  void deactivate() {
//    super.deactivate();
//  }

  List<CpSlide> _imgListCache;

  List<CpSlide> imgList(BuildContext context) => _imgListCache != null
      ? _imgListCache
      : [
          _Slide(
              'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
              PromoLocalizations.of(context).title),
          _Slide(
              'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
              "Какой-то текст  2"),
          _Slide(
              'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
              "Какой-то текст 3"),
          _Slide(
              'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
              "Какой-то текст 4"),
          _Slide(
              'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
              "Какой-то текст 5"),
          _Slide(
              'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
              "Какой-то текст 6"),
        ].map((el) {
          return CpSlide(
            image: Image.network(
              el.img,
              fit: BoxFit.cover,
            ),
            text: CpSlide.defaultText(el.txt),
          );
        }).toList();
}
