import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/services/get_card_gradient.dart';

class ItemPage extends StatelessWidget {
  final ItemData data;

  const ItemPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Color tagColor = Colors.green;
    switch (data.type) {
      case 'Figure':
        tagColor = const Color(0xFF06d6a0);
        break;
      case 'Manga':
        tagColor = const Color(0xFFef476f);
        break;
      case 'Game':
        tagColor = const Color(0xFF118ab2);
        break;
      case 'Other':
        tagColor = const Color(0xFF073b4c);
        break;
    }

    return Scaffold(
        backgroundColor: const Color(0xFF03071e),
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.orange,
          ),
          backgroundColor: Colors.orange,
          title: FittedBox(child: Text(data.title)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Hero(
                  tag: data.uuid,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 3, color: Colors.orange),
                      image: DecorationImage(
                          image: MemoryImage(data.image), fit: BoxFit.cover),
                    ),
                    height: size.width,
                    width: size.width,
                  ),
                ),
                SizedBox(
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      checkbox(
                        Icons.paid,
                        data.paid,
                        size,
                      ),
                      checkbox(
                        Icons.cancel_outlined,
                        data.canceled,
                        size,
                      ),
                      checkbox(
                        Icons.directions_boat,
                        data.import,
                        size,
                      ),
                      checkbox(
                        Icons.local_shipping,
                        data.delivered,
                        size,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: getCardGradient(data.canceled),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.totalPrice,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: tagColor,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data.type,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.1,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            const Text(
                              'Date Bought',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 13.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    data.dateBought,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            const Text(
                              'Release Date',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 13.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    data.releaseDate,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
                  child: GestureDetector(
                    onTap: () async {
                      await launchUrlString(
                        data.link,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: getCardGradient(data.canceled),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Open Link',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.08,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
  }

  Widget checkbox(IconData icon, bool value, Size size) {
    return Row(
      children: [
        Icon(
          icon,
          size: 30,
        ),
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            value: value,
            onChanged: (value) => {},
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.all(Colors.redAccent),
          ),
        ),
      ],
    );
  }
}
