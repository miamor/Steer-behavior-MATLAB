function steer = steer_arrival(vehicles, vhl, target)
  v_pos = vehicles(vhl,1:3);
  v_vel = vehicles(vhl,4:6);
  v_acc = vehicles(vhl,7:9);
  v_maxspeed = vehicles(vhl,10);
  v_maxforce = vehicles(vhl,11);  

  desired = target - v_pos;

  d = mag(desired);
  slowingRadius = 100;
  
  desired = setMag(desired, v_maxspeed); % set magnitude
  if (d < slowingRadius) 
    desired = desired * (d / slowingRadius);
  end
  
  steer = desired - v_vel;
  steer = setLimit(steer, v_maxforce); % set limit steer force
  
end