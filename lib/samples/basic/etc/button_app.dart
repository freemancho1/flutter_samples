import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Flutter Buttons
/// - ElevatedButton
/// - TextButton
/// - OutlinedButton
/// - IconButton
/// - FloatingActionButton
/// - CupertinoButton: iOS style
/// - DropdownButton
/// - ToggleButton
/// - CupertinoSwitch: iOS style switch
/// - Slider

class ButtonApp extends StatelessWidget {
  const ButtonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Buttons'),),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Container(
        /// Column 자체로는 폭이 최대까지 가지 않기 때문에 확장시켜줌
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          /// 기본적으로 버튼은 다 비슷함
          children: const [
            _ElevatedButton(), SizedBox(height: 8,),
            /// 배경에 애니메이션
            _TextButton(), SizedBox(height: 8,),
            _OutlinedButton(), SizedBox(height: 8,),
            /// Text 버튼과 애니메이션이 다름(Text에 애니메이션)
            /// onPressed만 존재
            _CupertinoButton(), SizedBox(height: 8,),
            _DoropDownButton(), SizedBox(height: 8,),
            _ToggleButton(), SizedBox(height: 8,),
            _CupertinoSwitch(), SizedBox(height: 8,),
            _Slider()
          ],
        ),
      ),
    ),
  );
}

/// 앱 색상을 상속받고, 기본적인 클릭 애니메이션을 제공함.
class _ElevatedButton extends StatelessWidget {
  const _ElevatedButton({Key? key}) : super(key: key);

  @override
  /// 자동 애니메이션(애니메이션은 배경색상과 주 색상을 기준으로 이뤄짐)
  Widget build(BuildContext context) => ElevatedButton(
    /// onPressed: null,
    onPressed: () => _SnackBar.showBasic(
      context,
      message: 'Elevated Button Click',
      isCloseIcon: true,
    ),
    onLongPress: () => _SnackBar.show(
      context,
      message: 'Elevated Button Long Click',
      isCenter: true,
      bgColor: Colors.deepOrange,
      duration: 1000,
    ),
    style: ElevatedButton.styleFrom(
      /// 최소크기 지정
      minimumSize: const Size(160, 50),
      /// 테두리 선 관련(두께, 점선, 색상) 지정
      // side: const BorderSide(
      //   color: Colors.orange,       /// default: Colors.black
      //   width: 1,                   /// default: 1
      //   style: BorderStyle.solid,   /// default: solid
      // ),
      /// 테두리 모양 관련(곡선 등) 지정
      // shape: RoundedRectangleBorder(
      //   /// 방향에 따라 주면서, x/y축 비율 지정 가능
      //   /// borderRadius: BorderRadius.horizontal(left: Radius.elliptical(20, 20))
      //   /// 상단왼쪽만 곡선 줌
      //   /// borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
      //   /// 전체 일괄
      //   borderRadius: BorderRadius.circular(50)
      // ),
      // enabledMouseCursor: MouseCursor.uncontrolled,
      /// 별도로 주지 않으면 앱의 주 색상을 가져옴
      /// 글자색 (disable 색상도 이미 정해져 있음)
      // foregroundColor: Colors.greenAccent,
      /// 배경색 (disable 색상도 이미 정해져 있음)
      // backgroundColor: Colors.yellowAccent
    ),
    child: const Text('Elevated Button'),
  );
}

/// 앱 색상을 상속받고, 기본적인 클릭 애니메이션을 제공함
/// 기본적인 스타일 옵션은 모든 버튼이 다 비슷함.
class _TextButton extends StatelessWidget {
  const _TextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () {},   /// _ElevatedButton 참조
    style: TextButton.styleFrom(
      /// 최소크기 지정
      minimumSize: const Size(160, 50),
      /// 테두리 선 관련(두께, 점선, 색상) 지정
      // side: const BorderSide(
      //   color: Colors.orange,       /// default: Colors.black
      //   width: 1,                   /// default: 1
      //   style: BorderStyle.solid,   /// default: solid
      // ),
      /// 테두리 모양 관련(곡선 등) 지정
      // shape: RoundedRectangleBorder(
      //   /// 방향에 따라 주면서, x/y축 비율 지정 가능
      //   /// borderRadius: BorderRadius.horizontal(left: Radius.elliptical(20, 20))
      //   /// 상단왼쪽만 곡선 줌
      //   /// borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
      //   /// 전체 일괄
      //     borderRadius: BorderRadius.circular(50)
      // ),
      /// 별도로 주지 않으면 앱의 주 색상을 가져옴
      /// 글자색 (disable 색상도 이미 정해져 있음)
      // foregroundColor: Colors.greenAccent,
      /// 배경색 (disable 색상도 이미 정해져 있음)
      // backgroundColor: Colors.yellowAccent,
      // elevation: 2,
    ),
    // child: const Text('Text Button'),
    /// 이렇게 하면 Icon 버튼하고 동일(IconButton은 child 대신 icon:을 받음)
    // child: const Icon(Icons.add),
    child: Row(
      /// 아래를 기술하지 않으면, Row 자체가 전체 폭을 사용하기 때문에
      /// 정렬이 꼬일 수 있으니, 버튼을 최소화함
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.add),
        SizedBox(width: 10,),
        Text('Text Button')
      ],
    ),
  );
}

/// 모든 버튼은 다 비슷함.
class _OutlinedButton extends StatelessWidget {
  const _OutlinedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      side: const BorderSide(width: 2, color: Colors.deepOrange),
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
      ),
    ),
    child: const Text('Outlined Button'),
  );
}

class _CupertinoButton extends StatelessWidget {
  const _CupertinoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoButton(
    child: const Text('Cupertino Button'),
    onPressed: () {}
  );
}

/// 색상은 별도로 지정하지 않으면 검정색 계열
class _DoropDownButton extends StatelessWidget {
  const _DoropDownButton({Key? key}) : super(key: key);

  @override
  /// item의 value는 DropdownButton<T>에서 T와 동일해야 함.
  Widget build(BuildContext context) => DropdownButton<int>(
    items: [
      /// child가 가장 마지막
      DropdownMenuItem(
        value: 1,
        /// 이런식으로 처리해도
        child: Row(
          /// 아래를 기술하지 않으면, Row 자체가 전체 폭을 사용하기 때문에
          /// 정렬이 꼬일 수 있으니, 버튼을 최소화함
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.add),
            SizedBox(width: 10,),
            Text('Text Button')
          ],
        ),),
      const DropdownMenuItem(value: 2, child: Text('Item 2'),),
    ],
    /// 초기값(이 값의 item이 표시됨(hint 무시)
    /// value: 1,
    icon: const Icon(Icons.access_alarm),
    onChanged: (value) => debugPrint('$value'),
    hint: const Text('Select an Options'),
  );
}

/// 좀 더 구현이 필요해 보임
class _ToggleButton extends StatefulWidget {
  const _ToggleButton({super.key});
  @override
  State<_ToggleButton> createState() => _ToggleButtonState();
}
class _ToggleButtonState extends State<_ToggleButton> {
  @override
  Widget build(BuildContext context) => ToggleButtons(
    onPressed: (index) {
      debugPrint('$index');
      setState(() {

      });
    },
    isSelected: const [true, false, true],
    /// children이 가장 마지막에 와야 함.
    children: const [
      Icon(Icons.check),
      Icon(Icons.check),
      Icon(Icons.check),
    ],
  );
}

/// 이 위젯 자체는 Stateful로 구현해야 할 듯
class _CupertinoSwitch extends StatelessWidget {
  const _CupertinoSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoSwitch(
    value: true,
    onChanged: (value) => debugPrint('$value'),
  );
}

class _Slider extends StatelessWidget {
  const _Slider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Slider(
    value: 50,
    min: 0,
    max: 100,
    onChanged: (value) => debugPrint('$value'),
  );
}

class _SnackBar {

  static void show(BuildContext context, {
    /// SnackBar 기본 높이: 48가 아닌거 같음.
    double bottom = 0.0,
    String message = '',
    bool isCenter = false,
    Color? color,
    Color? bgColor,
    int? duration,
  }) {
    color = color ?? Colors.white;
    bgColor = bgColor ?? Theme.of(context).snackBarTheme.backgroundColor;
    duration = duration ?? 500;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: bottom),
        color: bgColor,
        alignment: isCenter ? Alignment.center : Alignment.centerLeft,
        child: Text(
          message,
          style: TextStyle(color: color),
        ),
      ),
      duration: Duration(milliseconds: duration),
      backgroundColor: bgColor,
    ));
  }

  static void showBasic(BuildContext context, {
    Color? color,
    Color? bgColor,
    String message = '',
    bool isCenter = false,
    bool isCloseIcon = false,
    int? duration,
  }) {
    color = color ?? Colors.white;
    bgColor = bgColor ?? Theme.of(context).snackBarTheme.backgroundColor;
    duration = duration ?? 500;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: color),
        textAlign: isCenter ? TextAlign.center : TextAlign.start,
      ),
      backgroundColor: bgColor,
      showCloseIcon: isCloseIcon,
      closeIconColor: color,
      duration: Duration(milliseconds: duration),
    ));
  }
}


