import 'package:injectable/injectable.dart';
import 'package:test_app/client/socket_client.dart';
import 'package:test_app/models/ticker.dart';
import 'package:test_app/repositories/repository.dart';

@Named("StreamRepository")
@Injectable(as: IRepository)
class StreamRepository implements IRepository{
  final SocketClient _client;

  StreamRepository(this._client);

  @override
  Stream<List<Ticker>> connectToStream(String query) {
    return _client.connectToTickerStream(query);
  }

  @override
  disconnectStream() {
    return _client.closeWebSocket();
  }

}