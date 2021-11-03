import 'package:flutter/material.dart';
import 'package:learn_app/configs/asset_image_paths.dart';
import 'package:learn_app/configs/routes/app_routes_constants.dart';
import 'package:learn_app/constants.dart';
import 'package:learn_app/models/learn_content.dart';
import 'package:learn_app/providers/data_provider.dart';
import 'package:learn_app/views/scaffolded_loading_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<Widget> _tagLinesOne = [];
  final List<Widget> _tagLinesTwo = [];
  final List<Widget> _tagLinesThree = [];
  String _tagTitle = 'All';

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  void _initialize() async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    await dataProvider.getTag();
    await dataProvider.getLearnContent();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      if(dataProvider.isLoading) {
        _tagLinesOne.clear();
        _tagLinesTwo.clear();
        _tagLinesThree.clear();

        for (int i = 0; i < dataProvider.tags.length; i++) {
          if(i < dataProvider.tags.length / 3) {
            _tagLinesOne.add(
              _buildTagView(dataProvider.tags[i].color, dataProvider.tags[i].name)
            );
          }
          else if(i < dataProvider.tags.length * 2 / 3) {
            _tagLinesTwo.add(
              _buildTagView(dataProvider.tags[i].color, dataProvider.tags[i].name)
            );
          }
          else {
            _tagLinesThree.add(
              _buildTagView(dataProvider.tags[i].color, dataProvider.tags[i].name)
            );
          }
        }
      }

      return !dataProvider.isLoading
        ? ScaffoldedLoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Learn'),
              centerTitle: true,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, kSaveScreen, arguments: {'onFinish': refresh});
                  },
                  child: Container(
                    width: kPadding7,
                    height: kPadding5,
                    margin: const EdgeInsets.all(kPadding2),
                    padding: const EdgeInsets.all(kPadding3),
                    decoration: const BoxDecoration(
                      color: Color(0x55ffffff),
                      borderRadius: BorderRadius.all(Radius.circular(kPadding3)),
                    ),
                    child: Image.asset(
                      AssetImagePaths.saveWhiteIcon
                    ),
                  ),
                )
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(kPadding3),
              color: kBlackColor.withAlpha(50),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: _tagLinesOne
                        ),
                        Container(
                          height: kPadding3,
                        ),
                        Row(
                          children: _tagLinesTwo
                        ),
                        Container(
                          height: kPadding3,
                        ),
                        Row(
                          children: _tagLinesThree
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dataProvider.curContents.length,
                      itemBuilder: (buildContext, index) {
                        LearnContent content = dataProvider.curContents[index];
                        return Container(
                          margin: const EdgeInsets.only(top: kPadding5, left: kPadding4, right: kPadding4),
                          padding: const EdgeInsets.all(kPadding3),
                          decoration: const BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(kPadding3)),
                          ),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () async{
                                  if (await canLaunch(content.contentUrl)) {
                                    await launch(content.contentUrl);
                                  } else {
                                    // can't launch url, there is some error
                                    throw "Could not launch $content.contentUrl";
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: content.thumbnailUrl.isEmpty ?
                                        const Icon(Icons.album, size: kPadding8)
                                        : Image.network(content.thumbnailUrl),
                                      title: Text(
                                        content.createdAt,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: kBodyFontSize2
                                        ),
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Text(
                                            content.title, 
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: kBodyFontSize3,
                                              color: kBlackColor
                                            ),
                                          ),
                                          Text(
                                            content.description, 
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: kBodyFontSize2
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Text(
                                      'Shared by OnLoop',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: kBodyFontSize2
                                      ),
                                    ),  
                                    Container(
                                      margin: const EdgeInsets.only(top: kPadding2),
                                      padding: const EdgeInsets.all(kPadding2),
                                      decoration: BoxDecoration(
                                        color: getColor(content.tag.color).withAlpha(70),
                                        borderRadius: const BorderRadius.all(Radius.circular(kPadding3)),
                                      ),
                                      child: Text(
                                        'Hyper Organized',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: kBodyFontSize2,
                                          color: getColor(content.tag.color)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      dataProvider.setSaveContents(content.title);
                                    });
                                  },
                                  child: Image.asset(
                                    content.save
                                      ? AssetImagePaths.saveGreyIcon
                                      : AssetImagePaths.saveWhiteIcon,
                                    width: kPadding4, 
                                    height: kPadding4
                                  ),
                                ),
                              ),
                              Positioned(
                                right: kPadding1,
                                bottom: kPadding1,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AssetImagePaths.thumbsDown, 
                                      width: kPadding5, 
                                      height: kPadding5
                                    ),
                                    Container(width: kPadding2),
                                    Image.asset(
                                      AssetImagePaths.thumbsUp, 
                                      width: kPadding5, 
                                      height: kPadding5
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
      }
    );
  }

  Widget _buildTagView(String color, String title) {
    return GestureDetector(
      onTap: () {
        _tagTitle = title;
        final dataProvider = Provider.of<DataProvider>(context, listen: false);
        dataProvider.getCurContents(title);
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.only(right: kPadding5),
        padding: const EdgeInsets.all(kPadding3),
        decoration: BoxDecoration(
          color: getColor(color).withAlpha(70),
          borderRadius: const BorderRadius.all(Radius.circular(kPadding3)),
          border: Border.all(
            color: _tagTitle == title 
              ? getColor(color) 
              : Colors.transparent,
            width: 2
          )
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: kBodyFontSize2,
            color: getColor(color)
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {
      //
    });
  }
}