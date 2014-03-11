def rec_intersection(rect1, rect2)
	left = [rect1[0][0], rect2[0][0]].max
	bottom = [rect1[0][1], rect2[0][1]].max
	right = [rect1[1][0], rect2[1][0]].min
	top = [rect1[1][1], rect2[1][1]].min
	if (right > left) && (top > bottom)
		return [[left,bottom],[right,top]]
	else
		return nil
	end
end
