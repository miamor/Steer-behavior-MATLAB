function steer = steer_alignment(vehicles, vhl, vNum)
  global AlignmentRange;

  v_pos = vehicles(vhl,1:3);
  v_vel = vehicles(vhl,4:6);
  v_acc = vehicles(vhl,7:9);
  v_maxspeed = vehicles(vhl,10);
  v_maxforce = vehicles(vhl,11);

  steer = [0 0 0];
  
  sum = [0 0 0];
  count = 0;
  for vhl_o=1:vNum 
    vhl_o_pos = vehicles(vhl_o,1:3);
    vhl_o_vel = vehicles(vhl_o,4:6);
    d = dist(v_pos, vhl_o_pos);
    if ((d > 0) && (d < AlignmentRange)) 
      sum = sum + vhl_o_vel;
      count = count+1;
    end
  end
  
  if (count > 0) 
    sum = sum/count;
    sum = normalize(sum);
    sum = sum*v_maxspeed;
    steer = sum - v_vel;
    steer = setLimit(steer, v_maxforce);
  end
  
end