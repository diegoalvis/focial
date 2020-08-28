import 'package:chopper/chopper.dart';
import 'package:focial/api/urls.dart';

part 'api.chopper.dart';

@ChopperApi()
abstract class FocialAPI extends ChopperService {
  /// auth apis
  @Post(path: Urls.REGISTER)
  Future<Response<dynamic>> register(
      {@Field() String name, @Field() String email, @Field() String password});

  @Post(path: Urls.LOGIN)
  Future<Response<dynamic>> login(
      {@Field() String email, @Field() String password});

  static FocialAPI create() {
    final client = ChopperClient(
        baseUrl: Urls.BASE_URL,
        services: [
          _$FocialAPI(),
        ],
        interceptors: [
          HttpLoggingInterceptor(),
        ],
        converter: JsonConverter());
    return _$FocialAPI(client);
  }
}
