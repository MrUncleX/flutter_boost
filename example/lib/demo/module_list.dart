import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'lottie_header_bear.dart';

class ModuleList extends StatefulWidget {
  ModuleList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DemoState();
  }
}
class DemoState extends State<ModuleList> with TickerProviderStateMixin, PageVisibilityObserver {

  final RefreshController refreshController = RefreshController(initialRefresh: false);
  late AnimationController sortAnimationControl ;

  @override
  void initState() {
    super.initState();
    sortAnimationControl = AnimationController(
      vsync: this,
    );
    // sortAnimationControl.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     if (sortAnimationControl.view.value == 1.0) {
    //       sortAnimationControl.reset();
    //     }
    //   }
    // });

  }
  @override
  void onBackground() {
    super.onBackground();
    print("LifecycleTestPage - onBackground");
  }

  @override
  void onForeground() {
    super.onForeground();
    print("LifecycleTestPage - onForeground");
  }

  @override
  void onPageHide() {
    super.onPageHide();
    print("LifecycleTestPage - onPageHide");
    sortAnimationControl.animateTo(1,
        duration: const Duration(milliseconds: 2000));
  }

  @override
  void onPageShow() {
    super.onPageShow();
    print("LifecycleTestPage - onPageShow");
    SystemUiOverlayStyle sys = const SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.light,statusBarBrightness: Brightness.light,);
    SystemChrome.setSystemUIOverlayStyle(sys);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ///注册监听器
    PageVisibilityBinding.instance.addObserver(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    ///移除监听器
    PageVisibilityBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    late AnimationController textController;
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: Scaffold(
          backgroundColor:  const Color(0xFFF8F8F8),
          appBar: AppBar(
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shadowColor: Colors.transparent,
            title: const Text("hidePage关闭dialog"),
          ),
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: refreshController,
            header: const LottieHeaderBear(height: 74),
            child: CustomScrollView(

              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, i) => TextButton(onPressed: () {
                            // showDialog();
                            sortAnimationControl.animateTo(0.5,
                                duration: const Duration(milliseconds: 2000));
                          },
                    child:
                    RotationTransition(
                      alignment: Alignment.center,
                      turns: i==0?sortAnimationControl:AnimationController(vsync: this),
                      child:  Text("点我执行动画 item$i"),
                    ),

                ),
                      childCount: 99,
                    )),
              ],
            ),
          )),
    );
  }
}
