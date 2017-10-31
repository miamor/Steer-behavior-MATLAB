function vehicles = applyForce(vehicles, vhl, steer)
  %add steer force to acceleration
  v_pos = vehicles(vhl,1:3);
  v_vel = vehicles(vhl,4:6);
  v_acc = vehicles(vhl,7:9);
  v_maxspeed = vehicles(vhl,10);
  v_maxforce = vehicles(vhl,11);
  v_angle = vehicles(vhl,12);
  
  v_acc = v_acc + steer;
  v_vel = v_vel + v_acc;
  v_vel = setLimit(v_vel, v_maxspeed);
  v_pos = v_pos + v_vel;
  

  v_angle = (asin(abs(v_vel(1) / (0.01 + norm([v_vel(1),v_vel(2)])))) * 180 / pi) - 180;
  if v_vel(1) >= 0
    if v_vel(2) <= 0
      v_angle = -v_angle;
    else
      v_angle = 180 + v_angle;
    end
  else 
    if v_vel(2) > 0
      v_angle = 180 - v_angle;
    end
  end  
    
  % reset acceleration
  v_acc = [0 0 0];
  
  vehicles(vhl,4:6) = v_vel;
  vehicles(vhl,1:3) = v_pos;
  vehicles(vhl,7:9) = v_acc;
  vehicles(vhl,12) = v_angle;
  
end