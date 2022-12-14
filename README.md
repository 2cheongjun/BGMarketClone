# BGMarketClone
번개장터 클론코딩 - iOS개발진행<br>

싹 라이징 프로그래머 - 번개장터 클론 프로젝트 
기간	2022.0914 ~ 0927(2주)
역할	iOS 100% 
협업	서버개발자 2명( 오리, 로저 )
서버	AWS - EC2 t2.micro
(ubuntu 22.04.1, nginx 1.18.0, spring boot, mysql 8.0.3 )
번개장터 클론코딩 시연영상 ( 번개장터 UI구현 + 서버API 연동 )
https://youtu.be/EXSXRqSSIMY
![스크린샷 2022-12-14 오후 6 38 11](https://user-images.githubusercontent.com/74134181/207560262-591b4d54-c2b6-4838-93ab-efe2a1968903.png)

<br>
<br>
▶ 번개장터 주요기능
0. 스플래시화면

1. 카카오로그인 

2. 홈화면 추천상품

3. 추천상품 상세정보

4. 상품 구매

5. 상품 등록

6. 상품등록후 상세보기

7. 판매중인 상품보기

8. 검색 (정확도순, 낮은가격순, 높은가격순)

▶ 적용한 API



1.  카카오 소셜 로그인
카카오로그인 API
카카오 로그인 연동후 받아온 토큰을 다시 우리의 서버로 보내 카카오ID, userID, JWT토큰 값을 받아와 저장 후 사용
pageController

2.  홈 화면 추천상품
추천상품 API 사용 - 다른 이용자들이 올린 상품들을 모아서 볼 수 있는 추천상품 조회
상단 배너 자동 에니메이션 적용 paingcontroller
추천상품브랜드 - tabman, collectionview

3.  상품 상세정보
메인의 상품을 눌러서 띄우는 제품상세뷰 API 
topbutton, bottomsheet, scrollview, collectionview, tableview

4.  상품 구매 UI만 구현 
5.  상품 등록,  6. 상품등록후 상세보기
상품등록 API
상품상세조회 API
카테고리 API
 UIPicker, 태그기능 TabListview, botomsheet


7.  판매중인 상품보기
판매중인 상품 API
상품을 등록하고 마이페이지로 이동하면 내가 등록한 상품 조회
collectionview, tabman

8.  검색( 정확도순,  낮은가격순,  높은가격순 )
검색API (정확도순, 낮은가격순, 높은가격순 정렬 )
홈화면 상단에 있는 검색버튼과 탭하단의 검색버튼을 누르면 상품검색을 할 수 있습니다.
tableview안에 컬렉션뷰셀 2개 사용,  notificationcenter, collectionview


▶ 2주간의 서버와의 협업 후기
✅ 서버와의 협업은 처음이어서 무엇을 어떻게 요청해야할지 부터 정하는것이 시작이었다. 작업 우선순위를 정하고 UI부터 그리기 시작했다. 어느정도 그리고 나서 API를 붙이려고하니 먼저 작업한 부분의 API가 완성되지 않은 상태여서 바로 붙일수가 없었다. 다음에는 우선적으로 하는 부분부터 미리 요청해야겠다고 다짐



✅ 카카오API를 사용전에 카카오디벨로퍼 홈페이지에서 동의항목을 체크하는데 이때 체크되지 않은 정보는 가져올수 없다. 서버와 이야기해서 어떤 데이터를 가져다 쓸지 미리 상의하고 적용해야한다.



✅ Alamofire를 사용해서 이미지와 텍스트를 업로드 하는데 나는 json으로 모두 보낼 생각 이었는데 서버에서 multifpartform형식으로 업로드를 하게끔 미리만들어 놓아서 새로운 방식을 찾아서 적용하는데 어려움이 있었다. 이 부분도 서로 이전에 협의를 하고 진행을 했어야하는데 몰라서 발생한 문제라고 생각한다. 내가 json으로 모두 보낸다고해도 서버측에서 해줘야 하는 작업이 있기 때문에 협의가 필요했다. 

추후 시간에 쫓기는 나를 고맙게도 서버측에서 배려해줘서 맞춰서 작업을 해주셨다. 



✅ API를 붙일때 포스트맨에서 하는것과 실제 클라이언트에서 요청을 보내고 서버에서 받는 것은 많은 부분이 달랐다. 테스트를 해보고 안되거나 문제가 있는지 확인해 적용한다.



▶ 새로 알게 된 것들과 생각해볼점
새로알게된것

KakaoAPI, jwt토큰 사용해보기
tabman, tagListView, bottomSheet 라이브러리 사용
tabbar의 미들버튼을 눌러 present하는 방법
네비게이션 화면이동방식과 present방식
pageController
같은 방향의 스크롤뷰를 한화면에 넣어 중첩되는 것을 지양해야한다.(컬렉션뷰와 테이블뷰)
















