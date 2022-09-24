import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/widgets/fallback_avatar_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const _tabs = <String>['Sobre', 'Menu', 'Comentários'];
const _list = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'
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
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabBar = TabBar(
      indicatorColor: Colors.orange,
      labelColor: Theme.of(context).colorScheme.primary,
      unselectedLabelColor: Colors.grey,
      tabs: _tabs.map((String name) => Tab(text: name)).toList(),
    );
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: false,
                  expandedHeight: 320.0,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildCarousel(),
                        Container(
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
                      ],
                    ),
                  ),
                  bottom: _tabBar,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          MdiIcons.close,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          MdiIcons.heart,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              About(),
              Menu(),
              CommentsList(),
            ],
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
            (img) => CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  'https://cdn.pixabay.com/photo/2020/04/05/10/34/raven-5005534_1280.jpg',
              placeholder: (context, url) => BlurHash(
                hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
              ),
              width: double.infinity,
            ),
          )
          .toList(),
    );
  }

  Widget _buildCarouselPagination() {
    return Positioned(
      top: 180.0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _list.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.white,
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
}

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        key: PageStorageKey<String>('About'),
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
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
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
      key: PageStorageKey<String>('Menu'),
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
        key: PageStorageKey<String>('CommentsList'),
        slivers: [
          SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverPadding(
            padding: const EdgeInsets.all(18.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final commentWidget = Column(
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
                      if (index != 5)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: Divider(),
                        ),
                    ],
                  );

                  if (index < 5) {
                    return commentWidget;
                  }

                  return Column(
                    children: [
                      commentWidget,
                      SizedBox(height: 12.0),
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
                      SizedBox(height: 12.0),
                    ],
                  );
                },
                childCount: 6,
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
