import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class LoaderPage extends StatelessWidget {
  final Widget child;
  final bool busy;
  const LoaderPage({Key key, @required this.child, @required this.busy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: child,
          ),
          busy
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.75),
                  child: SpinKitRipple(
                    size: 180,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.teal.withOpacity(0.8),
                        ),
                      );
                    },
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
