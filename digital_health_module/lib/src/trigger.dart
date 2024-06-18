/* part of '../main.dart';


@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: false)
class RemoteTrigger extends TriggerConfiguration {
  RemoteTrigger({
    required this.uri,
    this.interval = const Duration(minutes: 10),
  }) : super();

  /// The URI of the resource to listen to.
  String uri;

  /// How often should we check the server?
  /// Default is every 10 minutes.
  Duration interval;

  @override
  Function get fromJsonFunction => _$RemoteTriggerFromJson;
  factory RemoteTrigger.fromJson(Map<String, dynamic> json) =>
      _$RemoteTriggerFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RemoteTriggerToJson(this);
}

class RemoteTriggerExecutor extends TriggerExecutor<RemoteTrigger> {
  final http.Client client = http.Client();
  Timer? timer;

  @override
  Future<bool> onStart() async {
    timer = Timer.periodic(configuration!.interval, (_) async {
      var response = await client.get(
        Uri.parse(Uri.encodeFull(configuration!.uri)),
      );

      if (response.statusCode == HttpStatus.ok) {
        // If there is a resource at the specified URI, then trigger this executor
        onTrigger();
      }
    });
    return true;
  }

  @override
  Future<void> onStop() async {
    timer?.cancel();
    client.close();
  }
}

class RemoteTriggerFactory implements TriggerFactory {
  @override
  Set<Type> types = {
    RemoteTrigger,
  };

  @override
  TriggerExecutor<TriggerConfiguration> create(TriggerConfiguration trigger) {
    if (trigger is RemoteTrigger) return RemoteTriggerExecutor()..initialize(trigger);
    return ImmediateTriggerExecutor()..initialize(trigger);
  }

  @override
  void onRegister() {
    FromJsonFactory().registerAll([RemoteTrigger(uri: 'uri')]);
  }
}

void main() {
  ExecutorFactory().registerTriggerFactory(RemoteTriggerFactory());
}
 */