function Behaviour__Seek_Seperation (vehicles,vNum, target)
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
      seperation_force = steer_seperation(vehicles, vhl, vNum);
      force = seek_force + seperation_force*2;
      % apply force
      vehicles = applyForce(vehicles, vhl, force);
    end
    % redraw
    RedrawGraphics(vehicles,vNum,v_Image,v_Alpha,VehiclesPlot);
    timeTick = timeTick+1;
  end
end