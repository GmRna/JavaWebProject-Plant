package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class getToken {

	// 토큰발급
	public static String getToken(
		HttpServletRequest request
		, HttpServletResponse response
		, JSONObject json
		, String requestURL) throws Exception{

		// requestURL 아임포트 고유키, 시크릿 키 정보를 포함하는 url 정보 
		String _token = "";
		try{
			String requestString = "";
			URL url = new URL(requestURL);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
				
			connection.setDoOutput(true);
				
			connection.setInstanceFollowRedirects(false);
				
			connection.setRequestMethod("POST");
				
			connection.setRequestProperty("Content-Type", "application/json");
				
			OutputStream os= connection.getOutputStream();
				
			os.write(json.toString().getBytes());
			
			connection.connect();
			
			StringBuilder sb = new StringBuilder();

			if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {

				BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));

				String line = null;

				while ((line = br.readLine()) != null) {

						sb.append(line + "\n");

				}

				br.close();

				requestString = sb.toString();

			}

			os.flush();

			connection.disconnect();

			JSONParser jsonParser = new JSONParser();

			JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);

			if((Long)jsonObj.get("code") == 0){

				JSONObject getToken = (JSONObject) jsonObj.get("response");

				System.out.println("getToken==>>"+getToken.get("access_token") );

				_token = (String)getToken.get("access_token");

			}

		} catch (Exception e){

			e.printStackTrace();

			_token = "";

		}

		return _token;

	}
}
