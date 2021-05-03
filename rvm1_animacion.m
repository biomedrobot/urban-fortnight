clear, clc, close all

qi = [0, 0, 0, 0, 0];
qf = [-pi/2, pi/2, -pi/2, pi/4, 0];
ti = 0;
tf = 10;
np = 50;
trayectoria = rvm1_generar_puntos_intermedios_q(qi, qf, ti, tf, np);
f1=figure(1);, set(f1, 'Color', 'w');
grid on; axis([-500, 500, -500, 500, -50, 700]);
view(130,25);
tic;
for i=1:trayectoria.np
    cla;
    q = trayectoria.qt(i,:);
    rvm1_dibujar_robot(q);
    camlight(40,20);, lighting phong;
    t= toc;
    title(['Tiempo: ', num2str(t)]);
    while(t<trayectoria.t(i))
        pause(0.05);
        t= toc;
        title(['Tiempo: ', num2str(t)]);
    end 
end