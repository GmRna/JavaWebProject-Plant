# 가드너 예약 사이트 및 식물 커뮤니티 웹사이트 구현

- 주제 : 식물 커뮤니티 및 가드너 파견 예약 사이트 구현

- 개발환경  
  사용 언어 : JDK 11.0.15
  프레임 워크 :	Spring, MyBatis, JDBC
  데이터 베이스 : MySQL
  개발 환경 : AWS EC2, eclipse, VSCode, Apatch Tomcat, Github, elastic stack

- 개발일정
  2022.07.25 ~ 2022.09.02

- 팀원 및 기능 구현  
  R : 기본적인 게시판, 댓글형 게시판, 답글 게시판  
  P : 반려 식물 , 반려 식물 관찰 일지, 식물 도감 요청 게시판 구현, 신고 기능, 식물 품종 기능 구현, 다중 파일 저장 및 미리보기 기능 구현 ,식물 도감 엘라스틱 서치 기능 구현  
  K :가드너 파견 예약 서비스 개발 및 구현, AWS EC2, DB 관리(ubuntu mysql 서버 구동), Git 형상관리(github 레파지토리 개설), 데이터 베이스 설계(가드너 파견 예약 서비스 데이터 ERD)  
  S :일반회원/가드너 회원 회가입 개발 및 구현 , 회원 로그인 구현 및 interceptor 관리, 관리자 메뉴 개발 및 구현, 게시판 연동, DB(mysql) 데이터 수정 및 보완 DB 일반회원, 가드너, 관리자 부분 설계  

- 모델링
  MVC 패턴 2 사용
  
- 데이터 베이스 설계
  ERD Cloud : https://www.erdcloud.com/d/4EewKhexuMdpEeye9

- 화면흐름도
  https://drive.google.com/file/d/1k5Ccuftd0UYEoEttYvkQPBti3g25dr2Q/view?usp=sharing

- 기능 및 개요
  가드너 파견 예약 및 결제 서비스 구현
  식물 유저 커뮤니티 기능 구현(게시판, 관찰일지)
  회원관리 기능(회원가입, 로그인, 관리자)
  식물 검색(식물 도감)

- 참고사항
  * 전체 코드는 project 브렌치에서 확인가능
  * URL 변경 또는 권한 변경으로 위의 URL 로드되지 않을 수 있음
