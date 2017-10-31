function Behaviour__Wander (vehicles,vNum)
  %% global variables
  global TimeSteps;

  %% first draw
  [v_Image,v_Alpha,VehiclesPlot,fHandler] = InitializeGraphics(vehicles,vNum);

  %% calculate vehicles' positions to move to each iteration
  timeTick = 1;
  while (timeTick < TimeSteps)
    for vhl = 1:vNum
      % steering
      force = steer_wander(vehicles, vhl);
      vehicles = applyForce(vehicles, vhl, force);
    end
    % redraw
    RedrawGraphics(vehicles,vNum,v_Image,v_Alpha,VehiclesPlot);
    timeTick = timeTick+1;
  end
end