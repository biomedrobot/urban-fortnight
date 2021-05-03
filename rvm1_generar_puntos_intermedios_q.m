% raplim_generar_puntos_intermedios_q.m
% Crea los puntos intermedios segun una trayectoria con un interpolador
% lineal tomando dos posiciones articulares (inicial y final)
%
% Ejemplo:
%
% qi = [pi/6, pi/3, -pi/3, -pi/4, 0];
% qf = [-pi/6, pi/3, -pi/4, pi/4, 0];
% ti = 0;
% tf = 10;
% np = 10;
% trayectoria = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);

function trayectoria = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np)

deltaq = (qf - qi)*(1/(np-1));
deltat = (tf - ti)*(1/(np-1));

% calculo de los puntos intermedios
for i=1:5
    if deltaq(i) == 0
        trayectoria.qt(:,i) = ones(np,1)*qi(i);
    else
        trayectoria.qt(:,i) = qi(i):deltaq(i):qf(i);
    end
end
% calculo de los tiempos intermedios

if deltat == 0
    trayectoria.t(1,:) = ones(np,1)*ti;
else
    trayectoria.t(1,:) = ti:deltat:tf;
end

[trayectoria.np, nada]= size(trayectoria.qt);