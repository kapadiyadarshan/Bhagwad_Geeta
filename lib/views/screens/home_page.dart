import 'package:bhagwad_geeta/controller/lang_controller.dart';
import 'package:bhagwad_geeta/helpers/json_helper.dart';
import 'package:bhagwad_geeta/utils/colors_utils.dart';
import 'package:bhagwad_geeta/utils/route_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageController>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            provider.isHindi ? "भगवद गीता" : "Bhagwad Geeta",
            style: const TextStyle(
              fontSize: 24,
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
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
          child: FutureBuilder(
            future: JSONHelper.jsonHelper.getChapters(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 6,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MyRoute.chapterPage,
                          arguments: snapshot.data![index],
                        );
                      },
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MyColor.theme2,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 121,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    "https://m.media-amazon.com/images/I/51Pj2N72-yL.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.isHindi
                                      ? "अध्याय: ${snapshot.data![index]["chapter_number"]}\n${snapshot.data![index]["name"]}"
                                      : "Chapter: ${snapshot.data![index]["chapter_number"]}\n${snapshot.data![index]["name_translation"]}",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  provider.isHindi
                                      ? "कुल श्लोक: ${snapshot.data![index]["verses_count"]}"
                                      : "Total Verses: ${snapshot.data![index]["verses_count"]}",
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                  },
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
