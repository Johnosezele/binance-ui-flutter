import 'package:binanceui/core/theme/styles/styles.dart';
import 'package:binanceui/presentation/features/home/home_screen_viewmodel.dart';
import 'package:binanceui/presentation/features/home/widgets/full_chart.dart';
import 'package:binanceui/presentation/features/home/widgets/time_selection_row.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({
    super.key,
  });

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(builder: (context, home, _) {
      return SizedBox(
        height: 591.h,
        child: Column(
          children: [
            Gap(18.h),
            const TimeSelectionRow(),
            Expanded(
              child: ListView(children: [
                Gap(18.h),
                const Divider(),
                Gap(17.67.h),
                Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) {
                            return const FullChart();
                          })),
                      child: SvgPicture.asset(
                        'assets/icons/expand.svg',
                        height: 20.h,
                        width: 20.w,
                      ),
                    )),
                Gap(12.67.h),
                Row(
                  children: [
                     Image.asset(
                      'assets/icons/dropdown.png',
                      width: 20.w,
                      height: 20.h,
                    ),
                    Gap(17.67.w),
                    const Text('BTC/USD'),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Gap(16.w),
                            RichText(
                                text: TextSpan(
                                    style: AppStyles.black12Regular.copyWith(
                                        color:
                                            AppColors.blackWhiteColor(context)),
                                    text: "O ",
                                    children: [
                                  TextSpan(
                                      text: "36,641.54",
                                      style: AppStyles.black12Regular.copyWith(
                                          color: AppColors.greenColor(context)))
                                ])),
                            Gap(16.w),
                            RichText(
                                text: TextSpan(
                                    style: AppStyles.black12Regular.copyWith(
                                        color:
                                            AppColors.blackWhiteColor(context)),
                                    text: "H ",
                                    children: [
                                  TextSpan(
                                      text: "36,641.54",
                                      style: AppStyles.black12Regular.copyWith(
                                          color: AppColors.greenColor(context)))
                                ])),
                            Gap(16.w),
                            RichText(
                                text: TextSpan(
                                    style: AppStyles.black12Regular.copyWith(
                                        color:
                                            AppColors.blackWhiteColor(context)),
                                    text: "L ",
                                    children: [
                                  TextSpan(
                                      text: "36,641.54",
                                      style: AppStyles.black12Regular.copyWith(
                                          color: AppColors.greenColor(context)))
                                ])),
                            Gap(16.w),
                            RichText(
                                text: TextSpan(
                                    style: AppStyles.black12Regular.copyWith(
                                        color:
                                            AppColors.blackWhiteColor(context)),
                                    text: "C ",
                                    children: [
                                  TextSpan(
                                      text: "36,641.54",
                                      style: AppStyles.black12Regular.copyWith(
                                          color: AppColors.greenColor(context)))
                                ])),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(12.67.h),
                SizedBox(
                  height: 409.h,
                  child: StreamBuilder(
                      stream: home.socket.channel?.stream,
                      builder: (context, snapshot) {
                        home.updateCandlesFromSnapshot(snapshot);
                        return Stack(
                          children: [
                            Hero(
                              tag: 'charts',
                              child: Candlesticks(
                                candles: home.candles,
                                onLoadMoreCandles: home.loadMoreCandles,
                              ),
                            ),
                            Positioned(
                              top: 280.h, // Fixed position from top
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
                        );
                      }),
                )
              ]),
            ),
          ],
        ),
      );
    });
  }
}
