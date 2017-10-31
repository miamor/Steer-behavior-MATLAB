WIDTH = 30;
HEIGHT = 30;

%{
% v_pos   v_vel   v_acc   v_maxspeed  v_maxforce   v_size    v_r   v_angle  |  v_seek_steer   v_seperation_steer
vehicles = [ 50 50 50   0 -2 0    0 0 0   1   0.1   10   30   0   ;
             30 60 60   0 -2 0    0 0 0   1   0.1   10   30   0   ;
           ];
%}
vehicles = [ 50 50 10   0 2 0    0 0 0   1.5   0.1   10   30   0 
           ];

vehicles_color = ['b', 'b'];
vNum = 1;


target = [10 10 10]; % target position
target_radius = 300;
target_vel = 16;
target_color = 'r';




% Block specification
Lx = 3;
Ly = 1;
Lz = 2;

% Motion data
time = [0:0.001:2]';                % Time data
%r = [50*sin(2*pi*time), 0*time, 0*time]; % Position data
A = [0*time, 0*time, 0*time];             % Orientation data (x-y-z Euler angle)
%A = [0.5*pi*time, 0*time, 1.8*pi*time];


%draw target
plot3(target(1), target(2), target(3), '.');
hold on;


% Axes settings
xlabel('x','FontSize',14);
ylabel('y','FontSize',14);
zlabel('z','FontSize',14);
%set(gca,'FontSize',14);
%axis vis3d equal;
%view([-37.5,30]);
%camlight;

grid on;
xlim([-WIDTH,WIDTH]);
ylim([-WIDTH,WIDTH]);
zlim([-WIDTH,WIDTH]);




% Compute propagation of vertices and patches
for t=1:length(time)
  for vhl = 1:vNum
%    vhl = 1;
    v_color = vehicles_color(vhl);

    force = steer_seek(vehicles, vhl, target);
    vehicles = applyForce(vehicles, vhl, force);

    %{
    force_mag = mag(force);
    v_vel = vehicles(vhl, 4:6);
    if (force_mag > 0) 
      A(1) = cosh(v_vel(1)/force_mag);
      A(2) = cosh(v_vel(2)/force_mag);
      A(3) = cosh(v_vel(3)/force_mag);
    end
    
    %}

    v_pos = vehicles(vhl,1:3);
    vmag = mag(target-v_pos);
    A(1,t) = acos((vmag/target(1)) * pi/180);
    A(2,t) = acos((vmag/target(2)) * pi/180);
    A(3,t) = acos((vmag/target(3)) * pi/180);
    
    %disp(A); printf("---------- \n");

    R = Euler2R(A(t,:));
    
    VertexData(:,:,t) = GeoVerMakeBlock(vehicles(vhl,1:3), R, [Lx,Ly,Lz]);
    %VertexData(:,:,t) = GeoVerMakeBlock(r(t,:), R, [Lx,Ly,Lz]);
    [X,Y,Z] = GeoPatMakeBlock(VertexData(:,:,t));
    PatchData_X(:,:,t,vhl) = X;
    PatchData_Y(:,:,t,vhl) = Y;
    PatchData_Z(:,:,t,vhl) = Z;
  end
end



% Draw initial figure
hfig = figure(1);
for vhl = 1:vNum
  if (ishandle(hfig))
    h(vhl) = patch(PatchData_X(:,:,1,vhl),PatchData_Y(:,:,1,vhl),PatchData_Z(:,:,1,vhl),'y');
    hold on;
  end
end


% Animation Loop
for t=1:length(time)
  if (ishandle(hfig))
    for vhl = 1:vNum
      set(h(vhl),'XData',PatchData_X(:,:,t,vhl));
      set(h(vhl),'YData',PatchData_Y(:,:,t,vhl));
      set(h(vhl),'ZData',PatchData_Z(:,:,t,vhl));
      drawnow;
    end
  end
end
%{
%}