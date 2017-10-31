function RedrawGraphics(vehicles,vNum,v_Image,v_Alpha,VehiclesPlot)
  global EnvironmentWidth;
  global ImageWidth;
  global TimeSteps;

  for vhl = 1 : vNum
    v_angle = vehicles(vhl,12);
    try
      img_i = imrotate(v_Image, v_angle );
      alpha_i = imrotate(v_Alpha, v_angle );
    catch Me
      disp(' hi')
      v_angle
    end
    
    VehiclesPlot(vhl).CData = img_i;
    VehiclesPlot(vhl).AlphaData = alpha_i;
    try
      VehiclesPlot(vhl).XData = vehicles(vhl,1)-ImageWidth/2;
      VehiclesPlot(vhl).YData = vehicles(vhl,2)-ImageWidth/2;
    catch Me
      disp('ki')
      [vehicles(vhl,1),vehicles(vhl,2)]
    end

    
  %      th = linspace(0,2*pi) ;
  %     AttractionCircle(i).XData = BoidsMatrix(i,1)+AttractionRange*cos(th);
  %     AttractionCircle(i).YData = BoidsMatrix(i,2)+AttractionRange*sin(th);
  %     AlignmentCircle(i).XData  = BoidsMatrix(i,1)+AlignmentRange*cos(th);
  %     AlignmentCircle(i).YData  = BoidsMatrix(i,2)+AlignmentRange*sin(th);
  %{
    if SeparationCircleOn
      SeparationCircle(i).XData = BoidsMatrix(i,1)+SeparationRange*cos(th);
      SeparationCircle(i).YData = BoidsMatrix(i,2)+SeparationRange*sin(th);
    end
  %}
  end

  drawnow;
