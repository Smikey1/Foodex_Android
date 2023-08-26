import 'package:flutter/material.dart';
import 'package:foodex_app/app/utils/dimension.dart';

class PostCartScreen extends StatefulWidget {
  const PostCartScreen({super.key});

  @override
  State<PostCartScreen> createState() => _PostCartScreenState();
}

class _PostCartScreenState extends State<PostCartScreen> {
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    const double itemHeight = 250.0;
    const double itemWidth = 125;
    return Scaffold(
        body: GridView.count(
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            for (int i = 0; i < 10; i++) ...{
              Container(
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      // width: 1,
                    ),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Color.fromARGB(255, 201, 200, 200),
                    //     spreadRadius: 2,
                    //     blurRadius: 10,
                    //     offset: Offset(0, 1), // changes position of shadow
                    //   ),
                    // ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          height: Dimensions.height100,
                          width: Dimensions.height100 * 5,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://res.cloudinary.com/de9neeomp/image/upload/v1674758167/fodjeans/products/tmp-1-1674758164836.jpg'),
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Color Canvas',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    '4.5',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Rs.200',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
            }
          ],
        ));
  }
}
