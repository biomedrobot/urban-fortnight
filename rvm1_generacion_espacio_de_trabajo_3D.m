clear, clc, close all
% Este programa genera una animación mostrando los limites internos y
% externos del robot sobre un plano de trabajo
%
numero_de_planos = 2;
ang_q1 = pi/4*180/pi;
ang_q1_max = ang_q1+0.1*180/pi; % el maximo es  150
ang_q1_min = ang_q1-0.1*180/pi; % el mínimo es -150
% numero_de_planos = 20;
% ang_q1_max = 150; % el maximo es  150
% ang_q1_min = -150; % el mínimo es -150

for plano = 1:numero_de_planos
    
    vec_q1 = linspace(ang_q1_min, ang_q1_max, numero_de_planos);
    
    t_inicial = 0;
    % movimiento art 4
    qi = [vec_q1(plano), -30, -110, -90, 0]*pi/180;
    qf = [vec_q1(plano), -30, -110,   0, 0]*pi/180;
    ti = t_inicial;
    tf = ti+5;
    np = 10;
    trayectoria1 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
    % movimiento art 3
    qi = [vec_q1(plano), -30, -110,   0, 0]*pi/180;
    qf = [vec_q1(plano), -30,    0,   0, 0]*pi/180;
    ti = tf;
    tf = ti+5;
    np = 10;
    trayectoria2 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
    % movimiento art 2
    qi = [vec_q1(plano), -30,    0,   0, 0]*pi/180;
    qf = [vec_q1(plano), 90,    0,   0, 0]*pi/180; % [vec_q1(plano), 100,    0,   0, 0]*pi/180;
    ti = tf;
    tf = ti+5;
    np = 20;
    trayectoria3 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
    % movimiento art 4
    qi = [vec_q1(plano), 100,    0,   0, 0]*pi/180;
    qf = [vec_q1(plano), 100,    0,   90, 0]*pi/180;
    ti = tf;
    tf = ti+5;
    np = 10;
    trayectoria4 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
    
    %%% limite interior
    % movimiento art 3 y 4
    qi = [vec_q1(plano), 100,    0,    90, 0]*pi/180;
    qf = [vec_q1(plano), 100,   -110, -90, 0]*pi/180;
    ti = tf;
    tf = ti+5;
    np = 20;
    trayectoria5 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
    % movimiento art 2
    qi = [vec_q1(plano), 100,   -110, -90, 0]*pi/180;
    qf = [vec_q1(plano), -30,   -110, -90, 0]*pi/180;
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
    grid on; hold on;
    axis([-500, 500, -500, 500, -100, 800]);
    view(130,25);
    tic;
    % Trayectoria Efector Final
    for i=1:trayectoria.np
        q = trayectoria.qt(i,:);
        M_Pef(:,i, plano) = rvm1_cin_dir_pos_robot(q);
    end
    
%     plot3(M_Pef(1,:, plano),M_Pef(2,:, plano),M_Pef(3,:, plano),'-');
    
end

objeto_matlab.x = [];
objeto_matlab.y = [];
objeto_matlab.z = [];
objeto_matlab.tcolor = [1,0,0]
for j=1:1:numero_de_planos-1
    for i=1:trayectoria.np-1
        objeto_matlab.x = [ M_Pef(1,i,j) ; M_Pef(1,i+1,j) ; M_Pef(1,i+1,j+1) ; M_Pef(1,i,j+1); M_Pef(1,i,j)];
        objeto_matlab.y = [ M_Pef(2,i,j) ; M_Pef(2,i+1,j) ; M_Pef(2,i+1,j+1) ; M_Pef(2,i,j+1); M_Pef(2,i,j)];
        objeto_matlab.z = [ M_Pef(3,i,j) ; M_Pef(3,i+1,j) ; M_Pef(3,i+1,j+1) ; M_Pef(3,i,j+1); M_Pef(3,i,j)];
        p=patch(objeto_matlab.x,objeto_matlab.y,objeto_matlab.z,objeto_matlab.tcolor);
        set(p, 'FaceAlpha', '0.5' );
%         set(p, 'EdgeColor', 'none' );
    end
end

% p=patch(objeto_matlab.x,objeto_matlab.y,objeto_matlab.z,objeto_matlab.tcolor);