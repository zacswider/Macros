

getLine(x1, y1, x2, y2, lineWidth);

angle = getAngle(x1, y1, x2, y2);

x_values = newArray(x1, x2);
y_values = newArray(y1, y2);

Array.getStatistics(x_values, x_min, x_max);
Array.getStatistics(y_values, y_min, y_max);

top_left_x = x_min - 100 ; 
top_left_y = y_min - 100 ;
x_distance = x_max - x_min + 200 ;
y_distance = y_max - y_min + 200 ;

makeRectangle(top_left_x, top_left_y, x_distance, y_distance);

run("Duplicate...", " ");
Stack.setChannel(2);
run("Delete Slice", "delete=channel");
run("Rotate... ", "angle=" + angle + " grid=1 interpolation=Bicubic");

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