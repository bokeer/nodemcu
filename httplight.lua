htmlcode_ON =[[<!DOCTYPE html><html><head><meta http-equiv="content-type" content="text.html;charset=utf-8"><title>Light</title><style>*{margin-top: 60px;padding: 0;}html{background: #f7f7f7 url(http://css-tricks.com/examples/RoundButtons/images/bg.png) repeat center top;}.nav{list-style:none;text-align:center;}.nav li{position:relative;display:inline-block;margin-right:-4px;}.nav li:before{display: block;border-top: 1px solid #ddd;border-bottom: 1px solid #fff;width: 100%;height:1px;position:absolute;top:50%;z-index:-1;}.nav a:link, .nav a:visited{display: block;text-decoration: none;background-color:#f7f7f7;-webkit-tap-highlight-color:rgba(0,0,0,0);background-image:-webkit-linear-gradient(top, #f7f7f7, #e7e7e7); color: #a7a7a7;margin: 36px;width: 300px;height: 300px;position:relative;text-align:center;line-height:300px;border-radius:50%;box-shadow: 0px 3px 8px #aaa,inset 0px 2px 3px #fff;border: solid 1px transparent;font-size: 60px;}.nav a:before {content:"";display: block;background: #fff;border-top: 2px solid #ddd;position: absolute;top: -18px;  left: -18px;bottom: -18px;right: -18px;z-index: -1;border-radius: 50%;box-shadow: inset 0px 8px 48px #ddd;}.nav a:active {box-shadow: none;border: solid 1px #a7a7a7;}</style></head><body><nav><ul class="nav"><li><a href="/light/on">开</a></li></ul></nav></body></html>]]
htmlcode_OFF =[[<!DOCTYPE html><html><head><meta http-equiv="content-type" content="text.html;charset=utf-8"><title>Light</title><style>*{margin-top: 60px;padding: 0;}html{background: #f7f7f7 url(http://css-tricks.com/examples/RoundButtons/images/bg.png) repeat center top;}.nav{list-style:none;text-align:center;}.nav li{position:relative;display:inline-block;margin-right:-4px;}.nav li:before{display: block;border-top: 1px solid #ddd;border-bottom: 1px solid #fff;width: 100%;height:1px;position:absolute;top:50%;z-index:-1;}.nav a:link, .nav a:visited{display: block;text-decoration: none;background-color:#f7f7f7;-webkit-tap-highlight-color:rgba(0,0,0,0);background-image:-webkit-linear-gradient(top, #f7f7f7, #e7e7e7); color: #a7a7a7;margin: 36px;width: 300px;height: 300px;position:relative;text-align:center;line-height:300px;border-radius:50%;box-shadow: 0px 3px 8px #aaa,inset 0px 2px 3px #fff;border: solid 1px transparent;font-size: 60px;}.nav a:before {content:"";display: block;background: #fff;border-top: 2px solid #ddd;position: absolute;top: -18px;  left: -18px;bottom: -18px;right: -18px;z-index: -1;border-radius: 50%;box-shadow: inset 0px 8px 48px #ddd;}.nav a:active {box-shadow: none;border: solid 1px #a7a7a7;}</style></head><body><nav><ul class="nav"><li><a href="/light/off">关</a></li></ul></nav></body></html>]]
srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
	conn:on("receive", function(sck, payload)
		print(payload)
		path = string.gsub(payload, "GET%s+(.+)%s+HTTP.*", "%1")
		print(path)
		if (path == "/")
		then
			if(light_state)
			then 
				sck:send(htmlcode_ON)
			else
				sck:send(htmlcode_OFF)
			end
		elseif (path == "/light/on")
		then
			sck:send(htmlcode_OFF)
			LightOff()
		elseif(path == "/light/off")
		then
			sck:send(htmlcode_ON)
			LightOn()
		else
			print(path, " not supported")
			sck:send("HTTP/1.1 404 Not Found\r\nContent-Type: text/html\r\n\r\n<h1>Not Found</h1>")
		end
	end)
	conn:on("sent", function(sck) sck:close() end)
end)