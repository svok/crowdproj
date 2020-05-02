import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'CpSlide.dart';

class CpCarousel extends StatefulWidget {
  CpCarousel(this.images);

  final List<CpSlide> images;
  final CarouselController buttonCarouselController = CarouselController();

  @override
  _CpCarouselState createState() {
    return _CpCarouselState(images);
  }
}

class _CpCarouselState extends State<CpCarousel> {
  _CpCarouselState(this.images) {
    print("CP CAROUSEL CONSTR: ${images.length}");
  }

  int _current = 0;
  final List<CpSlide> images;
  CarouselSlider carouselSlider;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageWidgets = _imageList();

    return Container(
        child: Column(children: [
      _carouselSliderBuilder(imageWidgets, context),
      Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _map<Widget>(images, (index, url) {
              return InkWell(
                  onTap: () {
                    setState(() {
                      _current = index;
                      widget.buttonCarouselController.jumpToPage(index);
                    });
                  },
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4)),
                  ));
            }),
          ))
    ]));
  }

  List<T> _map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<Widget> _imageList() {
    return _map<Widget>(
      images,
      (int index, CpSlide slide) {
        return Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
                alignment: AlignmentDirectional.center,
                fit: StackFit.expand,
                children: <Widget>[
                  Positioned.fill(child: slide.image),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: slide.text,
                    ),
                  ),
                ]),
          ),
        );
      },
    ).toList();
  }

  Widget _carouselSliderBuilder(
      List<Widget> imageWidgets, BuildContext context) {
    final media = MediaQuery.of(context);
    carouselSlider = CarouselSlider(
      carouselController: widget.buttonCarouselController,
      items: imageWidgets,
      options: CarouselOptions(
        autoPlay: false,
        height:
            media.size.height - media.padding.top - media.padding.bottom - 32,
        enableInfiniteScroll: false,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );

    return carouselSlider;
  }
}
