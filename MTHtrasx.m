% MTHtrasx.m
%
% Crea una MTH con una traslaci�n respecto al eje x

function MTH = MTHtrasx(distancia)

MTH = eye(4);
MTH(1,4) = distancia;