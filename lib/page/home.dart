import 'dart:io';
import 'package:apollo/alert/default_alert.dart';
import 'package:apollo/model/recording.dart';
import 'package:apollo/page/settings.dart';
import 'package:apollo/transition/slide_left_transition.dart';
import 'package:apollo/util/custom_tabs_launcher.dart';
import 'package:apollo/util/permission_request.dart';
import 'package:apollo/values/colors.dart';
import 'package:apollo/widgets/home_app_bar_cib.dart';
import 'package:apollo/widgets/home_fab.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:apollo/widgets/popup_menu_option.dart';

class HomePage extends StatefulWidget {
  final Icon floatingActionButtonIcon = Icon(Icons.mic_none);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  bool get _hasItems => _recordings.length > 0;
  List<Recording> _recordings = [];

  @override
  void initState() {
    _fetchRecordings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          HomeFAB(onStopRecordingCallback: () => _fetchRecordings()),
      body: _buildNestedScrollView(),
    );
  }

  _buildNestedScrollView() => NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [_buildAppBar()],
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _hasItems ? _buildList() : Container(),
      );

  SliverAppBar _buildAppBar() => SliverAppBar(
        expandedHeight: 180.0,
        snap: true,
        floating: true,
        pinned: false,
        actions: [
          PopupMenuButton(
            onSelected: (PopupMenuOption item) {
              item.callback();
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuOption(
                        () async => await Navigator.push(
                        context,
                        SlideLeftRoute(
                          widget: SettingsPage(),
                        )),
                    'Settings'),
                PopupMenuOption(() async {
                  try {
                    await CustomTabsLauncher(context,
                        'https://github.com/tylerbryto/apollo_audio_recorder')
                        .launchUrl();
                  } catch (e) {
                    await DefaultAlert(
                        title: 'Ops',
                        content: 'An error occured while launching url')
                        .show();
                  }
                }, 'Contribute'),
              ].map((PopupMenuOption item) {
                  return PopupMenuItem<PopupMenuOption>(
                      child: Text(item.title),
                      value: item,
                    );
                })
                .toList();
            },
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            child: Center(
              child: _buildHeroButton(),
            ),
            decoration: BoxDecoration(gradient: gradientBackground),
          ),
        ),
      );

  Hero _buildHeroButton() => Hero(
        tag: 'buttonHero',
        child: HomeAppBarCIB(
          onStopRecordingCallback: () => _fetchRecordings(),
        ),
      );

  ListView _buildList() => ListView(
      children: List.from(_recordings)
        ..add(Container(
          child: Padding(
            padding: EdgeInsets.all(50),
          ),
        )));

  Future _fetchRecordings() async {
    try {
      setState(() {
        _isLoading = true;
        _recordings.clear();
      });
      if (await PermissionRequest.handleReadExternalStoragePermission() &&
          await PermissionRequest.handleWriteExternalStoragePermission()) {
        Directory appDocDirectory = await getExternalStorageDirectory();
        var dir = await Directory('${appDocDirectory.path}/apollo/recordings')
            .create(recursive: true);
        dir
            .list(recursive: true, followLinks: false)
            .listen((FileSystemEntity entity) {
          String filename = basename(entity.path);
          print(filename);
          filename = filename.length > 25
              ? filename.substring(0, 25) + '...'
              : filename;
          setState(() => _recordings
              .add(Recording(title: filename, creationDate: DateTime.now())));
        });
      }
    } catch (e) {
      await DefaultAlert(
              context: this.context,
              title: 'Ops',
              content: 'An error occured while fetching data')
          .show();
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
