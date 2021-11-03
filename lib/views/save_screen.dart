import 'package:flutter/material.dart';
import 'package:learn_app/configs/asset_image_paths.dart';
import 'package:learn_app/constants.dart';
import 'package:learn_app/models/learn_content.dart';
import 'package:learn_app/providers/data_provider.dart';
import 'package:provider/provider.dart';

class SaveScreen extends StatefulWidget {
  final Function onFinish;

  const SaveScreen({Key? key, required this.onFinish}) : super(key: key);

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    List<LearnContent> contents = dataProvider.getSaveContents();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            widget.onFinish();
            Navigator.pop(context);
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
              AssetImagePaths.xButton,
              color: Colors.black,
            ),
          ),
        ),
        title: const Text('Saved for later'),
        centerTitle: true,
      ),
      body: Container(
        color: kBlackColor.withAlpha(50),
        child: ListView.builder(
          itemCount: contents.length,
          itemBuilder: (buildContext, index) {
            LearnContent content = contents[index];
            return Container(
              margin: const EdgeInsets.only(top: kPadding5, left: kPadding4, right: kPadding4),
              padding: const EdgeInsets.all(kPadding3),
              decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.all(Radius.circular(kPadding3)),
              ),
              child: Stack(
                children: [
                  Column(
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
      ),
    );
  }
}