function COORDS = equilateral(side, x,y, rotation)
  %EQUILATERAL- given a side length and x,y, coordinates as inputs, the
  %function plots an equilateral triangle an angle of rotation can be
  %given as an input as well. This will rotate the trianlge around the x
  %and y coordinates given.

  %rotation argument is not required. If not given, angle is 0
  if (exist('rotation','var'))
  % angle = rotation;
  % Convert the angle from deg to rad
     angle = rotation*pi/180;
  else 
     angle = 0;
  end

  %rotation matrix
  R = [cos(angle), -sin(angle); sin(angle), cos(angle)];


  x1 = x - side*0.5;
  y1 = y;

  %max horizontal x coordinate
  x2 = x + side*0.5;
  %max horiontal y coordinate (equal to original y coordinate)
  y2 = y;

  %height of the triangle at midpoint (perpendicular height)
  h = 2*side*sin(pi/3) + y;

  %coordinates of midpoint/top vertice
  mid = [x, h];

  %min coordinates
  coord1 = [x1,y1];
  %max coordinates
  coord2 = [x2,y2];


  % ------
  % Define the coord of the point aroud with to turn
  % ------
  %XR=x+side/2;
  %YR=y+h*.3;
  XR=x;
  YR=y;

  % Shift the triangle so that the rotation point coincides with the origin of the axes
    r_coord1 = (coord1-[XR YR])*R+[XR YR];
    r_coord2 = (coord2-[XR YR])*R+[XR YR];
    r_mid = (mid-[XR YR])*R+[XR YR];
    
    COORDS = [r_coord1(1) r_coord2(1) r_mid(1) r_coord1(1); 
            r_coord1(2) r_coord2(2) r_mid(2) r_coord1(2)];
