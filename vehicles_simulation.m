function vehicles_simulation (vNum,time)
  %% global variables
  global EnvironmentWidth;
  global boundaryWidth;
  global ImageWidth;
  global SeperationRange;
  global AlignmentRange;
  global CohesionRange;
  global TimeSteps;
  global wanderAngle;
  %% change global variables here (use user input or something)
  EnvironmentWidth = 400;
  boundaryWidth = EnvironmentWidth-100;
  ImageWidth = EnvironmentWidth/20;
  SeperationRange = EnvironmentWidth/25; % set seperation range
  AlignmentRange = EnvironmentWidth/5; % set alignment range
  CohesionRange = EnvironmentWidth/5; % set cohesion range
  wanderAngle = 5;
  if ~exist('time','var')
    TimeSteps = 1000;
  else 
    TimeSteps = time;
  end
  
  %% set vehicles data
  if ~exist('vNum','var')
    vNum = 8;
  end
  vehicles = zeros(vNum,14); % initialize vehicles matrix
  %{
  1-3 pos
  4-6 vel
  7-9 acc
  10 maxspeed
  11 maxforce
  12 angle
  13 max see ahead (collision avoidance)
  14 max avoid force (collision avoidance)
  %}
  vehicles(:,1:2) = 300*(2*rand([vNum,2])-1); % set random position
  %vehicles(:,4:5) = 0.00002*(rand([vNum,2])-450); % set random velocity

  vehicles(:,4) = 1;
  vehicles(:,5) = 4;

  vehicles(:,10) = 2; % set maxspeed
  vehicles(:,11) = 0.2; % set maxforce
  vehicles(:,13) = 20; % set max see ahead
  vehicles(:,14) = 6; % set max avoid force
  
  %% simulate available behaviour using function
  Behaviour__Flock(vehicles,vNum);
  %Behaviour__Arrival(vehicles,vNum);
  %Behaviour__Pursue(vehicles,vNum);
  %Behaviour__Evade(vehicles,vNum);
  %Behaviour__Seek_Seperation(vehicles,vNum);
  
  obstacles = [50 50 0 50;
               20 20 0 50;
               200 200 0 50];
  obstaclesNum = 3;
  
  %Behaviour__CollisionAvoid_Seek(vehicles,vNum, obstacles, obstaclesNum);
  %Behaviour__Seperation_Seek_CollisionAvoid(vehicles,vNum, obstacles, obstaclesNum);
  %Behaviour__Flock_Seek_CollisionAvoid(vehicles,vNum, obstacles, obstaclesNum);
  %Behaviour__Wander(vehicles,vNum);
  
  %% simulate customized behaviour (this is demo for seperation behaviour)
  %{
    %%% first draw
    [v_Image,v_Alpha,VehiclesPlot,fHandler] = InitializeGraphics(vehicles,vNum);
    %%% calculate vehicles' positions to move to each iteration
    timeTick = 1;
    while (timeTick < TimeSteps)
      for vhl = 1:vNum
        % steering
        force = steer_seperation(vehicles, vhl, vNum);
        % apply force (calculate new position to move vehicles to)
        vehicles = applyForce(vehicles, vhl, force);
      end
      % redraw vehicles
      RedrawGraphics(vehicles,vNum,v_Image,v_Alpha,VehiclesPlot);
      timeTick = timeTick+1;
    end
  %}
end