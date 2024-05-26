import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nbp/utility/colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({super.key});

  @override
  State<LoadingListPage> createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Center(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      color: grayBgColor,
                      margin: EdgeInsets.only(
                          top: 10.0, left: 30.0, right: 30.0, bottom: 5.0),
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: lightGrayBgColor,
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: const SizedBox(
                              width: 80,
                              height: 80,
                            ),
                          ),
                          Icon(
                            Icons.circle,
                            color: lightGrayBgColor,
                            size: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: lightGrayBgColor,
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
    );
  }
}
