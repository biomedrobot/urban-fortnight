% rvm1_cin_dir_pos_robot.m
%
% Esta función calcula la posicion del efector final del robot Mitsubishi RV-M1
% q: es el vector de coordenadas articulares del robot
% Ar0: es la MTH que especifica la localización de la base del robot, si no
% se incluye se asume como la identidad
%
% Ejemplo 1:
%
% clear;, clc;, close all
% q = [pi/4, pi/3, -pi/3, pi/4, 0];
% Pef = rvm1_cin_dir_pos_robot(q)
%
% Ejemplo 2:
%
% clear;, clc;, close all
% q = [pi/4, pi/3, -pi/3, pi/4, 0];
% Ar0 = MTHtrasz(100);
% Pef = rvm1_cin_dir_pos_robot(q, Ar0);

function Pef = rvm1_cin_dir_pos_robot(q, Ar0)

% Matriz que define la localizacion del robot
if nargin == 1
    Ar0 = eye(4);
end

% Dimensiones del robot (mm)
L1 = 300;
L2 = 250;
L3 = 160;
L4 = 72;%+75; % hasta el inicio del agarre es 57 y hasta el final 105

% Parametros DH
theta_dh = [q(1) + pi/2, q(2), q(3), q(4)+pi/2, q(5)];
d_dh = [L1, 0, 0, 0, L4];
a_dh = [0,L2, L3, 0, 0];
alfa_dh = [pi/2, 0, 0, pi/2, 0];

% MTH DH
A01 = denavit(theta_dh(1),d_dh(1),a_dh(1),alfa_dh(1));
A12 = denavit(theta_dh(2),d_dh(2),a_dh(2),alfa_dh(2));
A23 = denavit(theta_dh(3),d_dh(3),a_dh(3),alfa_dh(3));
A34 = denavit(theta_dh(4),d_dh(4),a_dh(4),alfa_dh(4));
A45 = denavit(theta_dh(5),d_dh(5),a_dh(5),alfa_dh(5));

% Calculo de los sistemas coordenados 
Ar1 = Ar0*A01;
Ar2= Ar1*A12;
Ar3= Ar2*A23;
Ar4= Ar3*A34;
Ar5= Ar4*A45;
ArEF=Ar5*MTHRotz(pi/2)*MTHRotx(pi/2);

% Posición del efector final
Pef = ArEF(:,4);
