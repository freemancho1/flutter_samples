# Flutter Samples

다양한 플루터 예제를 다루고 있다.

<br/>

# 예제들

<br/>

## AppBar
숨기거나 표시하기, 펼치기, 앞뒤 아이콘 처리 등을 확인 할 수 있음.

<br/>

### 숨기거나 표시하기
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

## Hive
간단한 할일목록 관리, 연락처, DB를 통한 카운터 관리 등을 확인 할 수 있음.

<br/>

### 할일목록
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