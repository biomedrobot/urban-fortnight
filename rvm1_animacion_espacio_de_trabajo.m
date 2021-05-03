clear, clc, close all
% Este programa genera una animación mostrando los limites internos y
% externos del robot sobre un plano de trabajo
%
t_inicial = 0;
% movimiento art 4
qi = [0, -30, -110, -90, 0]*pi/180;
qf = [0, -30, -110,   0, 0]*pi/180;
ti = t_inicial;
tf = ti+5;
np = 10;
trayectoria1 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
% movimiento art 3
qi = [0, -30, -110,   0, 0]*pi/180;
qf = [0, -30,    0,   0, 0]*pi/180;
ti = tf;
tf = ti+5;
np = 10;
trayectoria2 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
% movimiento art 2
qi = [0, -30,    0,   0, 0]*pi/180;
qf = [0, 100,    0,   0, 0]*pi/180;
ti = tf;
tf = ti+5;
np = 20;
trayectoria3 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
% movimiento art 4
qi = [0, 100,    0,   0, 0]*pi/180;
qf = [0, 100,    0,   90, 0]*pi/180;
ti = tf;
tf = ti+5;
np = 10;
trayectoria4 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);

%%% limite interior
% movimiento art 3 y 4
qi = [0, 100,    0,    90, 0]*pi/180;
qf = [0, 100,   -110, -90, 0]*pi/180;
ti = tf;
tf = ti+5;
np = 20;
trayectoria5 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
% movimiento art 2
qi = [0, 100,   -110, -90, 0]*pi/180;
qf = [0, -30,   -110, -90, 0]*pi/180;
ti = tf;
tf = ti+5;
np = 20;
trayectoria6 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);

% Union de trayectorias
trayectoria = trayectoria1;
%
trayectoria.qt = [trayectoria.qt ; trayectoria2.qt];
trayectoria.t  = [trayectoria.t  , trayectoria2.t];
trayectoria.np =  trayectoria.np + trayectoria2.np;
%
trayectoria.qt = [trayectoria.qt ; trayectoria3.qt];
trayectoria.t  = [trayectoria.t  , trayectoria3.t];
trayectoria.np =  trayectoria.np + trayectoria3.np;
%
trayectoria.qt = [trayectoria.qt ; trayectoria4.qt];
trayectoria.t  = [trayectoria.t  , trayectoria4.t];
trayectoria.np =  trayectoria.np + trayectoria4.np;

%%%%

trayectoria.qt = [trayectoria.qt ; trayectoria5.qt];
trayectoria.t  = [trayectoria.t  , trayectoria5.t];
trayectoria.np =  trayectoria.np + trayectoria5.np;
%
trayectoria.qt = [trayectoria.qt ; trayectoria6.qt];
trayectoria.t  = [trayectoria.t  , trayectoria6.t];
trayectoria.np =  trayectoria.np + trayectoria6.np;

f1=figure(1);, set(f1, 'Color', 'w');
grid on; axis([-500, 500, -500, 500, -50, 800]);
view(100,10); % view(130,25);
tic;
% Trayectoria Efector Final
for i=1:trayectoria.np
    q = trayectoria.qt(i,:);
    Vec_Pef(:,i) = rvm1_cin_dir_pos_robot(q);
end
% Animación del robot moviendose
for i=1:trayectoria.np
    cla;
    q = trayectoria.qt(i,:);
    rvm1_dibujar_robot(q);
    camlight(40,20);, lighting phong;
    hold on;
    plot3(Vec_Pef(1,:),Vec_Pef(2,:),Vec_Pef(3,:),'-');
    t= toc;
    title(['Tiempo: ', num2str(t)]);
    while(t<trayectoria.t(i))
        pause(0.05);
        t= toc;
        title(['Tiempo: ', num2str(t)]);
    end 
end

