package com.plant;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class DataSet {
	  
	  @Autowired
	  private DbSetMapper dbSetMapper;
	  
	  @Autowired
	  DataVO vo;

	  public static int PAGE_SIZE = 366;
	  public static String URL = "https://apis.data.go.kr/1390804/NihhsTodayFlowerInfo01/selectTodayFlowerView01";
	  public static String URL2 = "https://apis.data.go.kr/1390804/NihhsTodayFlowerInfo01/selectTodayFlowerView01";
	  public static String SERVICE_KEY = "IzZ1ERXpwQ%2BahxPK9xPLgMYipy4G3SkIRRj4%2F8ITTaLJGKwRWdlqjOt77SIAAZvKytmH5zFPZyAdNvZFddlwZg%3D%3D";


	  public void update() throws Exception {    
	    int result = 0; 
	    List<Map<String, String>> list = new ArrayList<>();

	    try {
	      // 오늘의 꽃 목록 읽어오기
	      createDocument(list);

	      for (Map<String, String> acadInfo : list) {
	        createDetailInfo(acadInfo);

	        result += dbSetMapper.apiInsert(vo);
	      }
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    System.out.println("총 오늘의 꽃 갯수:" + result);
	  }

	  //tag값 정보를 가져오는 메소드
	  private static String getTagValue(String tag, Element eElement) {
	    NodeList nList = null;
	    Node nValue = null;
	    try {
	      nList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	      nValue = (Node) nList.item(0);
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    if (nValue == null)
	      return null;
	    return nValue.getNodeValue();
	  }

	  private void createDetailInfo(Map<String, String> acadInfo) {
	    Document documentInfo = null;
	    // 파싱할 url 지정
	    String parseUrl =
	        URL2 + "?returnType=XML&authKey=" + SERVICE_KEY + "&srchTrprId=" + acadInfo.get("trainCd")
	            + "&srchTrprDegr=" + acadInfo.get("trainDegr") + "&outType=2&srchTorgId=default";
	    try {
	      documentInfo =
	          (Document) DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(parseUrl);
	      //root tag
	      documentInfo.getDocumentElement().normalize();
	      // 과정,기관정보 데이터 파싱
	      parseDetailXml(documentInfo.getDocumentElement(), acadInfo);
	    } catch (SAXException e) {
	      e.printStackTrace();
	    } catch (IOException e) {
	      e.printStackTrace();
	    } catch (ParserConfigurationException e) {
	      e.printStackTrace();
	    }

	  }

	  private void parseDetailXml(Element root, Map<String, String> map) {
	    Node nNode = root.getElementsByTagName("inst_base_info").item(0);
	    Element eElement = (Element) nNode;

	    map.put("address", getTagValue("addr1", eElement)); // 상세주소
	    map.put("url", getTagValue("hpAddr", eElement)); // 학원홈페이지url

	  }

	  private void parseXml(Element root, List<Map<String, String>> list) {
	    NodeList nList = root.getElementsByTagName("srchList").item(0).getChildNodes();

	    for (int i = 0; i < nList.getLength(); i++) {
	      Map<String, String> map = new HashMap<>();
	      Node nNode = nList.item(i);
	      Element eElement = (Element) nNode;

	      map.put("trainCd", getTagValue("trprId", eElement)); // 과정코드
	      map.put("trainTitle", getTagValue("title", eElement)); // 과정명
	      map.put("acadCd", getTagValue("instCd", eElement)); // 학원코드
	      map.put("acadTitle", getTagValue("subTitle", eElement)); // 학원명
	      map.put("telNo", getTagValue("telNo", eElement)); // 학원 전화번호
	      map.put("startDate", getTagValue("traStartDate", eElement)); // 훈련시작일자
	      map.put("endDate", getTagValue("traEndDate", eElement)); // 훈련종료일자
	      map.put("target", getTagValue("trainTarget", eElement)); // 훈련대상
	      map.put("yardMan", getTagValue("yardMan", eElement)); // 정원
	      map.put("courseMan", getTagValue("courseMan", eElement)); // 수강비
	      map.put("realMan", getTagValue("realMan", eElement)); // 실제 수강비
	      map.put("trainDegr", getTagValue("trprDegr", eElement)); // 회차

	      list.add(map);
	    }
	  }

	  private void createDocument(List<Map<String, String>> list) {
	    Document documentInfo = null;
	    int pageNum = 1;
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	    Date currentDate = new Date();
	    Calendar cal = Calendar.getInstance();
	    cal.setTime(currentDate);
	    // 현재날짜로부터 3개월뒤 날짜 설정
	    cal.add(Calendar.MONTH, 3);
	    String stDt = formatter.format(currentDate);
	    String endDt = formatter.format(cal.getTime());
	    // URL 설정
	    String parseUrl = URL + "?returnType=XML&authKey=" + SERVICE_KEY + "&pageSize=" + PAGE_SIZE
	        + "&srchTraStDt=" + stDt + "&srchTraEndDt=" + endDt
	        + "&outType=1&sort=ASC&sortCol=TR_STT_DT&crseTracseSe=C0055,C0054,C0059&srchKeco1=20&pageNum=";

	    try {
	      int tot = 0, num = 1;
	      while (true) {
	        if (pageNum > num)
	          break;
	        documentInfo = (Document) DocumentBuilderFactory.newInstance().newDocumentBuilder()
	            .parse(parseUrl + pageNum);
	        documentInfo.getDocumentElement().normalize();
	        if (pageNum == 1) {
	          // 총 학원 갯수
	          tot = Integer.parseInt(getTagValue("scn_cnt", documentInfo.getDocumentElement()));
	          num = (tot / PAGE_SIZE) + 1;
	        }
	        // 목록 정보 데이터 파싱하기
	        parseXml(documentInfo.getDocumentElement(), list);

	        pageNum++;
	      }
	    } catch (SAXException e) {
	      e.printStackTrace();
	    } catch (IOException e) {
	      e.printStackTrace();
	    } catch (ParserConfigurationException e) {
	      e.printStackTrace();
	    }
	  }
}
