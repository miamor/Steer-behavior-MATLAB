function Behaviour__Flock_Seek (vehicles,vNum,target)
  %% global variables
  global TimeSteps;

  %% first draw
  [v_Image,v_Alpha,VehiclesPlot,fHandler] = InitializeGraphics(vehicles,vNum);

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
      target = getappdata(0,'cursorPosition'); % get cursorPosition.
      % steering
      seek_force = steer_seek(vehicles, vhl, target);
      boundaries_force = steer_boundaries(vehicles, vhl);
      seperation_force = steer_seperation(vehicles, vhl, vNum);
      alignment_force = steer_alignment(vehicles, vhl, vNum);
      cohesion_force = steer_cohesion(vehicles, vhl, vNum);
      % total force
      force = seek_force + seperation_force*1.5 + alignment_force*2 + cohesion_force*1 + boundaries_force;
      % apply force (calculate new position)
      vehicles = applyForce(vehicles, vhl, force);
    end
    % redraw
    RedrawGraphics(vehicles,vNum,v_Image,v_Alpha,VehiclesPlot);
    timeTick = timeTick+1;
  end
end