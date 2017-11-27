pwm.setup(8, 50, 0)
pwm.start(8)
function servo_angle( angle )
	if (angle>180)
	then
		angle=180
	elseif (angle<0)
	then
		angle=0
	end
	
	pwm.setduty(8,angle*102/180+25.6)
end
angle_on = 80
angle_off = 140
angle_middle = 110
angle_off_max =130
angle_on_max = 88
light_state = false
function LightOn()
	pwm.start(8)
	servo_angle(angle_off_max)
	tmr.alarm(1,500,tmr.ALARM_SINGLE,function ()
		servo_angle(angle_on)
		print(angle_on)
		tmr.alarm(2,500,tmr.ALARM_SINGLE,function ()
			servo_angle(angle_middle)
			print(angle_middle)
			light_state = true
			tmr.alarm(3,500,tmr.ALARM_SINGLE,function ()
			pwm.stop(8)
			end)
		end)
	end)
end
function LightOff()
	pwm.start(8)
	servo_angle(angle_on_max)
	tmr.alarm(1,500,tmr.ALARM_SINGLE,function ()
		servo_angle(angle_off)
		print(angle_off)
		tmr.alarm(2,500,tmr.ALARM_SINGLE,function ()
			servo_angle(angle_middle)
			print(angle_middle)
			light_state = false
			tmr.alarm(3,500,tmr.ALARM_SINGLE,function ()
			pwm.stop(8)
			end)
		end)
	end)
end