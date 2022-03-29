

getLine(x1, y1, x2, y2, lineWidth);

angle = getAngle(x1, y1, x2, y2);

print(angle);

function getAngle(x1, y1, x2, y2) {
  q1=0; q2orq3=2; q4=3; //quadrant
  dx = x2-x1;
  dy = y1-y2;
  if (dx!=0)
      angle = atan(dy/dx);
  else {
      if (dy>=0)
          angle = PI/2;
      else
          angle = -PI/2;
  }
  angle = (180/PI)*angle;
  if (dx>=0 && dy>=0)
       quadrant = q1;
  else if (dx<0)
      quadrant = q2orq3;
  else
      quadrant = q4;
  if (quadrant==q2orq3)
      angle = angle+180.0;
  else if (quadrant==q4)
      angle = angle+360.0;
  return angle;
}