void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SensingBLoC sensingBloc = SensingBLoC();

  await sensingBloc.initialize(
    deploymentMode: DeploymentMode.local,
    deploymentId: 'example_deployment_id',
    useCachedStudyDeployment: true,
    resumeSensingOnStartup: true,
  );

  if (sensingBloc.isRunning) {
    sensingBloc.stop();
  } else {
    sensingBloc.start();
  }

  runApp(MyApp(sensingBloc: sensingBloc));
}

class MyApp extends StatelessWidget {
  final SensingBLoC sensingBloc;

  MyApp({required this.sensingBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Sensing BLoC Example')),
        body: SensingControl(sensingBloc: sensingBloc),
      ),
    );
  }
}

class SensingControl extends StatefulWidget {
  final SensingBLoC sensingBloc;

  SensingControl({required this.sensingBloc});

  @override
  _SensingControlState createState() => _SensingControlState();
}

class _SensingControlState extends State<SensingControl> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sensing is ${widget.sensingBloc.isRunning ? 'Running' : 'Stopped'}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (widget.sensingBloc.isRunning) {
                  widget.sensingBloc.stop();
                } else {
                  widget.sensingBloc.start();
                }
              });
            },
            child: Text(widget.sensingBloc.isRunning ? 'Stop Sensing' : 'Start Sensing'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.sensingBloc.dispose();
              setState(() {});
            },
            child: Text('Dispose Sensing'),
          ),
        ],
      ),
    );
  }
}
