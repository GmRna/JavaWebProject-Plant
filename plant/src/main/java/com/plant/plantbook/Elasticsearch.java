package com.plant.plantbook;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpHost;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;


public class Elasticsearch {
	
	public static void main (String [] args) throws Exception {
		List<Map<String, Object>> list = getPlant("plantbook", "all", "참누리", 1, 10);
		for (Map<String, Object> map : list) {
			System.out.println("plantbook_no : "+map.get("plantbook_no")+"\t cntntsSj : "+map.get("cntntsSj")+"\t mainChartrInfo: "+map.get("mainChartrInfo"));
		}
	}
	
	public static List<Map<String, Object>> getPlant(String index, String field, 
			String sword, int page, int size) 
			throws Exception {
		
		HttpHost host = new HttpHost("localhost",9200);
		RestClientBuilder restClientBuilder = RestClient.builder(host);
		
		RestHighLevelClient client = new RestHighLevelClient(restClientBuilder);
		
		SearchRequest searchRequest1 = new SearchRequest(index);
		
		// 주요 특성
		String mainChartrInfo = "mainChartrInfo";
		// 품종 명
		String cntntsSj = "cntntsSj";
		
		
		if (field.equals("all")) {
			SearchSourceBuilder sourceBuilder1 = new SearchSourceBuilder();
			sourceBuilder1.query(QueryBuilders.multiMatchQuery(sword, mainChartrInfo, cntntsSj));

			sourceBuilder1.size(size);
			sourceBuilder1.from(page);
			
			searchRequest1.source(sourceBuilder1);
			
			SearchResponse searchResponse = client.search(searchRequest1, RequestOptions.DEFAULT);
			
			List <Map<String, Object>> list = new ArrayList<>();
			
			for (SearchHit sh : searchResponse.getHits().getHits()) {
				list.add(sh.getSourceAsMap());
			}
			System.out.println("all @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+list.size());
			return list;
		}
		else if(field.equals("cntntsSj")) {
			SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
			sourceBuilder.query(QueryBuilders.matchQuery(field, sword));			
			
			// 페이징 처리 관련 -----  디폴트 10개 임 
			sourceBuilder.size(4000);
			sourceBuilder.from(page);
			
			searchRequest1.source(sourceBuilder);
			SearchResponse searchResponse = client.search(searchRequest1, RequestOptions.DEFAULT);
			
			List<Map<String, Object>> list = new ArrayList();
			
			for (SearchHit sh : searchResponse.getHits().getHits()) {
				list.add(sh.getSourceAsMap());
			}
			System.out.println("cntntsSj @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+sword+list.size());
			return list;
		}
		
		else {
			SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
			sourceBuilder.query(QueryBuilders.matchQuery(field, sword));
			
			// 페이징 처리 관련 -----  디폴트 10개 임 
			sourceBuilder.size(4000);
			sourceBuilder.from();

			searchRequest1.source(sourceBuilder);
			SearchResponse searchResponse = client.search(searchRequest1, RequestOptions.DEFAULT);
			
			List<Map<String, Object>> list = new ArrayList();
			
			for (SearchHit sh : searchResponse.getHits().getHits()) {
				list.add(sh.getSourceAsMap());
			}
			System.out.println("ma @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+sword+list.size());
			return list;
		}
	}

	public static Map getPaging(List<Map<String, Object>> list) {
		PlantBookVO vo = new PlantBookVO();
		
		int totalCount = list.size();
		int totalPage = totalCount / vo.getPageRow();
		
		if ( totalCount % vo.getPageRow() > 0 ) totalPage++;
		
		int startIdx = (vo.getPage()-1) * vo.getPageRow();
		
		vo.setStartIdx(startIdx);

		int endPage = (int)(Math.ceil(vo.getPage()/10.0)*10);
		int startPage = endPage-9;
		if (endPage > totalPage) endPage = totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;
		
		Map map = new HashMap();
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("prev", prev);
		map.put("next", next);
		map.put("list", list);
		
		System.out.println(" totalCount " + totalCount + " " + totalPage + " " + startPage + " " + endPage);
		return map;
	}
}