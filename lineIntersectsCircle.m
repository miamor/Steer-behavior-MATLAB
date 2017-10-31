function checkIntersect = lineIntersectsCircle(ahead, ahead2, obstacle) 
  % obstacle
  % 1-3: center
  % 4: radius
  if ( dist(obstacle(1:3), ahead) <= obstacle(4) || dist(obstacle(1:3), ahead2) <= obstacle(4) )
    checkIntersect = 1;
  else 
    checkIntersect = 0;
  end
end