package com.plant.plantbook;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpHost;
import org.elasticsearch.action.search.MultiSearchRequest;
import org.elasticsearch.action.search.MultiSearchResponse;
import org.elasticsearch.action.search.MultiSearchResponse.Item;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.unit.Fuzziness;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;

public class Elasticsearch {
	
	public static void main (String [] args) throws Exception {
		List<Map<String, Object>> list = getPlant("plantbook", "all", "사라하");
		for (Map<String, Object> map : list) {
			System.out.println("plantbook_no : "+map.get("plantbook_no")+"\t cntntsSj : "+map.get("cntntsSj")+"\t mainChartrInfo: "+map.get("mainChartrInfo"));
		}
	}
	
	public static List<Map<String, Object>> getPlant(String index, String field, String sword) throws Exception {
		
		// 여러건 조회 
		HttpHost host = new HttpHost("localhost",9200);
		RestClientBuilder restClientBuilder = RestClient.builder(host);
		RestHighLevelClient client = new RestHighLevelClient(restClientBuilder);
		
		// 필드 2개 이상 조회하기 위해서 
		MultiSearchRequest request = new MultiSearchRequest();
		
		SearchRequest searchRequest1 = new SearchRequest(index);
		SearchRequest searchRequest2 = new SearchRequest(index);
		
		String mainChartrInfo = "mainChartrInfo";
		String cntntsSj = "cntntsSj";
		
		if (field.equals("all")) {
			SearchSourceBuilder sourceBuilder1 = new SearchSourceBuilder();
			sourceBuilder1.query(QueryBuilders.fuzzyQuery(mainChartrInfo, sword).fuzziness(Fuzziness.ONE));
			sourceBuilder1.size(3200);
			sourceBuilder1.from(0);

			SearchSourceBuilder sourceBuilder2 = new SearchSourceBuilder();
			sourceBuilder2.query(QueryBuilders.fuzzyQuery(cntntsSj, sword).fuzziness(Fuzziness.ONE));

			// 페이징 처리 관련 -----  디폴트 10개 임 
			sourceBuilder2.size(3200);
			sourceBuilder2.from(0);
			
			searchRequest1.source(sourceBuilder1);
			searchRequest2.source(sourceBuilder2);
			
			request.add(searchRequest1);
			request.add(searchRequest2);
			
			try {
				MultiSearchResponse searchResponse = client.msearch(request, RequestOptions.DEFAULT);
				List <Map<String, Object>> arrList = new ArrayList<>();
				
				for(Item i:searchResponse.getResponses()) {
					for(SearchHit s:i.getResponse().getHits().getHits()) {
						  Map<String, Object> sourceMap = s.getSourceAsMap();
						  arrList.add(sourceMap);
						  System.out.println(sourceMap.get("plantbook_no"));
					  }
				}
				return arrList;
				
			}catch (IOException e) {
				System.err.println("Elastic search fail");
			}
		}
		//sourceBuilder.query(QueryBuilders.matchQuery(field, sword));
		return null;
		
	
					
		//SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
		
		//System.out.println(searchResponse.getHits().getHits()); 객체? 로 출력됨
		/*List<Map<String, Object>> list = new ArrayList();
		for (SearchHit sh : searchResponse.getHits().getHits()) {
			list.add(sh.getSourceAsMap());
		}
			
		for (Map<String, Object> map : list) {
			System.out.println(map.get("place_nm"));
		}
		return list;*/
	}
}
