import 'package:engzly/core/helper/local/token_manger.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  late HubConnection _hubConnection;

  Function(String message)? onNotificationReceived;

  Future<void> initConnection() async {
    final hubUrl = "http://engezly.runasp.net/notificationHub";

    final token = await TokenManager.getToken();
    _hubConnection = HubConnectionBuilder()
        .withUrl(
          hubUrl,
          options: HttpConnectionOptions(
            accessTokenFactory: token != null ? () async => token : null,
          ),
        )
        .withAutomaticReconnect()
        .build();

    _hubConnection.on("ReceiveNotification", (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        final message = arguments.first.toString();
        print(" New notification: $message");
        onNotificationReceived?.call(message);
      }
    });

    await _hubConnection.start();
    print(" Connected to SignalR hub");
  }

  Future<void> stopConnection() async {
    await _hubConnection.stop();
    print(" Disconnected from SignalR hub");
  }
}
