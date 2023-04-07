import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(const GeoLocation());

/// 상황에 따라 표시되는 메시지가 변하기 때문에,
/// StatefulWidget을 사용할 것 처럼 보이지만,
/// 이는 FutureBuilder가 해당 future의 상태에 따라
/// 표시되는 위젯을 교체해주기 때문에.. 위젯 차원에서의 변화가 아님
class GeoLocation extends StatelessWidget {
  const GeoLocation({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Geo Location'),),
    body: Center(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.displaySmall!,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        /// FutureBuilder로 Position?을 리턴하는 함수를 만든다고 선언하고
        child: FutureBuilder<Position?>(
          /// 해당 함수를 future에 연결함.
          /// 당연하지만 future에 올 수 있는 함수는 async~await로 연결된 함수임
          future: Location.getCurrentLocation(),
          builder: (context, snapshot) => (snapshot.hasData)
            /// snapshot은 현 시점의 Position?의 값을 의미하고,
            /// 정확히는 AsyncSnapshot<Position?>형이며,
            /// 데이터가 있으면 데이터를 출력, 에러면 에러를 출력, 아직 진행중이면
            /// 로딩화면을 출력함
            ? _displayLocation(snapshot)
            : (snapshot.hasError)
              ? _displayError(snapshot)
              : _displayLoading(),
        )
      ),
    ),
  );

  Widget _displayLocation(AsyncSnapshot<Position?> snapshot) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          'Result: (${snapshot.data!.latitude}, ${snapshot.data!.longitude})',
          style: const TextStyle(
            color: Colors.green,
            fontSize: 16,
          ),
        ),
      ),
    ],
  );

  Widget _displayError(AsyncSnapshot<Position?> snapshot) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          'Error: ${snapshot.error}',
          style: const TextStyle(color: Colors.deepOrange),
        ),
      ),
    ],
  );

  Widget _displayLoading() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      SizedBox(
        width: 60, height: 60,
        /// 기본적으로 많이 사용하는 원형 진행바
        child: CircularProgressIndicator(),
      ),
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text(
          '대기중...',
          style: TextStyle(color: Colors.deepOrange),
        ),
      ),
    ],
  );
}

class Location {
  static Future<Position?> getCurrentLocation() async {
    try {
      /// 권한을 사용자에게 묻기 위해 사용하며,
      /// 프로그램에서 별도 저장할 필요없이 시스템이 자동으로 관리함
      // LocationPermission permission = await Geolocator.requestPermission();
      // debugPrint('Permission: $permission');
      // debugPrint('Permission(index): ${permission.index}');
      // debugPrint('Permission(name): ${permission.name}');
      // debugPrint('Permission(toString): ${permission.toString()}');
      await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(
        /// 정확도
        /// bestForNavigation - 가장 정확하게
        /// high - 가능한 정확하게
        /// medium - 일반적으로
        /// low - 대략
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch(e) {
      debugPrint('Error: ${e.toString()}');
      return null;
    }
  }
}
