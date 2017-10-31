function steer = steer_collision_avoidance(vehicles, vhl, obstacles, obstaclesNum, target)
  v_pos = vehicles(vhl,1:3);
  v_vel = vehicles(vhl,4:6);
  v_acc = vehicles(vhl,7:9);
  v_maxspeed = vehicles(vhl,10);
  v_maxforce = vehicles(vhl,11);
  v_max_see_ahead = vehicles(vhl,13);
  v_max_avoid_force = vehicles(vhl,14);

  function mostThreatenObstacle = findMostThreateningObstacle()
    mostThreatenObstacle = [0 0 0];
 
    for i = 1:obstaclesNum
        obstacle = obstacles(i,:); % obstacles row ith
        collision = lineIntersectsCircle(ahead, ahead2, obstacle);
 
        if (collision == 1 && (~any(mostThreatenObstacle) || dist(v_pos, obstacle(1:3)) < dist(v_pos, mostThreatenObstacle(1:3))) )
            mostThreatenObstacle = obstacle;
        end
    end
  end
  
  ahead = v_pos + normalize(v_vel) * v_max_see_ahead;
  ahead2 = v_pos + normalize(v_vel) * v_max_see_ahead * 0.5;

  mostThreatening = findMostThreateningObstacle();
  avoidance = [0 0 0];
 
  %if (mostThreatening != null) 
  if (any(mostThreatening))  % if mostThreatening not 0-matrix
    avoidance(1) = ahead(1) - mostThreatening(1);
    avoidance(2) = ahead(2) - mostThreatening(2);
 
    avoidance = setMag(avoidance, v_max_avoid_force);
  else 
    avoidance = setMag(avoidance, 0);
  end
  
  steer = avoidance;
  
end