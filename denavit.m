% DENAVIT  		Matriz de transformación homogénea.
% 	DH = DENAVIT(TETA, D, A, ALFA) devuelve la matriz de transformacion 
%	homogénea 4 x 4 a partir de los parametros de Denavit-Hartenberg
%	D, ALFA, A y TETA.
%
%	See also DIRECTKINEMATIC.

function dh=denavit(theta, d, a, alfa)
dh=[cos(theta)  -cos(alfa)*sin(theta)   sin(alfa)*sin(theta)   a*cos(theta);
    sin(theta)   cos(alfa)*cos(theta)  -sin(alfa)*cos(theta)   a*sin(theta);
           0              sin(alfa)             cos(alfa)             d;
           0                     0                     0              1];

