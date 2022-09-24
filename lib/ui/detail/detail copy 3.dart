import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/ui/detail/detail%20copy.dart';
import 'package:boilerplate/widgets/fallback_avatar_widget.dart';
import 'package:boilerplate/widgets/phone_button_widget.dart';
import 'package:boilerplate/widgets/size_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
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

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Size _footerSize = Size(0, 0);
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final childSize = 1 -
        ((kCarouselHeight - kBottomSheetCornerRadius) /
            MediaQuery.of(context).size.height);
    final maxChildSize = 1 -
        ((kToolbarHeight + MediaQuery.of(context).padding.top) /
            MediaQuery.of(context).size.height);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          _buildCarousel(),
          _buildScrollableSheet(childSize, maxChildSize)
        ],
      ),
      bottomSheet: SizeWidget(
        child: _DetailBottomSheet(),
        onChange: (Size size) {
          setState(() {
            _footerSize = size;
          });
        },
      ),
    );
  }

  Stack _buildCarousel() {
    return Stack(
      children: [
        _buildCarouselSlider(),
        _buildCarouselPagination(),
        _buildCarouselOverlay()
      ],
    );
  }

  CarouselSlider _buildCarouselSlider() {
    return CarouselSlider(
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
          .map((img) => SizedBox(
                width: double.infinity,
                child: CachedNetworkImage(
                  placeholder: (context, url) => const AspectRatio(
                    aspectRatio: 1.6,
                    child: BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                  ),
                  imageUrl:
                      'https://cdn.pixabay.com/photo/2020/04/05/10/34/raven-5005534_1280.jpg',
                  fit: BoxFit.cover,
                ),
              ))
          .toList(),
    );
  }

  Positioned _buildCarouselPagination() {
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

  Positioned _buildCarouselOverlay() {
    return Positioned.fill(
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
    ));
  }

  DraggableScrollableSheet _buildScrollableSheet(
      double childSize, double maxChildSize) {
    return DraggableScrollableSheet(
      initialChildSize: childSize,
      maxChildSize: maxChildSize,
      minChildSize: childSize,
      builder: (context, scrollController) => DefaultTabController(
        length: 3,
        child: _buildNestedScrollView(scrollController),
      ),
    );
  }

  CustomScrollView _buildNestedScrollView(ScrollController scrollController) {
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      controller: scrollController,
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          primary: false,
          toolbarHeight: kToolbarHeight * 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(kBottomSheetCornerRadius),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(MdiIcons.heart),
              iconSize: 32.0,
            )
          ],
          actionsIconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Restaurante Cha Cha',
                  style: TextStyle(
                    color: Colors.black,
                  ),
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
          bottom: TabBar(
            indicatorColor: Colors.orange,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Sobre"),
              Tab(text: "Cardápio"),
              Tab(text: "Comentários"),
            ],
          ),
        ),
        SliverFillRemaining(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.fromLTRB(0, 0, 0, _footerSize.height),
            child: TabBarView(
              children: [
                _About(scrollController: scrollController),
                _Menu(scrollController: scrollController),
                _CommentsList(scrollController: scrollController),
              ],
            ),
          ),
        )
      ],
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
  final ScrollController scrollController;

  _About({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(0),
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
    );
  }
}

class _Menu extends StatelessWidget {
  final ScrollController scrollController;

  const _Menu({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(0),
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://bardaivabh.com.br/wp-content/uploads/2021/06/Card%C3%A1pio-Bar-da-Iva-2-1.png',
        ),
      ],
    );
  }
}

class _CommentsList extends StatelessWidget {
  final ScrollController scrollController;

  const _CommentsList({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.dp18),
      itemCount: 3,
      itemBuilder: (_, int i) {
        var commentWidget = _Comment(
          userAvatarUrl: 'https://randomuser.me/api/portraits/women/57.jpg',
          userName: 'Aline',
          userRating: 3.9,
          userAnnotation:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          createdAt: DateTime.parse("2021-10-10"),
        );

        if (i == 0) {
          return Column(
            children: [
              SizedBox(height: Dimens.dp24.h),
              commentWidget,
            ],
          );
        } else if (i == 2) {
          return Column(
            children: [
              commentWidget,
              SizedBox(height: Dimens.dp12.h),
              TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('mais comentários'),
                    Icon(MdiIcons.chevronDown),
                  ],
                ),
                onPressed: () {},
              ),
              SizedBox(height: Dimens.dp12.h),
            ],
          );
        }

        return commentWidget;
      },
      separatorBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.dp18),
        child: Divider(),
      ),
    );
  }
}

class _Comment extends StatelessWidget {
  final String userName;
  final String userAvatarUrl;
  final double userRating;
  final String userAnnotation;
  final DateTime createdAt;

  const _Comment(
      {Key? key,
      required this.userName,
      required this.userAvatarUrl,
      required this.userRating,
      required this.userAnnotation,
      required this.createdAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CommentUserDetails(
          userAvatarUrl: userAvatarUrl,
          userName: userName,
          userRating: userRating,
          createdAt: createdAt,
        ),
        SizedBox(height: Dimens.dp12.h),
        Text(
          userAnnotation,
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class _CommentUserDetails extends StatelessWidget {
  final String userName;
  final String userAvatarUrl;
  final double userRating;
  final DateTime createdAt;

  const _CommentUserDetails(
      {Key? key,
      required this.userName,
      required this.userAvatarUrl,
      required this.userRating,
      required this.createdAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FallBackAvatarWidget(
          imageUrl: userAvatarUrl,
          initials: "FA",
          textStyle: TextStyle(),
          circleBackground: Colors.grey.shade400,
          radius: 27.0,
        ),
        SizedBox(width: Dimens.dp8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userName,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                DateFormat.yMMMd(context.locale.toString()).format(createdAt),
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
        SizedBox(width: Dimens.dp8),
        Row(
          children: [
            Icon(
              MdiIcons.star,
              color: Colors.yellow.shade700,
            ),
            Text(
              NumberFormat("###.0#", context.locale.toString())
                  .format(userRating),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        )
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
