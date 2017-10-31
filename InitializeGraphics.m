function [v_Image,v_Alpha,VehiclesPlot,fHandler]=InitializeGraphics(vehicles,vNum)
  global EnvironmentWidth;
  global ImageWidth;
  global TimeSteps;

  [v_Image, ~, v_Alpha]	= imread('uav2.png');
  v_Image = imresize(v_Image, [ImageWidth ImageWidth], 'lanczos3' );
  v_Alpha = imresize(v_Alpha, [ImageWidth ImageWidth], 'lanczos3' );
  fHandler = figure;
  fHandler.Color = 'white';
  fHandler.MenuBar = 'none';
  fHandler.ToolBar = 'none';
  fHandler.NumberTitle = 'off';
  rectangle('position',[-EnvironmentWidth -EnvironmentWidth 2*EnvironmentWidth 2*EnvironmentWidth],'EdgeColor','b','LineWidth',1);
  hold on
  xlabel(' ')
  ylabel(' ')
  %axis manual;
  %axis off;
  axis([-EnvironmentWidth EnvironmentWidth -EnvironmentWidth EnvironmentWidth]);

  for vhl = 1 : vNum
      angle = atan(vehicles(vhl,2) / vehicles(vhl,1)) * 180 / pi - 90;		% imrotate rotates ccw
      img_i = imrotate(v_Image, angle );
      alpha_i = imrotate(v_Alpha, angle );
      VehiclesPlot(vhl) = image(vehicles(vhl,1)-ImageWidth/2, vehicles(vhl,2)-ImageWidth/2, img_i);
      VehiclesPlot(vhl).AlphaData = alpha_i;
  end
