function steer = steer_seperation(vehicles, vhl, vNum)
  global SeperationRange;

  v_pos = vehicles(vhl,1:3);
  v_vel = vehicles(vhl,4:6);
  v_acc = vehicles(vhl,7:9);
  v_maxspeed = vehicles(vhl,10);
  v_maxforce = vehicles(vhl,11);
  %v_seperation_r = vehicles(vhl,13);
  
  desiredseparation = SeperationRange*2;
  sum = [0 0 0];
  count = 0;
  for vhl_o = 1:vNum
    % distance
    vhl_o_pos = vehicles(vhl_o,1:3);
    d = dist(v_pos, vhl_o_pos);
    if (d > 0 && d < desiredseparation)
    diff = v_pos - vhl_o_pos;
    diff = normalize(diff);
    diff = diff/d;
    sum = sum + diff;
    count = count + 1;
    end
  end
  
  steer = [0 0 0];
  
  if count > 0
    sum = sum/count;
    sum = normalize(sum);
    sum = sum*v_maxspeed;
    
    steer = sum - v_vel;
    steer = setLimit(steer, v_maxforce);
  end
end