library flutter_horizontal_vertical_tabview;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_bloc.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_state.dart';

enum IndicatorSide { start, end }

class VerticalTabView extends StatefulWidget {
  final Function(int tabIndex)? onSelect;
  final Color? backgroundColor;
  final TextStyle tabTextStyle;
  final List<Widget> contents;
  final double tabsWidth;
  final List<Tab> tabs;

  final TextStyle selectedTabTextStyle;
  final int initialIndex;
  final double indicatorWidth;
  final IndicatorSide indicatorSide;

  final TextDirection direction;
  final bool disabledChangePageFromContentView;
  final Axis contentScrollAxis;
  final Color selectedTabBackgroundColor;
  final Color tabBackgroundColor;
  final Duration changePageDuration;
  final Curve changePageCurve;

  const VerticalTabView({
    Key? key,
    required this.tabs,
    required this.contents,
    this.backgroundColor,
    this.tabTextStyle =
        const TextStyle(color: Color.fromARGB(96, 155, 0, 0), fontSize: 13),
    this.tabsWidth = 90,
    this.indicatorWidth = 3,
    this.indicatorSide = IndicatorSide.start,
    this.initialIndex = 0,
    this.direction = TextDirection.ltr,
    this.disabledChangePageFromContentView = false,
    this.contentScrollAxis = Axis.vertical,
    this.selectedTabBackgroundColor = const Color(0xffFFEDEC),
    this.tabBackgroundColor = Colors.white,
    this.selectedTabTextStyle =
        const TextStyle(color: Colors.black, fontSize: 13),
    this.changePageCurve = Curves.easeInOut,
    this.changePageDuration = const Duration(milliseconds: 300),
    this.onSelect,
  }) : super(key: key);

  @override
  _VerticalTabViewState createState() => _VerticalTabViewState();
}

class _VerticalTabViewState extends State<VerticalTabView>
    with TickerProviderStateMixin {
  late int _selectedIndex;
  late bool _changePageByTapView;

  late Animation<double> animation;
  late Animation<RelativeRect> rectAnimation;

  PageController pageController = PageController();

  List<AnimationController> animationControllers = [];

  ScrollPhysics pageScrollPhysics = const AlwaysScrollableScrollPhysics();

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    _changePageByTapView = false;

    for (int i = 0; i < widget.tabs.length; i++) {
      animationControllers.add(AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ));
    }
    if (widget.disabledChangePageFromContentView == true) {
      pageScrollPhysics = const NeverScrollableScrollPhysics();
    }

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(widget.initialIndex);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RewardPointsBloc, RewardPointsState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is RewardPointsSuccess) {
          if (state.changeTabIndex?['index'] != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              pageController.jumpToPage(state.changeTabIndex?['index']??0);
               _selectTab(state.changeTabIndex?['index']??0);
              setState(() {
                
              });
            });
          }
        }
      },
      child: Directionality(
        textDirection: widget.direction,
        child: Container(
          color: widget.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xffCCCDCD),
                          width: 1.0,
                        ),
                      ),
                      width: widget.tabsWidth,
                      child: ListView.builder(
                        itemCount: widget.tabs.length,
                        itemBuilder: (context, index) {
                          Tab tab = widget.tabs[index];

                          Alignment alignment = Alignment.centerLeft;
                          if (widget.direction == TextDirection.rtl) {
                            alignment = Alignment.centerRight;
                          }

                          Widget child;
                          if (tab.child != null) {
                            child = tab.child!;
                          } else {
                            child = SizedBox(
                              width: widget.tabsWidth,
                              child: Text(
                                tab.text!,
                                softWrap: true,
                                style: _selectedIndex == index
                                    ? widget.selectedTabTextStyle
                                    : widget.tabTextStyle,
                              ),
                            );
                          }

                          Color itemBGColor = widget.tabBackgroundColor;
                          if (_selectedIndex == index) {
                            itemBGColor = widget.selectedTabBackgroundColor;
                          }

                          late double? left, right;
                          if (widget.direction == TextDirection.rtl) {
                            left = (widget.indicatorSide == IndicatorSide.end)
                                ? 0
                                : null;
                            right =
                                (widget.indicatorSide == IndicatorSide.start)
                                    ? 0
                                    : null;
                          } else {
                            left = (widget.indicatorSide == IndicatorSide.start)
                                ? 0
                                : null;
                            right = (widget.indicatorSide == IndicatorSide.end)
                                ? 0
                                : null;
                          }

                          return Stack(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  _changePageByTapView = true;
                                  setState(() {
                                    _selectTab(index);
                                  });
                                  pageController.animateToPage(index,
                                      duration: widget.changePageDuration,
                                      curve: widget.changePageCurve);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: itemBGColor,
                                    border: const Border(
                                      bottom: BorderSide(
                                        color: Color(0xffCCCDCD),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  alignment: alignment,
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 16,
                                    bottom: 16,
                                  ),
                                  child: child,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        scrollDirection: widget.contentScrollAxis,
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          if (_changePageByTapView == false) {
                            _selectTab(index);
                          }
                          if (_selectedIndex == index) {
                            _changePageByTapView = false;
                          }
                          setState(() {});
                        },
                        controller: pageController,
                        itemCount: widget.contents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return widget.contents[index];
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectTab(index) {
    if (index == -1) return;

    _selectedIndex = index;
    for (AnimationController animationController in animationControllers) {
      animationController.reset();
    }
    animationControllers[index].forward();

    if (widget.onSelect != null) {
      widget.onSelect!(_selectedIndex);
    }
  }

  @override
  void dispose() {
    for (AnimationController animationController in animationControllers) {
      animationController.dispose();
    }
    super.dispose();
  }
}
