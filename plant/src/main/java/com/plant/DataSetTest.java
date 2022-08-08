package com.plant;

import javax.xml.parsers.*;
import org.w3c.dom.*;
import java.io.*;

public class DataSetTest {
    public static void main(String[] args) {

    try {
        // 팩토리 생성
        DocumentBuilderFactory dbfactory = DocumentBuilderFactory.newInstance();
        // 빌더 생성
        DocumentBuilder builder = dbfactory.newDocumentBuilder();
        // Document오브젝트 취득
        Document doc = builder.parse(new BufferedInputStream(new FileInputStream("dom.xml")));
        // 루트의 자식 노드 취득
        Element root = doc.getDocumentElement();
        System.out.println("Root : " + root.getTagName());
        // 각노드의 리스트 취득
        NodeList list = root.getElementsByTagName("log");
        System.out.println("Node List Length : " + list.getLength());
        for (int i = 0; i < list.getLength(); i++) {
            Element element = (Element) list.item(i);
            // log 태그의 day취득
            String day = element.getAttribute("day");

            if (args.length == 1) {
                if (!day.equals(args[0])) {
                    continue;
                }
            }
            NodeList eventList = element.getElementsByTagName("EVENT");

            System.out.println("day of log tag : " + day);
            for(int j=0;j< eventList .getLength(); j++) {

                Element eventEle = (Element) eventList.item(j);
                String time = getChildren(eventEle, "TIME");
                String code = getChildren(eventEle, "CODE");
                String param = getChildren(eventEle, "PARAM");
     
                System.out.println("Time  : " + time);
                System.out.println("Code : " + code);
                System.out.println("Param : " + param);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    }

 

     /**
      * 지정한 엘레멘트의 값을 취득
      * 
      * @param element
      *            Element명
      * @param tagName
      *            태그명
      * @return 취득한 내용
      */
    public static String getChildren(Element element, String tagName) {
        NodeList list = element.getElementsByTagName(tagName);
        Element cElement = (Element) list.item(0);
  
        if(cElement.getFirstChild()!=null) {
            return cElement.getFirstChild().getNodeValue(); 
        } else {
            return "";
        }
    }
}