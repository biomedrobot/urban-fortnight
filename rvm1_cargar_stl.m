% raplim_cargar_stl.m
clear, clc, close all
% se definen los colores de las piezas
color_rvm1 = [0.8, 0.75, 0.55];
color_base = [0.5, 0.5,  0.5];
color_mesa = [0,0,0.5];
color_pinza = [1,0,0];
% Carga STLs de los eslabones del robot
rvm1.stl.eslabon0 = fun_stl2matlab('./Robot_STL/BASE.STL', color_base,0);
rvm1.stl.eslabon1a = fun_stl2matlab('./Robot_STL/ESLABON_1A.STL', color_base,0);
rvm1.stl.eslabon1b = fun_stl2matlab('./Robot_STL/ESLABON_1B.STL', color_rvm1,0);
rvm1.stl.eslabon1c = fun_stl2matlab('./Robot_STL/ESLABON_1C.STL', color_rvm1,0);
rvm1.stl.eslabon2a = fun_stl2matlab('./Robot_STL/ESLABON_2A.STL', color_rvm1,0);
rvm1.stl.eslabon2b = fun_stl2matlab('./Robot_STL/ESLABON_2B.STL', color_rvm1,0);
rvm1.stl.eslabon3a = fun_stl2matlab('./Robot_STL/ESLABON_3A.STL', color_rvm1,0);
rvm1.stl.eslabon3b = fun_stl2matlab('./Robot_STL/ESLABON_3B.STL', color_rvm1,0);
rvm1.stl.eslabon4 = fun_stl2matlab('./Robot_STL/ESLABON_4.STL', color_rvm1,0);
rvm1.stl.eslabon5 = fun_stl2matlab('./Robot_STL/ESLABON_5.STL', color_base,0);

% Dimensiones del robot (mm)
L1 = 300;
L2 = 250;
L3 = 160;
L4 = 72;%+75; % hasta el inicio del agarre es 57 y hasta el final 105
% almacena las dimensiones en la estructura del robot
rvm1.dimensiones.L1 = L1;
rvm1.dimensiones.L2 = L2;
rvm1.dimensiones.L3 = L3;
rvm1.dimensiones.L4 = L4;
% 

% transforma los objetos para que queden de acuerdo a los sistemas
% coordenados
A0CAD0 = MTHRotz(pi/2);
rvm1.stl.eslabon0 = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon0,A0CAD0);

A1aCAD1a = MTHtrasy(-175)*MTHRotx(-pi/2);
rvm1.stl.eslabon1a = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon1a,A1aCAD1a);
A1bCAD1b = MTHtrasy(-45)*MTHtrasx(-80)*MTHRoty(-pi/2)*MTHRotx(-pi/2);
rvm1.stl.eslabon1b = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon1b,A1bCAD1b);
A1cCAD1c = MTHtrasx(-80)*MTHRoty(-pi/2)*MTHRotx(-pi/2);
rvm1.stl.eslabon1c = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon1c,A1cCAD1c);

A2aCAD2a = MTHtrasx(-250);
rvm1.stl.eslabon2a = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon2a,A2aCAD2a);
A2bCAD2b = MTHtrasz(53)*MTHRotx(-pi/2);
rvm1.stl.eslabon2b = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon2b,A2bCAD2b);
A2cCAD2c = MTHRotx(pi); % el segunto tapon es igual
rvm1.stl.eslabon2c = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon2b,A2cCAD2c);

A3aCAD3a = MTHtrasx(-160);
rvm1.stl.eslabon3a = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon3a,A3aCAD3a);
A3bCAD3b = MTHRotz(pi/2)*MTHtrasz(35)*MTHRoty(-pi/2);
rvm1.stl.eslabon3b = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon3b,A3bCAD3b);
A3cCAD3c = MTHRotx(pi); % el segunto tapon es igual
rvm1.stl.eslabon3c = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon3b,A3cCAD3c);

A4CAD4 = MTHRoty(-pi/2)*MTHRotx(pi/2);
rvm1.stl.eslabon4 = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon4,A4CAD4);

A5CAD5 = MTHtrasz(-30);
rvm1.stl.eslabon5 = transforma_objeto_matlab_from_stl(rvm1.stl.eslabon5,A5CAD5);

save ('rvm1_estructura.mat','rvm1');


%%%%%%
% dibujar_objeto_matlab_from_stl(raplim.stl.eslabon1,eye(4));
% 
% dibujar_objeto_matlab_from_stl(raplim.stl.cuchara,eye(4));
% dibujar_sistema_referencia_MTH(eye(4), 225, 5, 'o');
% view(121,46), camlight(40,20);, lighting phong;
