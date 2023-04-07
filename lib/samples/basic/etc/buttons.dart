import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ButtonsApp extends StatelessWidget {
  const ButtonsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Buttons'),),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// 자체 클릭 애니메이션이 적용됨
              ElevatedButton(
                onLongPress: () {},
                onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                    /// SnackBar의 크기를 조정하고 싶을 때
                    content: SizedBox(
                      height: 100,
                      /// 높이 중앙정렬
                      child: Center(
                        child: Text(
                          'Elevated Button Click',
                          /// 폭 중앙정렬
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    /// 일반적인 SnackBar
                    // content: Text(
                    //   'Elevated Button Click',
                    //   /// Text를 SnackBar 중앙에 배치함
                    //   textAlign: TextAlign.center,
                    // ),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.deepOrange,
                  )
                ),
                style: ElevatedButton.styleFrom(
                  /// 크기는 min/maxSize를 지정할 수 있으며, 고정할 수도 있음
                  /// 가급적 min/maxSize 이용
                  /// fixedSize: const Size(200, 50),
                  minimumSize: const Size(180, 45),
                  /// 자체 제공하는 애니메이션의 지속시간(별 차이 없어 보임)
                  animationDuration: const Duration(seconds: 5),
                ),
                child: const Text('ElevatedButton'),
              ),
              /// 중간에 공간없이 MainAxisAlignment.spaceEvenly 이용해 분리
              ElevatedButton(
                onLongPress: () {},
                onPressed: () => ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(
                  /// SnackBar의 크기를 조정하고 싶을 때
                  content: SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Elevated Button Click',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  /// 일반적인 SnackBar
                  // content: Text(
                  //   'Elevated Button Click',
                  //   /// Text를 SnackBar 중앙에 배치함
                  //   textAlign: TextAlign.center,
                  // ),
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.deepOrange,
                )),
                style: ElevatedButton.styleFrom(
                  /// 크기는 min/maxSize를 지정할 수 있으며, 고정할 수도 있음
                  /// 가급적 min/maxSize 이용
                  /// fixedSize: const Size(200, 50),
                  minimumSize: const Size(180, 45),
                  /// 자체 제공하는 애니메이션의 지속시간(별 차이 없어 보임)
                  animationDuration: const Duration(seconds: 5),
                ),
                child: const Text('ElevatedButton'),
              ),
            ]
          ),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 자체 애니메이션이 있는데 ElevatedButton보다 못함
              MaterialButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Material Button Click'),
                  ));
                },
                color: Colors.lightGreenAccent,
                /// 자체 Icon을 넣을 순 없음(Icon을 넣고 싶으면 이런식으로 놓으면 됨)
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(MdiIcons.iceCream),
                    SizedBox(width: 8,),
                    Text('MaterialButton')
                  ],
                )
              ),
              const SizedBox(width: 16,),
              TextButton(
                onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                    content: Text('Text Button Click.')
                )),
                child: const Text('TextButton')
              ),
            ],
          ),
          const SizedBox(height: 8,)
        ],
      ),
    )
  );
}
