import 'package:flutter/material.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/common/RouteDescription.dart';
import 'package:crowdproj/translations/PromoLocalizations.dart';
import 'package:crowdproj/widgets/slider/CpCarousel.dart';
import 'package:crowdproj/widgets/slider/CpSlide.dart';

class PromoPage extends StatefulWidget {
  @override
  _PromoPageState createState() => _PromoPageState();

  static final RouteDescription route = RouteDescription(
      id: "PromoPage",
      pathFormatter: ({dynamic arguments}) => "/promo",
      titleFormatter: ({BuildContext context, dynamic arguments}) =>
          PromoLocalizations.of(context).title,
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

  List<CpSlide> _imgListCache;

  List<CpSlide> imgList(BuildContext context) => _imgListCache != null
      ? _imgListCache
      : [
          _Slide(
            'assets/pages-promo-01.jpeg',
            PromoLocalizations.of(context).title,
          ),
          _Slide(
            'assets/pages-promo-02.jpeg',
            "Какой-то текст  2",
          ),
          _Slide(
            'assets/pages-promo-03.jpeg',
            "Какой-то текст 3",
          ),
          _Slide(
            'assets/pages-promo-04.jpeg',
            "Какой-то текст 4",
          ),
          _Slide(
            'assets/pages-promo-05.jpeg',
            "Какой-то текст 5",
          ),
        ].map((el) {
          return CpSlide(
            image: Image.asset(
              el.img,
              fit: BoxFit.cover,
            ),
            text: CpSlide.defaultText(el.txt),
          );
        }).toList();
}
