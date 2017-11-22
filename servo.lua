pwm.setup(1, 50, 0)
pwm.start(1)
function servo_angle( angle )
	if (angle>180)
	then
		angle=180
	elseif (angle<0)
	then
		angle=0
	end
	pwm.setduty(1,angle*102/180+25.6)
end