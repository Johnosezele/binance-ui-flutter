import 'package:binanceui/core/utils/constants.dart';
import 'package:binanceui/models/model.dart';
import 'package:binanceui/services/socket.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:dio/dio.dart';
import 'package:simple_logger/simple_logger.dart';
import 'interceptors.dart';

class Api {
  final dio = Dio();
  final log = SimpleLogger();
  final socket = Socket();

  Api() {
    dio.interceptors.add(DioInterceptor());
    dio.options.sendTimeout = const Duration(milliseconds: 60000);
    dio.options.receiveTimeout = const Duration(milliseconds: 60000);
    dio.options.baseUrl = AppStrings.baseUrl;
    log.info('Api constructed and DIO setup register');
  }

  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String timeOption,
    int? endTime,
  }) async {
    final uri = '${dio.options.baseUrl}klines';
    final params = {
      'symbol': symbol,
      'interval': timeOption,
      if (endTime != null) 'endTime': endTime.toString(),
    };

    try {
      final res = await dio.get(uri, queryParameters: params);
      final data = res.data as List<dynamic>;
      log.finest('Candles gotten!');
      final candles =
          data.map((e) => Candle.fromJson(e)).toList().reversed.toList();
      log.finest('First candle => ${candles.first}');
      return candles;
    } catch (e) {
      log.severe('Error fetching candles: $e');
      return []; 
    }
  }

  Future<List<SymbolModel>> fetchSymbols() async {
    try {
      final uri = "${dio.options.baseUrl}ticker/price";
      log.info('Fetching symbols with $uri');
      final res = await dio.get(uri);
      log.info('Done with response: ${res.statusCode} and ${res.data}');
      List<dynamic> responseData = res.data;

      // ignore: unnecessary_type_check
      if (responseData is List<dynamic>) {
        final symbolModels = <SymbolModel>[];
        for (final symbolJson in responseData) {
          final symbolModel = SymbolModel.fromJson(symbolJson);
          symbolModels.add(symbolModel);
        }
        return symbolModels.toSet().toList();
      } else {
        throw Exception('Invalid response data type');
      }
    } catch (e) {
      log.shout('Error fetching symbols: $e');
      return []; 
    }
  }
}
