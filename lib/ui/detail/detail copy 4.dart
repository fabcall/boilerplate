import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/widgets/phone_button_widget.dart';
import 'package:boilerplate/widgets/size_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(-33.852, 151.211), zoom: 11.0);
const LatLng _kMapCenter = LatLng(-33.852, 151.211);

final List<Map<String, dynamic>> carouselImgList = [
  {
    "imageUrl":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
    "imageHash": "LFHC1Rt700Rj~qof9Fj[00j[~qWB"
  },
  {
    "imageUrl":
        "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80",
    "imageHash": "LXGR^.-;D%ad~q%gM{MxtSxvofV?"
  },
  {
    "imageUrl":
        "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80",
    "imageHash": "LdEV{iEnxrR:AhXAngkDksxue-oz"
  }
];

final kCarouselHeight = 225.0.h;
final kBottomSheetCornerRadius = 16.0;

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  Size footerSize = Size(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          buildCarousel(),
          Column(
            children: [
              SizedBox(height: kCarouselHeight - kBottomSheetCornerRadius),
              buildBody(context),
            ],
          ),
        ],
      ),
      bottomSheet: SizeWidget(
        onChange: (Size size) {
          setState(() {
            footerSize = size;
          });
        },
        child: _DetailBottomSheet(),
      ),
    );
  }

  Widget buildCarousel() {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: kCarouselHeight,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: carouselImgList
              .map(
                (img) => Container(
                    child: BlurHash(
                  hash: img["imageHash"],
                  image: img["imageUrl"],
                )),
              )
              .toList(),
        ),
        buildCarouselPagination(),
        Positioned.fill(
            child: IgnorePointer(
          ignoring: true,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withAlpha(50),
                Colors.white.withAlpha(0),
              ],
            )),
          ),
        ))
      ],
    );
  }

  Widget buildCarouselPagination() {
    return Positioned(
      bottom: kBottomSheetCornerRadius + Dimens.dp12.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: carouselImgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(
                horizontal: Dimens.dp4.w,
                vertical: Dimens.dp8.h,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.white),
                  left: BorderSide(width: 1.0, color: Colors.white),
                  right: BorderSide(width: 1.0, color: Colors.white),
                  bottom: BorderSide(width: 1.0, color: Colors.white),
                ),
                shape: BoxShape.circle,
                color: (_currentIndex == entry.key
                    ? Colors.orange
                    : Colors.transparent),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildBody(context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: footerSize.height,
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kBottomSheetCornerRadius),
              topRight: Radius.circular(kBottomSheetCornerRadius),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [_DetailHeading(), _DetailBody()],
          ),
        ),
      ),
    );
  }
}

class _DetailHeading extends StatelessWidget {
  const _DetailHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.dp18.w,
          vertical: Dimens.dp12.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Churrascaria Churra Pinheiro de Ouro',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Aberto ',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.green,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '- Fecha às 22:00',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                MdiIcons.heart,
                color: Theme.of(context).colorScheme.primary,
                size: 36.0,
              ),
            ),
            Chip(
              label: Text('10%', style: TextStyle(color: Colors.white)),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TabBar(
              indicatorColor: Colors.orange,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "Sobre"),
                Tab(text: "Cardápio"),
                Tab(text: "Comentários"),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                _About(),
                _Menu(),
                Text('Teste'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailBottomSheet extends StatelessWidget {
  const _DetailBottomSheet({
    Key? key,
  }) : super(key: key);

  void launchMap({String lat = "47.6", String long = "-122.3"}) async {
    var mapSchema = 'geo:$lat,$long';
    if (await canLaunch(mapSchema)) {
      await launch(mapSchema);
    } else {
      throw 'Could not launch $mapSchema';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 6,
            offset: Offset(0, -6), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Dimens.dp18.w,
          Dimens.dp18.h,
          Dimens.dp18.w,
          MediaQuery.of(context).padding.bottom + Dimens.dp18.h,
        ),
        child: Row(
          children: [
            PhoneButtonWidget(phoneNumber: "51996196622"),
            SizedBox(width: Dimens.dp18.w),
            Expanded(
              child: ElevatedButton(
                onPressed: launchMap,
                child: Text('Como chegar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _About extends StatelessWidget {
  const _About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimens.dp24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  SvgPicture.asset(Assets.icLogo, height: 32.0, width: 32.0),
                  SizedBox(width: 4.0),
                  Text('pay', style: TextStyle(fontSize: 24.0))
                ],
              ),
              _ItemWidget(
                iconColor: Colors.yellow.shade700,
                iconData: MdiIcons.star,
                title: '4.9',
                caption: 'Avaliação',
              ),
              _ItemWidget(
                iconColor: Theme.of(context).colorScheme.primary,
                iconData: MdiIcons.mapMarker,
                title: '14 Km',
                caption: 'Distância',
              )
            ],
          ),
          SizedBox(height: Dimens.dp24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.dp18.w),
            child: Text(
              'Maecenas eu enim enim. Suspendisse vestibulum purus in ultricies dictum. Mauris ipsum sem, dictum bibendum sed elementum ut, convallis et magna. Curabitur tincidunt, tortor eget pharetra dictum, turpis purus ultricies turpis, ac iaculis dui ut ligula. \nDictum bibendum sed elementum ut, convallis et magna. Curabitur tincidunt, tortor eget pharetra dictum, turpis purus ultricies turpis, ac iaculis dui ut ligula.',
            ),
          ),
          SizedBox(height: Dimens.dp12.h),
          SizedBox(
            width: double.infinity,
            height: 300.0.h,
            child: GoogleMap(
              initialCameraPosition: _kInitialPosition,
              markers: {
                Marker(
                  markerId: MarkerId("marker_1"),
                  position: _kMapCenter,
                )
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final Color iconColor;
  final IconData iconData;
  final String title;
  final String caption;

  const _ItemWidget({
    Key? key,
    required this.iconColor,
    required this.iconData,
    required this.title,
    required this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: 32.0,
        ),
        SizedBox(width: 4.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(
              caption,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        )
      ],
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text("Teste"),
    );
  }
}
