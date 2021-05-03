% rvm1_dibujar_robot.m
%
% Esta función dibuja el robot Mitsubishi RV-M1
% q: es el vector de coordenadas articulares del robot
% sc: sistemas coordenados, si no se incluye se asume como 0
%       sc = 0  No ilustra los ningun sistema coordenado
%       sc = 1  Ilustra los sistemas coordenados de la base y el efector final
%       sc = 2  Ilustra los sistemas coordenados DH
% Ar0: es la MTH que especifica la localización de la base del robot, si no
% se incluye se asume como la identidad
%
% Ejemplo 1:
%
% clear;, clc;, close all
% q = [pi/4, pi/3, -pi/3, pi/4, 0];
% rvm1_dibujar_robot(q)
%
% Ejemplo 2:
%
% clear;, clc;, close all
% q = [0, 0, 0, 0, 0];
% sc = 1;
% rvm1_dibujar_robot(q, sc)
%
% Ejemplo 3:
%
% clear;, clc;, close all
% q = [pi/4, pi/3, -pi/3, pi/4, 0];
% Ar0 = MTHRotx(pi);
% sc = 2;
% rvm1_dibujar_robot(q, sc , Ar0)

function rvm1_dibujar_robot(q, sc , Ar0)

% Matriz que define la localizacion del robot
if nargin == 1
    sc = 0;
end
if nargin < 3
    Ar0 = eye(4);
end

load('rvm1_estructura.mat')

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

% dibuja los sistemas coordenados
if nargin > 1
    if sc == 1
        dibujar_sistema_referencia_MTH(Ar0, 200, 5, '0');
        dibujar_sistema_referencia_MTH(ArEF, 100, 5, '{EF}');
    end
    if sc == 2
        dibujar_sistema_referencia_MTH(Ar0, 200, 5, '0');
        dibujar_sistema_referencia_MTH(Ar1, 100, 5, '1');
        dibujar_sistema_referencia_MTH(Ar2, 100, 5, '2');
        dibujar_sistema_referencia_MTH(Ar3, 100, 5, '3');
        dibujar_sistema_referencia_MTH(Ar4, 100, 5, '4');
        dibujar_sistema_referencia_MTH(Ar5, 100, 5, '5');
    end
end

% dibuja geometrias del robot
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon0 , Ar0);
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon1a , Ar1);
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon1b , Ar1);
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon1c , Ar1);
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon2a , Ar2);
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon2b , Ar2);
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon2c , Ar2);
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon3a , Ar3);
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon3b , Ar3);
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon3c , Ar3);
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon4 , Ar4);
dibujar_objeto_matlab_from_stl (rvm1.stl.eslabon5 , Ar5);
% view(125,25) 
camlight(40,20);, lighting phong;
grid on;