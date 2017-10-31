function steer = steer_wander(vehicles, vhl)
  global wanderAngle;
  v_pos = vehicles(vhl,1:3);
  v_vel = vehicles(vhl,4:6);
  v_acc = vehicles(vhl,7:9);
  v_maxspeed = vehicles(vhl,10);
  v_maxforce = vehicles(vhl,11);
  v_max_see_ahead = vehicles(vhl,13);
  v_max_avoid_force = vehicles(vhl,14);

  CIRCLE_DISTANCE = 2;
  CIRCLE_RADIUS = 1;
  ANGLE_CHANGE = 1;
  
  circleCenter = setMag(v_vel, CIRCLE_DISTANCE);

  displacement = [0 3 0];
  %displacement = displacement*CIRCLE_RADIUS;
  displacement = setLimit(displacement, CIRCLE_RADIUS);
  %
  % Randomly change the vector direction
  % by making it change its current angle
  function vector = setAngle(vector, value) 
    len = mag(vector);
    vector(1) = cos(value) * len;
    vector(2) = sin(value) * len;
  end
  displacement = setAngle(displacement, wanderAngle);
  %
  % Change wanderAngle just a bit, so it
  % won't have the same value in the
  % next game frame.
  wanderAngle = wanderAngle + (rand() * ANGLE_CHANGE) - (ANGLE_CHANGE * .5);

  steer = circleCenter+displacement;
  
end