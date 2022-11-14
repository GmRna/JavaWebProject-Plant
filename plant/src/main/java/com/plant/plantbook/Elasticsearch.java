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
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;

public class Elasticsearch {
	public static Map<String, Object> getPlant(String sword) throws Exception {
		
		HttpHost host = new HttpHost("localhost",9200);
		RestClientBuilder restClientBuilder = RestClient.builder(host);
		RestHighLevelClient client = new RestHighLevelClient(restClientBuilder);
		
		SearchRequest searchRequest = new SearchRequest("seoul_wifi");
		SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
		sourceBuilder.query(QueryBuilders.matchQuery("place_nm", "도서관"));
		
		searchRequest.source(sourceBuilder);
		
		SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
		
		//System.out.println(searchResponse.getHits().getHits()); 객체? 로 출력됨
		List<Map<String, Object>> list = new ArrayList();
		for (SearchHit sh : searchResponse.getHits().getHits()) {
			list.add(sh.getSourceAsMap());
		}
			
		for (Map<String, Object> map : list) {
			System.out.println(map.get("place_nm"));
		}
		return null;
	}
}
