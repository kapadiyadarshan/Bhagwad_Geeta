import 'package:bhagwad_geeta/controller/lang_controller.dart';
import 'package:bhagwad_geeta/helpers/json_helper.dart';
import 'package:bhagwad_geeta/utils/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../utils/colors_utils.dart';

class ChapterPage extends StatelessWidget {
  const ChapterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    return Consumer<LanguageController>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            provider.isHindi
                ? "${data["name"]}"
                : "${data["name_translation"]}",
            style: const TextStyle(
              // fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                provider.changeLanguage();
              },
              child: Text(
                provider.isHindi ? "Aa" : "आ",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: MyColor.theme1,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder(
            future: JSONHelper.jsonHelper.getVerses(),
            builder: (context, snapshot) {
              List tmp = [];
              if (snapshot.hasData) {
                snapshot.data!.forEach((element) {
                  if (data['chapter_number'] == element['chapter_number']) {
                    tmp.add(element);
                  }
                });
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: MyColor.theme2,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: ReadMoreText(
                        provider.isHindi
                            ? data["chapter_summary_hindi"]
                            : data["chapter_summary"],
                        trimLines: 7,
                        textAlign: TextAlign.justify,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: "Read More",
                        trimExpandedText: "Read Less",
                        lessStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        moreStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                MyRoute.detailPage,
                                arguments: snapshot.data![index],
                              );
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: MyColor.theme2,
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                provider.isHindi
                                    ? "श्लोक ${tmp[index]['verse_number']}"
                                    : "Shloka ${tmp[index]['verse_number']}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 6,
                        ),
                        itemCount: tmp.length,
                      ),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      );
    });
  }
}
