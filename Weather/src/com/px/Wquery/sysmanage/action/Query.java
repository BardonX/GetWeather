package com.px.Wquery.sysmanage.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * @ClassName: Query
 * @Description: 天气查询类
 * @author: Bardon
 * @date: 2017年5月7日 下午12:58:07
 * @version1.0
 */
public class Query extends HttpServlet {

	private static final long serialVersionUID = 1L;
	/**
	 * 调用查询接口
	 * 可详解csdn
	 * @Title: getResult
	 * @Author: Bardon
	 * @Time: 2017年5月7日 下午1:26:51
	 * @params: @param city
	 * @params: @return
	 * @return: String
	 * @throws
	 */
	public static String getResult(String city){
		//天气请求地址
		//String queryUrl="http://apis.haoservice.com/weather?cityname="+city+"&key=0e5e7e39492b4c5c8afe02dfc2bc72c3";
		BufferedReader bufferedReader=null;
		StringBuffer sbuffer=new StringBuffer();
		try {
			String cityname=URLEncoder.encode(city, "utf-8");
			String queryUrl="http://apis.haoservice.com/weather?cityname="+cityname+"&key=0e5e7e39492b4c5c8afe02dfc2bc72c3";
			URL url=new URL(queryUrl);
			URLConnection connection=url.openConnection();
			//connection.getInputStream();
			//InputStreamReader inputStream=new InputStreamReader(connection.getInputStream(),"utf-8");
			InputStream inputStream=connection.getInputStream();
			bufferedReader = new BufferedReader(new InputStreamReader(inputStream,"utf-8"));
			String line="";
			while((line=bufferedReader.readLine())!=null){
				sbuffer.append(line);
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try {
				if(bufferedReader!=null){
					bufferedReader.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return sbuffer.toString();
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		String city=req.getParameter("city");
		String result=getResult(city);
		resp.getWriter().print(result);
	}
	
	public static void main(String[] args) {
		System.out.println(getResult("武汉"));
	}
}
