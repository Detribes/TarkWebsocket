import 'package:injectable/injectable.dart';
import 'package:test_app/client/socket_client.dart';
import 'package:test_app/models/ticker.dart';
import 'package:test_app/repositories/stream_repository.dart';

@injectable
abstract interface class IRepository{
  Stream<List<Ticker>> connectToStream(String query);
  disconnectStream();

  @factoryMethod
  static StreamRepository create(SocketClient client) => StreamRepository(client);
}