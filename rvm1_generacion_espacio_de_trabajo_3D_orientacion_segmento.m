% Este programa genera un plano ilustrando los limites del espacio de
% trabajo para un robot dados los angulos del robot (en realidad importan
% los angulos q1 y q4)
%
% Ejemplo 1:
%
% clear, clc, close all
% q = [pi/4, pi/3, 0, -pi/4, 0];
% rvm1_dibujar_robot(q,1);
% rvm1_generacion_espacio_de_trabajo_3D_orientacion_segmento(q);
%
% Ejemplo 2:
%
% clear, clc, close all
% q = [pi/4, pi/3, 0, -pi/4, 0];
% Ar0 = MTHtrasx(40)*MTHRotx(pi/4)*eye(4);
% rvm1_dibujar_robot(q,1,Ar0);
% rvm1_generacion_espacio_de_trabajo_3D_orientacion_segmento(q, Ar0);

function rvm1_generacion_espacio_de_trabajo_3D_orientacion_segmento(q, Ar0)

if nargin == 1
    Ar0 = eye(4);
end

ang_q1 = q(1);
ang_q4 = q(4);

t_inicial = 0;
q2_min = -30*pi/180;
q2_max = 100*pi/180;
q3_min = -110*pi/180;
q3_max = 0;
% movimiento art 3
qi = [q(1), q2_min, q3_min, q(4), 0];
qf = [q(1), q2_min, q3_max, q(4), 0];
ti = t_inicial;
tf = ti+5;
np = 10;
trayectoria1 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
% movimiento art 2
qi = [q(1), q2_min, q3_max,   q(4), 0];
qf = [q(1), q2_max, q3_max,   q(4), 0]; % [vec_q1(plano), 100,    0,   0, 0]*pi/180;
ti = tf;
tf = ti+5;
np = 20;
trayectoria2 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
%%% limite interior
% movimiento art 3
qi = [q(1), q2_max, q3_max,   q(4), 0];
qf = [q(1), q2_max, q3_min,   q(4), 0];
ti = tf;
tf = ti+5;
np = 10;
trayectoria3 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);

% movimiento art 2
qi = [q(1), q2_max,   q3_min,  q(4), 0];
qf = [q(1), q2_min,   q3_min,  q(4), 0];
ti = tf;
tf = ti+5;
np = 20;
trayectoria4 = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);

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


f1=figure(1);, set(f1, 'Color', 'w');
grid on; hold on;
axis([-500, 500, -500, 500, -100, 800]);
view(130,25);
tic;
% Trayectoria Efector Final
MTHaux1 = Ar0*MTHRotz(q(1))*MTHtrasx(40)*inv(Ar0*MTHRotz(q(1)));
MTHaux2 = Ar0*MTHRotz(q(1))*MTHtrasx(-40)*inv(Ar0*MTHRotz(q(1)));
for i=1:trayectoria.np
    q = trayectoria.qt(i,:);
    M_Pef(:,i, 1) = Ar0*rvm1_cin_dir_pos_robot(q);
    % Crea trayectorias paralelas
    M_Pef(:,i, 2) = MTHaux1*M_Pef(:,i, 1);
    M_Pef(:,i, 3) = MTHaux2*M_Pef(:,i, 1);
end

plot3(M_Pef(1,:, 1),M_Pef(2,:, 1),M_Pef(3,:, 1),'--k'); % plano principal

% dibuja un plano semitransparente para indicar los extremos
objeto_matlab.x = [];
objeto_matlab.y = [];
objeto_matlab.z = [];
objeto_matlab.tcolor = [1,0,0];
for i=1:trayectoria.np-1
    objeto_matlab.x = [ M_Pef(1,i,2) ; M_Pef(1,i+1,2) ; M_Pef(1,i+1,3) ; M_Pef(1,i,3); M_Pef(1,i,2)];
    objeto_matlab.y = [ M_Pef(2,i,2) ; M_Pef(2,i+1,2) ; M_Pef(2,i+1,3) ; M_Pef(2,i,3); M_Pef(2,i,2)];
    objeto_matlab.z = [ M_Pef(3,i,2) ; M_Pef(3,i+1,2) ; M_Pef(3,i+1,3) ; M_Pef(3,i,3); M_Pef(3,i,2)];
    p=patch(objeto_matlab.x,objeto_matlab.y,objeto_matlab.z,objeto_matlab.tcolor);
    set(p, 'FaceAlpha', '0.5' );
    set(p, 'EdgeColor', 'none' );
end