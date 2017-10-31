function Behaviour__Flock (vehicles,vNum)
  %% global variables
  global TimeSteps;

  %% first draw
  [v_Image,v_Alpha,VehiclesPlot,fHandler] = InitializeGraphics(vehicles,vNum);

  %% calculate vehicles' positions to move to each iteration
  timeTick = 1;
  while (timeTick < TimeSteps)
    for vhl = 1:vNum
      % steering
      boundaries_force = steer_boundaries(vehicles, vhl);
      seperation_force = steer_seperation(vehicles, vhl, vNum);
      alignment_force = steer_alignment(vehicles, vhl, vNum);
      cohesion_force = steer_cohesion(vehicles, vhl, vNum);
      % total force
      force = seperation_force*1.5 + alignment_force*2 + cohesion_force*1 + boundaries_force;
      % apply force (calculate new position)
      vehicles = applyForce(vehicles, vhl, force);
    end
    % redraw
    RedrawGraphics(vehicles,vNum,v_Image,v_Alpha,VehiclesPlot);
    timeTick = timeTick+1;
  end
end