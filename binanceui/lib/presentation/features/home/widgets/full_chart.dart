import 'package:binanceui/core/theme/styles/styles.dart';
import 'package:binanceui/presentation/features/home/home_screen_viewmodel.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FullChart extends StatelessWidget {
  const FullChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBlackColor(context),
      appBar: AppBar(),
      body: Consumer<HomeScreenViewModel>(builder: (context, home, _) {
        return Column(
          children: [
            Expanded(
              child: Hero(
                tag: 'charts',
                child: Stack(
                  children: [
                    Candlesticks(
                      candles: home.candles,
                      onLoadMoreCandles: home.loadMoreCandles,
                      actions: [
                        ToolBarAction(child: const Text(""), onPressed: (){})
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.65,
                      left: 16.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Vol(BTC): ',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const TextSpan(
                                text: '65.254K ',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'Vol(USDT): ',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const TextSpan(
                                text: '2.418B',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
         ],
        );
      }),
    );
  }
}
