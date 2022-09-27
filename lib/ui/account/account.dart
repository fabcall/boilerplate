import 'package:boilerplate/constants/font_family.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

const _tabs = <String>['Pagamentos', 'Assinatura'];

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with AutomaticKeepAliveClientMixin<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  centerTitle: false,
                  title: Text(
                    'conta',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontFamily: FontFamily.comfortaa,
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -2.0,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize:
                        Size.fromHeight(_tabBar.preferredSize.height),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.shade300, width: 1.0),
                            ),
                          ),
                        ),
                        _tabBar,
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _PaymentsListScreen(),
              _PaymentsListScreen(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _PaymentsListScreen extends StatelessWidget {
  const _PaymentsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
