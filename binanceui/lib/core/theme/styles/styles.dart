library styles;

import 'package:binanceui/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

export 'package:flutter/material.dart' 
show Color, TextStyle, FontStyle, FontWeight, TextOverflow;

part 'colors.dart';
part 'typography.dart';

///? SCREENUTIL CONFIG IMPLEMENTATIONS
/// [.r] is used for radius of a circle and EdgeInsets.
/// Example: EdgeInsets.only(left: 8, right: 8).r or EdgeInsets.only(left: 8.r, right: 8.r)
/// [.h] for height
/// [.w] for width
/// [.sp] for text font sizes
/// [.sw] for screen width
/// [.sh] for screen height
/// These are the main ScreenUtil extensions used in this project.
