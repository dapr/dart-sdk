import 'package:dapr_common/dapr_common.dart';
import 'package:dapr_proto/dapr_proto.dart' as dp;
import 'package:grpc/grpc.dart' as grpc;

import '../../abstractions/client.dart';

///
/// A grpc client to access Dapr Side Car.
///
class DaprGrpcClient implements Client<dp.DaprClient> {
  /// Note this is a DaprClient generated by Grpc compiler tools.
  @override
  late final dp.DaprClient client;
  @override
  final String clientHost;
  @override
  final int clientPort;
  @override
  final CommunicationProtocol communicationProtocol =
      CommunicationProtocol.grpc;

  DaprGrpcClient({
    required this.clientHost,
    required this.clientPort,
  }) {
    // Initialize the grpc client.
    // We use the grpc package to handle all the grpc based client calls.
    final channel = grpc.ClientChannel(
      clientHost,
      port: clientPort,
      options: grpc.ChannelOptions(
        credentials: grpc.ChannelCredentials.insecure(),
      ),
    );

    client = dp.DaprClient(channel);
  }
}
