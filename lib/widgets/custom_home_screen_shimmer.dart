import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomHomeScreenShimmer extends StatelessWidget {
  const CustomHomeScreenShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Container(
                  height: 132,
                  decoration: BoxDecoration(
                    color: Colors.grey[300]!,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 100,
                // color: Colors.black12,
                child: ListView.builder(
                  itemBuilder: (_, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                enabled: true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 130.0,
                            color: Colors.white,
                          ),
                          Container(
                            width: double.infinity,
                            height: 20.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 20.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 20.0,
                            color: Colors.white,
                          ),
                        ],
                      )



                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget>[
                      //     Container(
                      //       width: 48.0,
                      //       height: 48.0,
                      //       color: Colors.white,
                      //     ),
                      //     const Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 8.0),
                      //     ),
                      //     Expanded(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: <Widget>[
                      //           Container(
                      //             width: double.infinity,
                      //             height: 8.0,
                      //             color: Colors.white,
                      //           ),
                      //           const Padding(
                      //             padding: EdgeInsets.symmetric(vertical: 2.0),
                      //           ),
                      //           Container(
                      //             width: double.infinity,
                      //             height: 8.0,
                      //             color: Colors.white,
                      //           ),
                      //           const Padding(
                      //             padding: EdgeInsets.symmetric(vertical: 2.0),
                      //           ),
                      //           Container(
                      //             width: 40.0,
                      //             height: 8.0,
                      //             color: Colors.white,
                      //           ),
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ),
                    itemCount: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
