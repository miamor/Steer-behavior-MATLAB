function steer = steer_seek(vehicles, vhl, target)
  v_pos = vehicles(vhl,1:3);
  v_vel = vehicles(vhl,4:6);
  v_acc = vehicles(vhl,7:9);
  v_maxspeed = vehicles(vhl,10);
  v_maxforce = vehicles(vhl,11);  

  desired = target - v_pos;
  desired = setMag(desired, v_maxspeed); % set magnitude
  
  steer = desired - v_vel;
  steer = setLimit(steer, v_maxforce); % set limit steer force
  
end