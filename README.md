# Flutter Samples

다양한 플루터 예제를 다루고 있다.

<br/>

# 예제들

<br/>

## AppBar
숨기거나 표시하기, 펼치기, 앞뒤 아이콘 처리 등을 확인 할 수 있음.

<br/>

### 숨기거나 표시하기
> /lib/samples/basic/appbar/animation.dart

본문의 리스트에 컨트롤러를 장착해, 
리스트의 위치와 상관없이 단순히 상하 움직임만 감지해
앱바를 숨기거나 표시하는 애니메이션 구현
* `ScrollController`를 이용해 리스트뷰의 이동방향을 체크
* `PreferredSize` 위젯을 이용한 AppBar 구현
* `AnimatedCrossFade`를 이용해 두개의 위젯을 교차 표시
* `ListView.separated`의 빌더를 이용해 아이템과 분리자 생성
* leading 부분 아이콘 및 액션 변경하는 방법

<br/>

### 확장형 앱바
> /lib/samples/basic/appbar/sliver.dart

앱바를 `CustomScrollView`않에 넣어 처음에 크게 보이다가, 
바디에 있는 리스트의 스크롤에 따라 작아지거나 없엘 수 있는 앱바
* `CustomScrollView`에서 아래 위젯들 사용
  * `SliverAppBar`와 `FlexibleSpaceBar` 구현
  * `SliverFillRemaining(앱바 이하-화면 보이는 데까지-를 구현하는 위젯)` 구현
  * `SliverToBaxAdapter(바디의 단일 박스)` 구현
  * `SliverList(바디의 리스트 박스)` 구현
* `BottomAppBar`로 구현한 `bottomNavigationBar` 구현
  * `SingleChildScrollView`와 `OverflowBar` 위젯 사용

<br/><br/>

## Animations
다양한 애니메이션 효과를 확인할 수 있음.

<br/>

### 컨테이너 박스 애니메이션
> /lib/samples/basic/animations/animated_container.dart

버튼을 클릭하면 박스의 이미지가 변하는 애니메이션 구현
* Random 색상 만들기
* AnimatedContainer 사용법

<br/>

### 페이지 이동 애니메이션
> /lib/samples/basic/animations/page_route_builder.dart

위/아래로 이동하는 애니메이션으로 페이지 이동함
* PageRouteBuilder<SlideTransition>
* Tween
* CurveTween

<br/>

### 애니메이션 컨트롤러
> /lib/samples/basic/animations/animation_controller.dart

애니메이션 컨트롤러를 이용해 애니메이션을 동작시키거나, 애니메이션의 상태에 따라
필요한 작업을 수행하는 방법을 이해할 수 있다.
* AnimationController
* TickerProvider, SingleTickerProviderStateMixin
* addListener, addStatusListener
* ConstrainedBox, BoxConstraints
* 애니메이션 상태에 따라 애니메이션 조정 또는 새로운 작업 실행

<br/>

### 애니메이션 컨트롤러 2 
> /lib/samples/basic/animations/tweens.dart

애니메이션 객체에 애니메이션 컨트롤러를 결합해 애니매이션을 처리하는 방법
* 애니메이션 컨트롤러와 동일
* 차이점: Animation 객체에 AnimationController를 붙여 제어
* Tweens

<br/>

### 애니메이션 컨트롤러 3
> /lib/samples/basic/animations/animation_builder.dart

애니메이션 빌더를 이용해 자식 클래스에 에니메이션을 적용해 처리하는 방법
* 애니메이션 컨트롤러와 동일
* AnimatedBuilder
* ColorTween

<br/>

### 애니메이션 컨트롤러 4
> /lib/samples/basic/animations/custom_tweens.dart

사용자정의 Tween 클래스를 만들어 문자열을 생성하는 애니메이션 처리하는 방법
* 애니메이션 컨트롤러와 동일
* 사용자정의 Tween 클래스

<br/>

### 애니메이션 컨트롤러 5
> /lib/samples/basic/animations/custom_tweens.dart

8장의 색상 Tween을 이용해 하나의 애니메이션으로 처리'
* 애니메이션 컨트롤러와 동일
* List<TweenSequenceItem<Color?>>

<br/><br/>

## Etc
기본적이지만 버튼처리 등 다양한 내용이 있음

<br/>

### Buttons
> /lib/samples/basic/etc/button_app.dart

다양한 버튼 표현 방법을 구현',
* ElevatedButton
* TextButton
* OutlinedButton
* CupertinoButton - 글자에 애니메이션(더 좋음)
* DropDownButton
* ToggleButton
* CupertinoSwitch - iOS형 Switch
* Slider

<br/>

### TabBar
> /lib/samples/basic/etc/tabbar.dart

앱바 아래 붙어있는 탭바 구현
* AppBar(bottom:..)
* TabBar & TabBarView

<br/><br/>

## Hive
간단한 할일목록 관리, 연락처, DB를 통한 카운터 관리 등을 확인 할 수 있다.

<br/>

### 카운터 
> /lib/samples/database/hive/etc/counter.dart

증가 또는 감소되는 값을 프로그램에서 임시로 저장하는 방식이 아닌, 
하이브에 저장한 후 `하이브의 변화를 감지해` 값을 표시하는 방법을 확인 할 수 있다.
* 하이브 `초기화` 방법
* ValueListenableBuilder를 이용해 하이브 `테이블 데이터 변환 감지`
* 테이블을 읽고 수정하는 방법
* FloatingActionButton 2개 사용
  * HeroWidget 2개 사용시 발생할 수 있는 충돌 해결 방법 제공
* `Material Design Icons` 사용

<br/>

### 좋아하는 책 선택
> /lib/samples/database/hive/etc/favorite_book.dart

책 리스트에서 좋아하는 책에 하트를 주는 간단한 앱이지만, 
`하이브 데이터를 파일에 저장(백업)하는 방법과 복구하는 기능`을 JSON 형식으로
구현하였으며, 이를 위해 AndroidManifest.xml에 권한주는 방법등을 확인할 수 있다.
* AppBar actions
* ValueListenableBuilder
* Hive.containsKey
* ScaffoldMessenger을 이용한 SnackBar
* 하이브 데이터를 toMap()함수를 이용해 Map<K,V> 형태로 변환
* 파일 처리를 위해 AndroidManifest.xml에 권한 주기
* 여러 레코드 데이터를 하이브에 일괄 저장

<br/>

### 할일목록
> /lib/samples/database/hive/todo/todo_app.dart...

간단한 할일목록 관리 프로그램을 통해,
하이브를 플루터에서 이용하는 방법과
`테이블형 데이터`와 `Map<K,V>`형 데이터를 관리하는 방법을 확인 할 수 있음.
* 하이브 `초기화` 및 `아답터(테이블 데이터 관리용 클래스) 생성/등록` 방법
    * `hive_generator`와 `build_runner` 사용
* ValueListenableBuilder를 이용해 하이브 `테이블 데이터 변환 감지`
* 테이블 `데이터 CRUD`
* 다이얼로그 생성
* 카드 위젯과 리스트뷰 위젯을 이용한 카드 표현 방법
* 간단한 `데이터 입력 폼 처리`(TextEditingController 이용)
* `Material Design Icons` 사용

<br/>

### 연락처 
> /lib/samples/database/hive/contacts/contacts_app.dart...

다양한 형태의 입력 폼을 활용해 연락처를 관리하는 앱
* enum 형태의 데이터를 하이브 테이블로 생성
* 테이블을 리스트뷰 빌더를 이용해 관리
* InkWel(GestureDetector와 유사) 사용
* async 함수에서 context를 사용할 때 발생하는 경고 제공
* GlobalKey를 이용해 폼 제어
* 다양한 형태의 입력 폼
* enum 데이터를 활용한 드롭다운 버튼 만들기
* 폼 submit

<br/>

### 미니 그림판
> /lib/samples/database/hive/sketchpad/sketch_pad.dart...

5가지 색상을 선택해 선을 그릴 수 있는 간단한 미니 그림판.
* 사용자 정의 하이브 아답터 생성 
* GestureDetector의 `다양한 옵션` 소개
* ClipOval - 모든 위젯을 원형으로 변환하는 위젯
* 하이브 데이터 상태를 모니터링해 아이콘 활성/비활성 시킴

<br/><br/>

## Geo 데이터 처리
Geo 데이터를 처리하기 위해서는 사용자가 Geo 데이터를 처리할 수 있도록 앱에 권한를
부여해야 하며, 이렇기 위해서는 `AndroidMainfast.xml` 파일에 아래 권한을 정의해야 하고, 
프로그램에서 사용자가 권한을 줄 수 있도록 기술해야 함.
```
    <!-- geo data -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
    <!-- http or geo data -->
    <uses-permission android:name="android.permission.INTERNET"/>
```

또한 pubspec.yaml에 아래 내용을 추가해야 함.
```
    geolocator: ^9.0.2  # 20230405 현재 최신
    http: ^0.13.5       # ..
```

<br/>

### 현재 위치정보 가져오기
> /lib/samples/utils/geo/get_position/get_location.dart...

간단히 현재 위치정보를 읽어옴.
* Geo 데이터를 처리하기 위해 권한 획득 방법(AndroidManifast.xml 설정)
* FutureBuilder를 이용한 Future<T> 리턴함수 상태 모니터링
* Geo 데이터 품질 설정을 위한 'desiredAccuracy' 옵션 설정 

<br/><br/>

## Products
좀 더 다양한 기술과 내용이 들어 있는 앱들

<br/>

### 계산기1
> /lib/samples/product/calculator/calculator_app.dart

간단하지만 그래도 `공학용 전자 계산기`임.
* ConsumerWidget
* LayoutGrid
* NamedAreaGridPlacement
* AutoSizeText
* ElevatedButton vs OutlinedButton
* StateNotifier
* Parser & evaluate
* object.copyWith
* ProviderScope


<br/><br/>

# 기타

<br/>

## 안드로이드 스튜디오 설정

> Dart CodeStyle중 TabSize 조정

* ./.config/Google/AndroidStudio2021.3/codestyles/Default.xml에 아래 내용 추
```
  <codeStyleSettings language="Dart">
    <indentOptions>
      <option name="INDENT_SIZE" value="2" />
      <option name="TAB_SIZE" value="2" />
    </indentOptions>
    <option name="RIGHT_MARGIN" value="100" />
  </codeStyleSettings>
```