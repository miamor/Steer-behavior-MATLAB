function Behaviour__CollisionAvoid_Seek (vehicles,vNum, obstacles, obstaclesNum)
  %% global variables
  global TimeSteps;

  %% first draw
  [v_Image,v_Alpha,VehiclesPlot,fHandler] = InitializeGraphics(vehicles,vNum);
  % draw obstacles
  for i = 1:obstaclesNum
    obstacle = obstacles(i,:);
    p_obstacle = plot(obstacle(1), obstacle(2), 'o','MarkerFaceColor','r','Color','r');
  end
  
  %% target is optional, if target is undefined, 
   % then get mouse position on move cursor as target
  if ~exist('target','var')
    target = [0 0 0];
    set(fHandler, 'WindowButtonMotionFcn',@cursorMoveCallback);
  end
  function cursorPosition = cursorMoveCallback(o,e)
    p = get(gca,'CurrentPoint');
    cursorPosition(1:2) = p(1,1:2);
    cursorPosition(3) = 0;
    title( sprintf('(%g,%g)',cursorPosition) );
    setappdata(0,'cursorPosition',cursorPosition)  % save cursorPosition
  end

  %% calculate vehicles' positions to move to each iteration
  timeTick = 1;
  while (timeTick < TimeSteps)
    for vhl = 1:vNum
      %seek
      target = getappdata(0,'cursorPosition'); % get cursorPosition.
      seek_force = steer_seek(vehicles, vhl, target);
      
      avoid_force = steer_collision_avoidance(vehicles, vhl, obstacles, obstaclesNum);
      
      force = seek_force + avoid_force;
      vehicles = applyForce(vehicles, vhl, force);
    end
    % redraw
    RedrawGraphics(vehicles,vNum,v_Image,v_Alpha,VehiclesPlot);
    timeTick = timeTick+1;
  end
end