import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/models/category/category.dart';
import 'package:boilerplate/models/establishment/establishment.dart';
import 'package:boilerplate/ui/detail/detail.dart';
import 'package:boilerplate/widgets/establishment_list_item_widget.dart';
import 'package:boilerplate/widgets/search_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

final List<Category> categoriesList = [
  Category(id: 0, name: "Todos"),
  Category(id: 1, name: "Bares"),
  Category(id: 2, name: "Restaurantes"),
  Category(id: 3, name: "Pizzarias"),
  Category(id: 4, name: "Hamburguerias"),
  Category(id: 5, name: "Temakerias"),
];

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

final List<Establishment> establishmentsList = [
  Establishment(
      id: 1,
      thumb: 'https://randomuser.me/api/portraits/men/0.jpg',
      tradeName: 'Cha cha',
      fantasy: 'Cha cha',
      address: 'Rua Santo Antonio 754',
      city: 'São Leopoldo',
      district: 'Centro',
      state: 'RS',
      rating: 4.7,
      distance: 50,
      barpassPay: true),
  Establishment(
      id: 1,
      thumb: 'https://barpass-aplicativo.herokuapp.com/uploads/123.jpg',
      tradeName: 'Cha cha',
      fantasy: 'Cha cha',
      address: 'Rua Santo Antonio 754',
      city: 'São Leopoldo',
      district: 'Centro',
      state: 'RS',
      rating: 4.7,
      distance: 50,
      barpassPay: true),
  Establishment(
      id: 1,
      thumb: 'https://randomuser.me/api/portraits/men/0.jpg',
      tradeName: 'Cha cha',
      fantasy: 'Cha cha',
      address: 'Rua Santo Antonio 754',
      city: 'São Leopoldo',
      district: 'Centro',
      state: 'RS',
      rating: 4.7,
      distance: 50,
      barpassPay: true),
  Establishment(
      id: 1,
      thumb: 'https://barpass-aplicativo.herokuapp.com/uploads/123.jpg',
      tradeName: 'Cha cha',
      fantasy: 'Cha cha',
      address: 'Rua Santo Antonio 754',
      city: 'São Leopoldo',
      district: 'Centro',
      state: 'RS',
      rating: 4.7,
      distance: 50,
      barpassPay: true),
  Establishment(
      id: 1,
      thumb: 'https://randomuser.me/api/portraits/men/0.jpg',
      tradeName: 'Cha cha',
      fantasy: 'Cha cha',
      address: 'Rua Santo Antonio 754',
      city: 'São Leopoldo',
      district: 'Centro',
      state: 'RS',
      rating: 4.7,
      distance: 50,
      barpassPay: true),
  Establishment(
      id: 1,
      thumb: 'https://barpass-aplicativo.herokuapp.com/uploads/123.jpg',
      tradeName: 'Cha cha',
      fantasy: 'Cha cha',
      address: 'Rua Santo Antonio 754',
      city: 'São Leopoldo',
      district: 'Centro',
      state: 'RS',
      rating: 4.7,
      distance: 50,
      barpassPay: true),
  Establishment(
      id: 1,
      thumb: 'https://randomuser.me/api/portraits/men/0.jpg',
      tradeName: 'Cha cha',
      fantasy: 'Cha cha',
      address: 'Rua Santo Antonio 754',
      city: 'São Leopoldo',
      district: 'Centro',
      state: 'RS',
      rating: 4.7,
      distance: 50,
      barpassPay: true),
  Establishment(
      id: 1,
      thumb: 'https://barpass-aplicativo.herokuapp.com/uploads/123.jpg',
      tradeName: 'Cha cha',
      fantasy: 'Cha cha',
      address: 'Rua Santo Antonio 754',
      city: 'São Leopoldo',
      district: 'Centro',
      state: 'RS',
      rating: 4.7,
      distance: 50,
      barpassPay: true)
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  List<Establishment> establishments = [];
  bool isLoading = false;

  Future loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    establishments = List.of(establishmentsList);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            centerTitle: false,
            elevation: 0.0,
            title: RichText(
              text: TextSpan(
                text: 'b',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: FontFamily.comfortaa,
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -2.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'arpass',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: Container(
                child: Center(
                  child: SearchWidget(
                    hintText: 'Buscar estabelecimento',
                    onChanged: (value) {},
                    text: '',
                  ),
                ),
                color: Colors.white,
                height: kToolbarHeight,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {});
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
            ),
          ),
          SliverPersistentHeader(
            delegate: EstablishmentCategories(),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (isLoading) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                          vertical: 10.0,
                        ),
                        child: Row(
                          children: [
                            ShimmerWidget.circular(
                              width: 64,
                              height: 64,
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ShimmerWidget.rectangular(
                                      width: double.infinity,
                                      height: 12.0,
                                    ),
                                    const SizedBox(height: 4.0),
                                    ShimmerWidget.rectangular(
                                      width: double.infinity,
                                      height: 6.0,
                                    ),
                                    const SizedBox(height: 4.0),
                                    ShimmerWidget.rectangular(
                                      width: double.infinity,
                                      height: 6.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ShimmerWidget.circular(
                              width: 56,
                              height: 32,
                              shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  topLeft: Radius.circular(16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 20.0,
                      ),
                    ],
                  );
                }

                final establishment = establishmentsList[index];

                return EstablishmentListItem(
                  userAvatarUrl: establishment.thumb,
                  tradeName: establishment.tradeName,
                  address:
                      "${establishment.address}, ${establishment.district} - ${establishment.city} / ${establishment.state}",
                  rating: establishment.rating.toString(),
                  distance: "${establishment.distance.toString()} km",
                  barpassPay: establishment.barpassPay,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                );
              },
              childCount: establishmentsList.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class EstablishmentCategories extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AnimatedContainer(
      // Define how long the animation should take.
      duration: const Duration(milliseconds: 300),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ]
            : null,
      ),
      height: kToolbarHeight,
      child: _CategoriesList(),
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _CategoriesList extends StatefulWidget {
  const _CategoriesList({Key? key}) : super(key: key);

  @override
  State<_CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<_CategoriesList> {
  List<Category> categories = [];
  bool isLoading = false;

  Future loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    categories = List.of(categoriesList);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      addAutomaticKeepAlives: true,
      itemCount: categoriesList.length,
      itemBuilder: (context, i) {
        if (isLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.dp8.w),
            child: Center(
              child: ShimmerWidget.circular(
                width: 84,
                height: 32,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          );
        }
        final category = categoriesList[i];

        return _CategoryListItem(
          category: category,
          selected: i == 0,
        );
      },
      physics:
          isLoading ? NeverScrollableScrollPhysics() : ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
    );
  }
}

class _CategoryListItem extends StatelessWidget {
  const _CategoryListItem({
    Key? key,
    required this.category,
    required this.selected,
  }) : super(key: key);

  final Category category;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.dp8.w),
      child: ChoiceChip(
        backgroundColor: Colors.transparent,
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.dp8.w),
          child: Text(
            category.name,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
        selected: selected,
        selectedColor: Theme.of(context).colorScheme.primary,
        onSelected: (i) {},
        shape: StadiumBorder(
          side: BorderSide(
            color:
                selected ? Theme.of(context).colorScheme.primary : Colors.grey,
          ),
        ),
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget.rectangular({
    this.width = double.infinity,
    required this.height,
  }) : this.shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );

  final double width;
  final double height;
  final ShapeBorder shapeBorder;
}
