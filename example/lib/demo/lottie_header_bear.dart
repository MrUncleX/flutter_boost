import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class LottieHeaderBear extends RefreshIndicator {
  const LottieHeaderBear({Key? key, required double height}) : super(key: key, height: height);

  @override
  State createState() {
    return LottieHeaderBearState();
  }
}

class LottieHeaderBearState extends RefreshIndicatorState<LottieHeaderBear> {
  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    String showText;
    if (mode == RefreshStatus.idle) { // 下拉刷新
      showText = "下拉刷新";
    }
    else if (mode == RefreshStatus.canRefresh) { // 释放刷新
      showText = "释放刷新";
    }
    else if (mode == RefreshStatus.refreshing) { // 正在加载...
      showText = "正在加载...";
    }
    else if (mode == RefreshStatus.completed) { // 刷新完成
      showText = "刷新完成";
    }
    else {
      showText = "刷新失败";
    }

    return Container(
      color: Color.fromARGB(255, 30, 80, 40),
      height: widget.height,
      child: Center(
          child: Column(
        children: [
          const SizedBox(height: 18),
          // SizedBox(height: 20, child: Lottie.asset('asset/ft_animation_bear.json')),
          const SizedBox(height: 3),
          Text(showText, style: const TextStyle(color: Color(0xffcccccc), fontSize: 13)),
        ],
      )),
    );
  }
}