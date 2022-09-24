import 'dart:math';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/widgets/phone_button_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

const _kHeaderHeight = 100.0;
const _kFooterHeight = 90.0;
const _kCarouselHeight = 225.0;
const _kSlidingSheetCornerRadius = 16.0;
const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(-33.852, 151.211), zoom: 11.0);
const LatLng _kMapCenter = LatLng(-33.852, 151.211);

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final snapPoint =
        size.height - _kCarouselHeight + _kSlidingSheetCornerRadius;
    final finalSnapPoint = size.height - kToolbarHeight - padding.top;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade200,
      body: SlidingSheet(
        cornerRadius: _kSlidingSheetCornerRadius,
        duration: const Duration(milliseconds: 500),
        snapSpec: SnapSpec(
          snap: true,
          snappings: [snapPoint, finalSnapPoint],
          positioning: SnapPositioning.pixelOffset,
        ),
        body: buildBody(),
        builder: buildChild,
        headerBuilder: buildHeader,
        footerBuilder: buildFooter,
      ),
    );
  }

  buildBody() {
    return CarouselSlider(
      options: CarouselOptions(
        height: _kCarouselHeight,
        viewportFraction: 1.0,
      ),
      items: imgList
          .map(
            (item) => Container(
              child: Image.network(
                item,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buildChild(context, state) {
    final padding = MediaQuery.of(context).padding;
    final availableHeight = MediaQuery.of(context).size.height -
        padding.top -
        padding.bottom -
        _kHeaderHeight -
        _kFooterHeight -
        kToolbarHeight;

    return Container(
        color: Colors.white,
        height: availableHeight,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                _About(),
                Text('Teste'),
                Text('Teste'),
              ]),
            ),
          ],
        ));
  }

  Widget buildHeader(context, state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          height: _kHeaderHeight,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
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
                              style:
                                  DefaultTextStyle.of(context).style.copyWith(
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
            ],
          ),
        ),
        Container(
          child: TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: "Sobre"),
              Tab(text: "Cardápio"),
              Tab(text: "Comentários"),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFooter(BuildContext context, state) {
    final padding = MediaQuery.of(context).padding;

    return Container(
      alignment: Alignment.center,
      height: _kFooterHeight + padding.bottom,
      width: double.infinity,
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
          16.0,
          16.0,
          16.0,
          max(padding.bottom, 16.0),
        ),
        child: Row(
          children: [
            // PhoneButtonWidget(),
            SizedBox(width: 16.0),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
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
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: 27.0),
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
        SizedBox(height: 27.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Maecenas eu enim enim. Suspendisse vestibulum purus in ultricies dictum. Mauris ipsum sem, dictum bibendum sed elementum ut, convallis et magna. Curabitur tincidunt, tortor eget pharetra dictum, turpis purus ultricies turpis, ac iaculis dui ut ligula. \nDictum bibendum sed elementum ut, convallis et magna. Curabitur tincidunt, tortor eget pharetra dictum, turpis purus ultricies turpis, ac iaculis dui ut ligula.',
          ),
        ),
        SizedBox(height: 12.0),
        SizedBox(
          width: double.infinity,
          height: 300.0,
          child: GoogleMap(
            initialCameraPosition: _kInitialPosition,
            liteModeEnabled: false,
            markers: {
              Marker(
                markerId: MarkerId("marker_1"),
                position: _kMapCenter,
              )
            },
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
          ),
        ),
      ],
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
