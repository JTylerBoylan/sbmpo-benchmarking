clc
clear
close all

%%

size = 5;
res = 100;

[X,Y] = meshgrid(linspace(-size/2,size/2,res),linspace(-size/2,size/2,res));

GR = 0.25;
keyx = floor(X/GR);
keyy = floor(Y/GR);

figure
plot(keyx(:), keyy(:), 'xr')

%%

keyxd = floor(X.^(1/3)/GR);
keyyd = floor(Y.^(1/3)/GR);

figure
plot(keyxd(:), keyyd(:), 'xr')