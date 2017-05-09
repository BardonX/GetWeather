<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<style type="text/css">
			*{margin: 0;padding: 0;}
			.video{width: 100%;height: 100%;position: absolute;overflow: hidden;}
			.video video{width: 100%;height: 100%;object-fit: cover;}
			.content{width: 100%;height: 100%;position: absolute;z-index: 1;}/*background: rgba(255,255,255,.3);*/
			
			.message{width: 800px;height: 200px;background: rgba(0,0,0,.2);margin: 100px auto 0;}
			.m_query{height: 30px; float: right;line-height: 30px;}/*background: red;*/
			.date{float: left;}
			.city{float: left;margin: 0 30px;}
			.input{float: left;width: 160px;height: 18px;outline: none;border: 1px solid #fff;
			margin-top: 5px;}
			.btn{float: left;width: 40px;height: 20px; background: rgba(255,255,255,.5);text-align: center;
			line-height: 20px;margin-top: 5px;font-size: 14px;color: #000; text-decoration: none;}
			.m_details{width: 100%;height: 160px;float: left;} /*background: red;*/
			.d_left{width: 300px;height: 160px;float: left;font-size: 170px;}/*background: red;*/
			.d_right{width: 500px;float: right;margin-top: 120px;font-size: 18px;line-height: 26px;}/*background: blue;*/
			.l_bum{width: ;height: ;float: left;line-height: 160px;}
			.l_nav{width: ;height: ;float: left; font-size: 80px;}
			.r_weather{float: left;}
			.r_wind{float: left;margin: 0 100px;background: url(img/i_wind.png) no-repeat;text-indent: 25px;}
			.r_humidity{float: left;background: url(img/i_water.png)no-repeat;text-indent: 25px;}/*text-indent: 25px;  间距*/
		    .text{width: 800px; height: 200px;background: url(img/text.png)no-repeat;text-align: center;
		     margin: 0 auto;}
		     
		     #more{width 100%;height: 30px;}
		     .m_detail{height: 300px;background: rgba(0,0,0,.2);margin: 0 auto; display: table;}
		     .m_detail ul li{list-style: none; width: 118px; height: 250px; float: left;margin: 25px 0;}
		     .m_detail ul li div{width: 100%; height: 50px; text-align: center;line-height: 50px;}
		</style>
	</head>
	<body>
		<div class="video">
			<video width="" height="" preload="metadata" autoplay="autoplay" loop="loop" src="mp4/video.mp4">
				<!--<source src="myvideo.mp4" type="video/mp4"></source>
				<source src="myvideo.ogv" type="video/ogg"></source>
				<source src="myvideo.webm" type="video/webm"></source>
				<object width="" height="" type="application/x-shockwave-flash" data="myvideo.swf">
					<param name="movie" value="myvideo.swf" />
					<param name="flashvars" value="autostart=true&amp;file=myvideo.swf" />
				</object>
				当前浏览器不支持 video直接播放，点击这里下载视频： <a href="myvideo.webm">下载视频</a>-->
			</video>
		</div>
		
		<div class="content">
			<div class="message">
				<div class="m_query">
					<div class="date">2017年05月07日</div>
					<div class="city">武汉</div>
					<input class="input" name="" type="text" value="" />
					<a href="#" class="btn">查询</a>
				</div>
				<div class="m_details">
					<div class="d_left">
						<div class="l_bum">50</div>
						<div class="l_nav">°</div>
					</div>
					<div class="d_right">
						<div class="r_weather">晴</div>
						<div class="r_wind">东南风</div>
						<div class="r_humidity">90</div>
					</div>
				</div>
			</div>
			<div class="text"></div>
			<div id="more">
				<div class="m_detail">
					<ul>
					<!-- 	<li></li> -->
					</ul>
				</div>
			</div>
		</div>
				<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
		<script>
			$(function(){
				function query(city){
					$.ajax({
						type:"post",
						url:"query",
						data:{
							"city":city
						},
						success:function(data){
							data=$.parseJSON(data);
							if(data.error_code==0){
								var date=data.result.today.date_y;
								var city=data.result.today.city;
								var temp=data.result.sk.temp;
								var weather=data.result.today.weather;
								var wind_direction=data.result.sk.wind_direction;
								var wind_strength=data.result.sk.wind_strength;
								var humidity=data.result.sk.humidity;
								$(".date").html(date);
								$(".city").html(city);
								$(".l_bum").html(temp);
								$(".r_weather").html(weather);
								$(".r_wind").html(wind_direction+wind_strength);
								$(".r_humidity").html("湿度：&nbsp;"+humidity);
								
								var mores=data.result.future;
								$(".m_detail ul li").remove();
								for(var i=0;i<mores.length;i++){
									var weather=mores[i].weather;
									var temperature=mores[i].temperature;
									var wind=mores[i].wind;
									var week=mores[i].week;
									var date=mores[i].date;
									var month=date.substring(4,6);
									var day=date.substring(6,8);
									/* var month="不能分割";
									var day="不能分割"; */
									var li=$("<li></li>");
									li.append("<div>"+month+"&nbsp;/&nbsp;"+day+"</div>");
									li.append("<div>"+week+"</div>");
									li.append("<div>"+weather+"</div>");
									li.append("<div>"+temperature+"°&nbsp;</div>");
									li.append("<div>"+wind+"</div>");
									$(".m_detail ul").append(li);
								}
							} else{
								alert("请输入正确的城市名字");
							}
						}
					});
				}
				$(".btn").click(function(){
					var city=$(".input").val();
					query(city);
				});
			});
			
		</script>
	</body>
</html>

