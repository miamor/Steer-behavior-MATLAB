function Behaviour__Pursue (vehicles,vNum, target)
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
    setappdata(0,'cursorPosition',cursorPosition);  % save cursorPosition
  end

  %% calculate vehicles' positions to move to each iteration
  setappdata(0, 'target_past', [0 0 0]);
  timeTick = 1;
  while (timeTick < TimeSteps)
    for vhl = 1:vNum
      target = getappdata(0,'cursorPosition'); % get cursorPosition.
      target_velocity = target - getappdata(0,'target_past');
      setappdata(0, 'target_past', target);
      % steering
      force = steer_pursue(vehicles, vhl, target, target_velocity);
      vehicles = applyForce(vehicles, vhl, force);
    end
    % redraw
    RedrawGraphics(vehicles,vNum,v_Image,v_Alpha,VehiclesPlot);
    timeTick = timeTick+1;
  end
end