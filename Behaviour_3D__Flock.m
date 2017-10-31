WIDTH = 100;
HEIGHT = 100;

boundaryX = 100;
boundaryY = 100;

startBoundaryX = -boundaryX;
startBoundaryY = -boundaryY;
sizeBoundaryX = boundaryX*2;
sizeBoundaryY = boundaryY*2;


% v_pos   v_vel   v_acc   v_maxspeed  v_maxforce   v_size    v_r   v_angle  |  v_seek_steer   v_seperation_steer
vehicles = [ 50 50 0   0 -2 0    0 0 0   2   0.5   10   30   0   ;
             50 50 0   0 -2 0    0 0 0   2   0.5   10   30   0   ;
             10 50 0   0 -2 0    0 0 0   2   0.5   10   30   0   ;
             10 50 0   0 -2 0    0 0 0   2   0.5   10   30   0   ;
             40 50 0   0 -2 0    0 0 0   2   0.5   10   30   0   ;
             40 50 0   0 -2 0    0 0 0   2   0.5   10   30   0   ;
           ];

vehicles_color = ['b', 'b', 'b', 'b', 'b', 'b'];
vNum = 6;




% Block specification
Lx = 8;
Ly = 1;
Lz = 1;

% Motion data
time = [0:0.001:1]';                % Time data
%r = [50*sin(2*pi*time), 0*time, 0*time]; % Position data
%A = [pi/6*time, 0*time, 1.5*pi*time];
A = [0.5*pi*time, 0*time, 1.8*pi*time];


%draw target
target = [0 0 0]; % target position
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

%grid on;
xlim([-WIDTH,WIDTH]);
ylim([-WIDTH,WIDTH]);
zlim([-WIDTH,WIDTH]);




% Compute propagation of vertices and patches
for t=1:length(time)
  for vhl = 1:vNum
%    vhl = 1;
    v_color = vehicles_color(vhl);

    force = steer_seperation(vehicles, vhl, vNum);
    vehicles = applyForce(vehicles, vhl, force);
    
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