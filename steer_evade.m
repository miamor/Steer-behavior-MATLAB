function steer = steer_evade(vehicles, vhl, target, target_velocity)
  v_pos = vehicles(vhl,1:3);
  v_vel = vehicles(vhl,4:6);
  v_acc = vehicles(vhl,7:9);
  v_maxspeed = vehicles(vhl,10);
  v_maxforce = vehicles(vhl,11);  

  desired = target - v_pos;

  %T = 13; % change this to see the effects more obviously
  T = mag(desired)/v_maxspeed;
  futurePosition = target + target_velocity*T;
  
  steer = steer_flee(vehicles, vhl, futurePosition, 100);
  
end