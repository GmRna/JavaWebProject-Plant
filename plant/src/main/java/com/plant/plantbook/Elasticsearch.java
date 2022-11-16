package com.plant.plantbook;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpHost;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
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
		List<Map<String, Object>> list = getPlant("plantbook", "mainChartrInfo", "마블");
		for (Map<String, Object> map : list) {
			System.out.println(map.get("plantbook_no")+"\t"+map.get("cntntsSj")+"\t"+map.get("mainChartrInfo"));
		}
	}
	
	public static List<Map<String, Object>> getPlant(String index, String field, String sword) throws Exception {
		
		// 여러건 조회 
		HttpHost host = new HttpHost("localhost",9200);
		RestClientBuilder restClientBuilder = RestClient.builder(host);
		RestHighLevelClient client = new RestHighLevelClient(restClientBuilder);
		
		SearchRequest searchRequest = new SearchRequest(index);
		SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
		
		sourceBuilder.query(QueryBuilders.fuzzyQuery(field, sword).fuzziness(Fuzziness.ONE));
		//sourceBuilder.query(QueryBuilders.matchQuery(field, sword));
		
		searchRequest.source(sourceBuilder);
		
		// 페이징 처리 관련 -----  디폴트 10개 임 
		sourceBuilder.size(3000);
		sourceBuilder.from(0);
					
		SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
		
		//System.out.println(searchResponse.getHits().getHits()); 객체? 로 출력됨
		List<Map<String, Object>> list = new ArrayList();
		for (SearchHit sh : searchResponse.getHits().getHits()) {
			list.add(sh.getSourceAsMap());
		}
			
		for (Map<String, Object> map : list) {
			System.out.println(map.get("place_nm"));
		}
		return list;
	}
}
