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
		List<Map<String, Object>> list = getPlant("plantbook", "all", "참누리");
		for (Map<String, Object> map : list) {
			System.out.println("plantbook_no : "+map.get("plantbook_no")+"\t cntntsSj : "+map.get("cntntsSj")+"\t mainChartrInfo: "+map.get("mainChartrInfo"));
		}
	}
	
	public static List<Map<String, Object>> getPlant(String index, String field, String sword) 
			throws Exception {
		
		HttpHost host = new HttpHost("localhost",9200);
		RestClientBuilder restClientBuilder = RestClient.builder(host);
		RestHighLevelClient client = new RestHighLevelClient(restClientBuilder);
		
		MultiSearchRequest request = new MultiSearchRequest();
		
		SearchRequest searchRequest1 = new SearchRequest(index);
		SearchRequest searchRequest2 = new SearchRequest(index);
		
				
		if (field.equals("all")) {
			String mainChartrInfo = "mainChartrInfo";
			String cntntsSj = "cntntsSj";

			SearchSourceBuilder sourceBuilder1 = new SearchSourceBuilder();
			sourceBuilder1.query(QueryBuilders.matchQuery(mainChartrInfo, sword));

			sourceBuilder1.size(3200);
			sourceBuilder1.from(0);

			SearchSourceBuilder sourceBuilder2 = new SearchSourceBuilder();
			sourceBuilder2.query(QueryBuilders.matchQuery(cntntsSj, sword));

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
					  }
				}
				System.out.println("all @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+arrList.size());
				return arrList;
				
			}catch (IOException e) {
				System.err.println("Elastic search fail");
			}
		}
		else if(field.equals("cntntsSj")) {
			SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
			sourceBuilder.query(QueryBuilders.matchQuery(field, sword));			
			
			// 페이징 처리 관련 -----  디폴트 10개 임 
			sourceBuilder.size(3200);
			sourceBuilder.from(0);
			
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
			sourceBuilder.size(3200);
			sourceBuilder.from(0);

			searchRequest1.source(sourceBuilder);
			SearchResponse searchResponse = client.search(searchRequest1, RequestOptions.DEFAULT);
			
			List<Map<String, Object>> list = new ArrayList();
			
			for (SearchHit sh : searchResponse.getHits().getHits()) {
				list.add(sh.getSourceAsMap());
			}
			System.out.println("ma @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+sword+list.size());
			return list;
		}
		return null;
	}
}
