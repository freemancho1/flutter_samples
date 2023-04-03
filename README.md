# Flutter Samples

다양한 플루터 예제를 다루고 있다.
<br/>

# 예제들

## AppBar
숨기거나 표시하기, 펼치기, 앞뒤 아이콘 처리 등을 확인 할 수 있음.

### 숨기거나 표시하기
본문의 리스트에 컨트롤러를 장착해, 
리스트의 위치와 상관없이 단순히 상하 움직임만 감지해
앱바를 숨기거나 표시하는 애니메이션 구현
* ScrollController를 이용해 리스트뷰의 이동방향을 체크
* PreferredSize 위젯을 이용한 AppBar 구현
* AnimatedCrossFade를 이용해 두개의 위젯을 교차 표시
* ListView.separated의 빌더를 이용해 아이템과 분리자 생성
* leading 부분 아이콘 및 액션 변경하는 방법

