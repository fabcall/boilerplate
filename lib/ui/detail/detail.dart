import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/widgets/fallback_avatar_widget.dart';
import 'package:boilerplate/widgets/phone_button_widget.dart';
import 'package:boilerplate/widgets/size_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:url_launcher/url_launcher.dart';

const _tabs = <String>['Sobre', 'Menu', 'Comentários'];
const _list = [
  {
    'url':
        'https://media-cdn.tripadvisor.com/media/photo-m/1280/1a/b8/44/98/london-stock.jpg',
    'blurHash': 'LBDt;KwbMys:0#OYx[W;Z\$}?xt\$%',
  },
  {
    'url':
        'https://media-cdn.tripadvisor.com/media/photo-m/1280/1a/b8/46/6d/london-stock.jpg',
    'blurHash': 'LBE^_:?GF3R-1Ox]}r-oMxsR9^Rk'
  }
];
const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(-33.852, 151.211), zoom: 11.0);
const LatLng _kMapCenter = LatLng(-33.852, 151.211);

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Size _footerSize = Size(0, 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabBar = TabBar(
      labelColor: Theme.of(context).colorScheme.primary,
      unselectedLabelColor: Colors.grey,
      indicator: MaterialIndicator(
        color: Colors.orange,
        horizontalPadding: 12.0,
      ),
      tabs: _tabs.map((String name) => Tab(text: name)).toList(),
    );
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        bottomSheet: SizeWidget(
          child: _DetailBottomSheet(),
          onChange: (Size size) {
            setState(() {
              _footerSize = size;
            });
          },
        ),
        extendBodyBehindAppBar: true,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: MultiSliver(
                    pushPinnedChildren: true,
                    children: [
                      SliverAppBar(
                        pinned: true,
                        elevation: 0.0,
                        expandedHeight: 200.0,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildCarousel(),
                            ],
                          ),
                        ),
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Ionicons.close_outline,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Ionicons.heart_outline,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Restaurante Cha Cha',
                                maxLines: 2,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              RichText(
                                maxLines: 1,
                                text: TextSpan(
                                  text: 'Aberto ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
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
                      ),
                      SliverPersistentHeader(
                        floating: true,
                        pinned: true,
                        delegate: _SliverTabBarDelegate(
                          child: _tabBar,
                          forceElevated: innerBoxIsScrolled,
                        ),
                      ),
                    ],
                  )),
            ];
          },
          body: Container(
            padding: EdgeInsets.only(bottom: _footerSize.height),
            child: TabBarView(
              children: [
                About(),
                Menu(),
                CommentsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Stack(
      children: [
        _buildCarouselSlider(),
        _buildCarouselPagination(),
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
        viewportFraction: 1.0,
      ),
      items: _list
          .map(
            (image) => CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: image['url']!,
              placeholder: (context, url) => BlurHash(
                hash: image['blurHash']!,
              ),
              width: double.infinity,
            ),
          )
          .toList(),
    );
  }

  Widget _buildCarouselPagination() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          //you can get rid of below line also
          borderRadius: BorderRadius.circular(10.0),
          //below line is for rectangular shape
          shape: BoxShape.rectangle,
          //you can change opacity with color here(I used black) for rect
          color: Colors.black.withOpacity(0.5),
          //I added some shadow, but you can remove boxShadow also.
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(5.0, 5.0),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Text(
              "${_currentIndex + 1} / ${_list.length}",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate({required this.child, required this.forceElevated});

  final TabBar child;
  final bool forceElevated;

  @override
  double get minExtent => child.preferredSize.height;
  @override
  double get maxExtent => child.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AnimatedContainer(
          // Define how long the animation should take.
          duration: const Duration(milliseconds: 300),
          // Provide an optional curve to make the animation feel smoother.
          curve: Curves.fastOutSlowIn,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1.0)),
            boxShadow: forceElevated
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ]
                : null,
          ),
        ),
        child,
      ],
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    if (oldDelegate.forceElevated != forceElevated ||
        oldDelegate.child != child) {
      return true;
    }
    return false;
  }
}

class _DetailBottomSheet extends StatelessWidget {
  const _DetailBottomSheet({
    Key? key,
  }) : super(key: key);

  void launchMap({String lat = "47.6", String long = "-122.3"}) async {
    final mapSchema = 'geo:$lat,$long';
    final mapUrl = Uri.parse(mapSchema);
    if (await canLaunchUrl(mapUrl)) {
      await launchUrl(mapUrl);
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
          12.0,
          12.0,
          12.0,
          MediaQuery.of(context).padding.bottom + 12.0,
        ),
        child: Row(
          children: [
            PhoneButtonWidget(phoneNumber: "51996196622"),
            SizedBox(width: 12.0),
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

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        key: PageStorageKey<String>('Details-About_ScrollView'),
        slivers: [
          SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icLogo,
                          height: 32.0,
                          width: 32.0,
                        ),
                        SizedBox(width: 4.0),
                        Text('pay', style: TextStyle(fontSize: 24.0))
                      ],
                    ),
                    _ItemWidget(
                      iconColor: Colors.yellow.shade700,
                      iconData: Ionicons.star,
                      title: '4.9',
                      caption: 'Avaliação',
                    ),
                    _ItemWidget(
                      iconColor: Theme.of(context).colorScheme.primary,
                      iconData: Ionicons.location,
                      title: '14 Km',
                      caption: 'Distância',
                    )
                  ],
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    'Maecenas eu enim enim. Suspendisse vestibulum purus in ultricies dictum. Mauris ipsum sem, dictum bibendum sed elementum ut, convallis et magna. Curabitur tincidunt, tortor eget pharetra dictum, turpis purus ultricies turpis, ac iaculis dui ut ligula. \nDictum bibendum sed elementum ut, convallis et magna. Curabitur tincidunt, tortor eget pharetra dictum, turpis purus ultricies turpis, ac iaculis dui ut ligula.',
                  ),
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 300.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: GoogleMap(
                        initialCameraPosition: _kInitialPosition,
                        scrollGesturesEnabled: false,
                        markers: {
                          Marker(
                            markerId: MarkerId("marker_1"),
                            position: _kMapCenter,
                          )
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey<String>('Details-Menu_ScrollView'),
      slivers: [
        SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
        SliverToBoxAdapter(
          child: Image.network(
            'https://edit.org/photos/img/blog/wrm-menu-de-casamento-editavel.jpg-840.jpg',
          ),
        ),
      ],
    );
  }
}

class CommentsList extends StatelessWidget {
  const CommentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        key: PageStorageKey<String>('Details-CommentsList_ScrollView'),
        slivers: [
          SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverPadding(
            padding: const EdgeInsets.all(18.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    children: [
                      _Comment(
                        userAvatarUrl:
                            'https://randomuser.me/api/portraits/women/57.jpg',
                        userName: 'Aline',
                        userRating: 3.9,
                        userAnnotation:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        createdAt: DateTime.parse("2021-10-10"),
                      ),
                      if (index != 4)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: Divider(),
                        ),
                    ],
                  );
                },
                childCount: 5,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(18.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('mais comentários'),
                        Icon(Ionicons.chevron_down_outline),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
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
        SizedBox(height: 12.0),
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
        SizedBox(width: 8.0),
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
        SizedBox(width: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              Ionicons.star,
              color: Colors.yellow.shade700,
            ),
            SizedBox(width: 4.0),
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
