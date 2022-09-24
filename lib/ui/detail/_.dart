// import 'package:boilerplate/constants/assets.dart';
// import 'package:boilerplate/constants/dimens.dart';
// import 'package:boilerplate/widgets/fallback_avatar_widget.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_blurhash/flutter_blurhash.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

// final nestedScrollViewKey = GlobalKey();

// class DetailScreen extends StatefulWidget {
//   const DetailScreen({Key? key}) : super(key: key);

//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return DefaultTabController(
// //       length: 3,
// //       child: Scaffold(
// //         body: NestedScrollView(
// //           key: nestedScrollViewKey,
// //           headerSliverBuilder: ((context, innerBoxIsScrolled) {
// //             return <Widget>[
// //               RestaurantAppBar(),
// //               SliverToBoxAdapter(
// //                 child: RestaurantInfo(),
// //               ),
// //               SliverPersistentHeader(
// //                 delegate: _SliverAppBarDelegate(
// //                   TabBar(
// //                     labelColor: Theme.of(context).colorScheme.primary,
// //                     unselectedLabelColor: Colors.grey,
// //                     indicatorColor: Colors.orange,
// //                     tabs: [
// //                       Tab(text: "Menu"),
// //                       Tab(text: "About"),
// //                       Tab(text: "Contact"),
// //                     ],
// //                   ),
// //                 ),
// //                 pinned: true,
// //               )
// //             ];
// //           }),
// //           body: TabBarView(
// //             children: <Widget>[
// //               _About(),
// //               _Menu(),
// //               _CommentsList(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// }

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate(this._tabBar);

//   final TabBar _tabBar;

//   @override
//   double get minExtent => _tabBar.preferredSize.height;
//   @override
//   double get maxExtent => _tabBar.preferredSize.height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return new Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.25),
//             blurRadius: 6,
//             offset: Offset(0, 6), // changes position of shadow
//           ),
//         ],
//       ),
//       child: _tabBar,
//     );
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }

// class RestaurantInfo extends StatelessWidget {
//   const RestaurantInfo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16.0,
//               vertical: 12.0,
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Flexible(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Churrascaria Churra Pinheiro de Ouro',
//                         maxLines: 2,
//                         style: Theme.of(context).textTheme.headline6,
//                       ),
//                       RichText(
//                         text: TextSpan(
//                           text: 'Aberto ',
//                           style: DefaultTextStyle.of(context).style.copyWith(
//                                 color: Colors.green,
//                               ),
//                           children: <TextSpan>[
//                             TextSpan(
//                               text: '- Fecha às 22:00',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Chip(
//                   label: Text('10%', style: TextStyle(color: Colors.white)),
//                   backgroundColor: Theme.of(context).colorScheme.primary,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RestaurantAppBar extends StatelessWidget {
//   const RestaurantAppBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       pinned: true,
//       elevation: 0.0,
//       expandedHeight: 200.0,
//       flexibleSpace: FlexibleSpaceBar(
//         background: CarouselSlider(
//           options: CarouselOptions(),
//           items: imgList
//               .map(
//                 (img) => SizedBox(
//                   width: double.infinity,
//                   child: CachedNetworkImage(
//                     placeholder: (context, url) =>
//                         BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
//                     imageUrl:
//                         'https://cdn.pixabay.com/photo/2020/04/05/10/34/raven-5005534_1280.jpg',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//       ),
//       leading: Padding(
//         padding: const EdgeInsets.only(left: 16.0),
//         child: CircleAvatar(
//           backgroundColor: Colors.white,
//           child: Icon(
//             MdiIcons.close,
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//       ),
//       actions: [
//         CircleAvatar(
//           backgroundColor: Colors.white,
//           child: Icon(
//             MdiIcons.shareVariant,
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: CircleAvatar(
//             backgroundColor: Colors.white,
//             child: Icon(
//               MdiIcons.heart,
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// class _About extends StatefulWidget {
//   _About({Key? key}) : super(key: key);

//   @override
//   State<_About> createState() => _AboutState();
// }

// class _AboutState extends State<_About>
//     with AutomaticKeepAliveClientMixin<_About> {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Container(
//       color: Colors.white,
//       child: ListView(
//         padding: const EdgeInsets.all(0),
//         children: [
//           SizedBox(height: Dimens.dp24.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Row(
//                 children: [
//                   SvgPicture.asset(Assets.icLogo, height: 32.0, width: 32.0),
//                   SizedBox(width: 4.0),
//                   Text('pay', style: TextStyle(fontSize: 24.0))
//                 ],
//               ),
//               _ItemWidget(
//                 iconColor: Colors.yellow.shade700,
//                 iconData: MdiIcons.star,
//                 title: '4.9',
//                 caption: 'Avaliação',
//               ),
//               _ItemWidget(
//                 iconColor: Theme.of(context).colorScheme.primary,
//                 iconData: MdiIcons.mapMarker,
//                 title: '14 Km',
//                 caption: 'Distância',
//               )
//             ],
//           ),
//           SizedBox(height: Dimens.dp24.h),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: Dimens.dp18.w),
//             child: Text(
//               'Maecenas eu enim enim. Suspendisse vestibulum purus in ultricies dictum. Mauris ipsum sem, dictum bibendum sed elementum ut, convallis et magna. Curabitur tincidunt, tortor eget pharetra dictum, turpis purus ultricies turpis, ac iaculis dui ut ligula. \nDictum bibendum sed elementum ut, convallis et magna. Curabitur tincidunt, tortor eget pharetra dictum, turpis purus ultricies turpis, ac iaculis dui ut ligula.',
//             ),
//           ),
//           SizedBox(height: Dimens.dp12.h),
//           SizedBox(
//             width: double.infinity,
//             height: 300.0.h,
//             child: GoogleMap(
//               initialCameraPosition:
//                   CameraPosition(target: LatLng(-33.852, 151.211), zoom: 11.0),
//               markers: {
//                 Marker(
//                   markerId: MarkerId("marker_1"),
//                   position: LatLng(-33.852, 151.211),
//                 )
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

// class _Menu extends StatefulWidget {
//   const _Menu({Key? key}) : super(key: key);

//   @override
//   State<_Menu> createState() => _MenuState();
// }

// class _MenuState extends State<_Menu>
//     with AutomaticKeepAliveClientMixin<_Menu> {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return CachedNetworkImage(
//       imageUrl:
//           'https://bardaivabh.com.br/wp-content/uploads/2021/06/Card%C3%A1pio-Bar-da-Iva-2-1.png',
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

// class _CommentsList extends StatefulWidget {
//   const _CommentsList({Key? key}) : super(key: key);

//   @override
//   State<_CommentsList> createState() => _CommentsListState();
// }

// class _CommentsListState extends State<_CommentsList>
//     with AutomaticKeepAliveClientMixin<_CommentsList> {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Container(
//       color: Colors.white,
//       child: ListView.separated(
//         padding: const EdgeInsets.symmetric(horizontal: Dimens.dp18),
//         itemCount: 6,
//         itemBuilder: (_, int i) {
//           var commentWidget = _Comment(
//             userAvatarUrl: 'https://randomuser.me/api/portraits/women/57.jpg',
//             userName: 'Aline',
//             userRating: 3.9,
//             userAnnotation:
//                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
//             createdAt: DateTime.parse("2021-10-10"),
//           );

//           if (i == 0) {
//             return Column(
//               children: [
//                 SizedBox(height: Dimens.dp24.h),
//                 commentWidget,
//               ],
//             );
//           } else if (i == 5) {
//             return Column(
//               children: [
//                 commentWidget,
//                 SizedBox(height: Dimens.dp12.h),
//                 TextButton(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('mais comentários'),
//                       Icon(MdiIcons.chevronDown),
//                     ],
//                   ),
//                   onPressed: () {},
//                 ),
//                 SizedBox(height: Dimens.dp12.h),
//               ],
//             );
//           }

//           return commentWidget;
//         },
//         separatorBuilder: (_, __) => Padding(
//           padding: const EdgeInsets.symmetric(vertical: Dimens.dp18),
//           child: Divider(),
//         ),
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }

// class _Comment extends StatelessWidget {
//   final String userName;
//   final String userAvatarUrl;
//   final double userRating;
//   final String userAnnotation;
//   final DateTime createdAt;

//   const _Comment(
//       {Key? key,
//       required this.userName,
//       required this.userAvatarUrl,
//       required this.userRating,
//       required this.userAnnotation,
//       required this.createdAt})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _CommentUserDetails(
//           userAvatarUrl: userAvatarUrl,
//           userName: userName,
//           userRating: userRating,
//           createdAt: createdAt,
//         ),
//         SizedBox(height: Dimens.dp12.h),
//         Text(
//           userAnnotation,
//           style: TextStyle(color: Colors.grey),
//           textAlign: TextAlign.justify,
//         ),
//       ],
//     );
//   }
// }

// class _CommentUserDetails extends StatelessWidget {
//   final String userName;
//   final String userAvatarUrl;
//   final double userRating;
//   final DateTime createdAt;

//   const _CommentUserDetails(
//       {Key? key,
//       required this.userName,
//       required this.userAvatarUrl,
//       required this.userRating,
//       required this.createdAt})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         FallBackAvatarWidget(
//           imageUrl: userAvatarUrl,
//           initials: "FA",
//           textStyle: TextStyle(),
//           circleBackground: Colors.grey.shade400,
//           radius: 27.0,
//         ),
//         SizedBox(width: Dimens.dp8),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 userName,
//                 style: Theme.of(context).textTheme.headline6,
//               ),
//               Text(
//                 DateFormat.yMMMd(context.locale.toString()).format(createdAt),
//                 style: Theme.of(context).textTheme.caption,
//               ),
//             ],
//           ),
//         ),
//         SizedBox(width: Dimens.dp8),
//         Row(
//           children: [
//             Icon(
//               MdiIcons.star,
//               color: Colors.yellow.shade700,
//             ),
//             Text(
//               NumberFormat("###.0#", context.locale.toString())
//                   .format(userRating),
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

// class _ItemWidget extends StatelessWidget {
//   final Color iconColor;
//   final IconData iconData;
//   final String title;
//   final String caption;

//   const _ItemWidget({
//     Key? key,
//     required this.iconColor,
//     required this.iconData,
//     required this.title,
//     required this.caption,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           iconData,
//           color: iconColor,
//           size: 32.0,
//         ),
//         SizedBox(width: 4.0),
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title),
//             Text(
//               caption,
//               style: Theme.of(context).textTheme.caption,
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
