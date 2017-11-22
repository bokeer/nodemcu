print(wifi.sta.getip())
--nil
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="HesionPublic"
station_cfg.pwd="tsinghua"
station_cfg_1={}
station_cfg_1.ssid="Mustang"
station_cfg_1.pwd="@1024@1024"
if(wifi.sta.config(station_cfg))
then
--wifi.sta.autoconnect(1)
	print('wifi config succeed with',station_cfg.ssid)
else
	print('wifi config failed with',station_cfg.ssid)
end

wificonn_count=0
wificonn_timeout=6
function wificonn()
	if(wifi.sta.getip())
	then
		print('ip: ',wifi.sta.getip())
	else
		print('wifi not connect yet')
		wificonn_count=wificonn_count+1
		if(wificonn_count < wificonn_timeout)
		then
			tmr.start(0)
		end
		if(wificonn_count < wificonn_timeout*2)
		then
			tmr.start(0)
			if(wificonn_count == (wificonn_timeout+1))
			then
				if(wifi.sta.config(station_cfg_1))
				then
					print('wifi config succeed with',station_cfg_1.ssid)
				else
					print('wifi config failed with',station_cfg_1.ssid)
				end
			end
		else
			print('wifi connect failed finally')
		end
	end
end
function printip()
	print('ip: ',wifi.sta.getip())
end
tmr.alarm(0,3000,tmr.ALARM_SEMI,wificonn)
dofile('servo.lua')
dofile('httplight.lua')
--tmr.alarm(0, 5000, tmr.ALARM_AUTO, printip)
