function [adj, coords, bounds] = l1()
%L1 layout. Each layout is a function that returns the adjacency matrix,
%the coordinates of each node/vertex, and optionally the bounds of
%obstacles (for visualization). Bounds is a cell array of polygon
%coordinates of walls/pillars etc {[x1],[y1],[x2],[y2],...}
x  =  [0,45,45,35,35,25,25,10,10,5,5,0];
x1 =  [10,20,20,15,15,10,10];
x2 =  [5,5,20,20,5];
x3 =  [60,60,70,70,60];
x4 =  [75,75,90,90,75,75];
x5 =  [75,85,85,80,80,80,70,70,60,60,75,75];
x6 =  [90,90,85,85,90];
x7 =  [35,25,25,35,35];
x8 =  [55,55,45,45,40,40,50,50,55];
x9 =  [85,85,75,75,60,60,65,65,80,80,85];
x10 = [55,55,50,50,45,45,55];
x11 = [45,45,25,25,40,40,45];
x12 = [25,25,20,20,5,5,15,15,25];
x13 = [15,15,5,5,15]; 
x14 = [35,35,40,40,30,30,35]; 
x15 = [25,25,0,0,20,20,25]; 
x16 = [50,50,45,45,50]; 
x17 = [65,65,55,55,65]; 
x18 = [85,85,80,80,70,70,85]; 
x19 = [70,70,65,65,50,50,40,40,50,50,60,60,70]; 
x20 = [90,90,70,70,85,85,90]; 

y  =  [0,0,5,5,20,20,5,5,15,15,30,30];
y1 =  [30,30,10,10,20,20,30];
y2 =  [35,45,45,35,35];
y3 =  [0,10,10,0,0];
y4 =  [0,5,5,0,0,5];
y5 =  [10,10,20,20,20,25,25,20,20,15,15,10];
y6 =  [25,45,45,25,25];
y7 =  [25,25,35,35,25];
y8 =  [5,25,25,20,20,10,10,5,5];
y9 =  [50,55,55,35,35,25,25,30,30,50,50];
y10 = [30,45,45,40,40,30,30];
y11 = [45,50,50,40,40,45,45];
y12 = [55,65,65,60,60,50,50,55,55]; 
y13 = [65,70,70,65,65];
y14 = [55,70,70,75,75,55,55]; 
y15 = [70,80,80,75,75,70,70]; 
y16 = [70,80,80,70,70]; 
y17 = [65,75,75,65,65]; 
y18 = [60,65,65,70,70,60,60]; 
y19 = [40,55,55,60,60,65,65,55,55,50,50,40,40]; 
y20 = [70,80,80,75,75,70,70]; 

% plot(x,y,x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,x8,y8,x9,y9,x10,y10,...
%    x11,y11,x12,y12,x13,y13,x14,y14,x15,y15,x16,y16,x17,y17,x18,y18,x19,...
%    y19,x20,y20,'LineWidth',2)
% grid on
% plot_fn = @() plot(x,y,x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,x8,y8,x9,y9,x10,y10,...
%    x11,y11,x12,y12,x13,y13,x14,y14,x15,y15,x16,y16,x17,y17,x18,y18,x19,...
%    y19,x20,y20,'LineWidth',2);

bounds = {x,y,x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,x8,y8,x9,y9,x10,y10,...
   x11,y11,x12,y12,x13,y13,x14,y14,x15,y15,x16,y16,x17,y17,x18,y18,x19,...
   y19,x20,y20};
%********************************************************************
% Calculate Dataset from the Environment
%********************************************************************
P = struct ('location',[], 'connected',[]);
p1.location =[12.5 7.5]; % (x,y) Location
p1.connected = [2 17]; %Points connected
p2.location = [12.5 17.5];
p2.connected = [3 1];
p3.location = [7.5 17.5];
p3.connected = [4 2];
p4.location = [7.5 32.5];
p4.connected = [5 6 3];
p5.location = [2.5 32.5];
p5.connected = [7 4];
p6.location = [22.5 32.5];
p6.connected = [8 14 4];
p7.location = [2.5 47.5];
p7.connected = [11 9 5];
p8.location = [22.5 37.5];
p8.connected = [9 13 6];
p9.location = [22.5 47.5];
p9.connected = [10 8 7];
p10.location = [22.5 52.5];
p10.connected = [9 32];   %[24 9 7] incorrect fix?
p11.location = [2.5 62.5];
p11.connected = [12 7 29];
p12.location = [2.5 72.5];
p12.connected = [11];
p13.location = [37.5 37.5];
p13.connected = [20 16 8];
p14.location = [22.5 22.5];
p14.connected = [6 15 17];
p15.location = [37.5 22.5];
p15.connected = [16 18 14];
p16.location = [37.5 27.5];
p16.connected = [13 15 26];
p17.location = [22.5 7.5];
p17.connected = [14 1];
p18.location = [37.5 7.5];
p18.connected = [15 19];
p19.location = [47.5 7.5];
p19.connected = [18];
p20.location = [42.5 37.5];
p20.connected = [21 13];
p21.location = [42.5 42.5];
p21.connected = [20 23];
p22.location = [37.5 67.5];
p22.connected = [24];
p23.location = [47.5 42.5];
p23.connected = [25 21];
p24.location = [37.5 52.5];
p24.connected = [32 33 36];
p25.location = [47.5 47.5];
p25.connected = [36 23];
p26.location = [57.5 27.5];
p26.connected = [16 42 43];
p27.location =[17.5 72.5];
p27.connected= [12 28];
p28.location =[17.5 67.5];
p28.connected= [29 30 27];
p29.location =[17.5 62.5];
p29.connected= [28 11];
p30.location =[27.5 67.5];
p30.connected= [31 28 32];
p31.location =[27.5 77.5];
p31.connected= [34 30];
p32.location =[27.5 52.5];
p32.connected= [24 10 30];
p33.location =[37.5 57.5];
p33.connected= [24 22];
p34.location =[42.5 77.5];
p34.connected= [35 31];
p35.location =[42.5 67.5];
p35.connected= [22 34 39];
p36.location =[47.5 52.5];
p36.connected= [25 24];
p37.location =[52.5 77.5];
p37.connected= [52 38];
p38.location =[52.5 72.5];
p38.connected= [39 37];
p39.location =[52.5 67.5];
p39.connected= [40 38 35];
p40.location =[52.5 62.5];
p40.connected= [50 39];
p41.location =[57.5 47.5];
p41.connected= [42 25];
p42.location =[57.5 37.5];
p42.connected= [26 54 41];
p43.location =[57.5 22.5];
p43.connected= [47 26 44];
p44.location =[57.5 12.5];
p44.connected= [45 55 43];
p45.location =[57.5 2.5];
p45.connected= [46 44];
p46.location =[47.5 2.5];
p46.connected= [19 45];
p47.location =[67.5 22.5];
p47.connected= [48 43];
p48.location =[67.5 27.5];
p48.connected= [47 60];
p49.location =[67.5 57.5];
p49.connected= [53 50];
p50.location =[67.5 62.5];
p50.connected= [49 40 51];
p51.location =[67.5 72.5];
p51.connected= [52 66 50];
p52.location =[67.5 77.5];
p52.connected= [51 37];
p53.location =[72.5 57.5];
p53.connected= [63 49 54];
p54.location =[72.5 37.5];
p54.connected= [42 53];
p55.location =[72.5 12.5];
p55.connected= [56 44];
p56.location =[72.5 7.5];
p56.connected= [57 55];
p57.location =[87.5 7.5];
p57.connected= [58 56];
p58.location =[87.5 22.5];
p58.connected= [59 57];
p59.location =[82.5 22.5];
p59.connected= [58 60];
p60.location =[82.5 27.5];
p60.connected= [48 61 59];
p61.location =[82.5 47.5];
p61.connected= [62 60];
p62.location =[87.5 47.5];
p62.connected= [61 63];
p63.location =[87.5 57.5];
p63.connected= [53 62 64];
p64.location =[87.5 67.5];
p64.connected= [65 63];
p65.location =[83.5 67.5];
p65.connected= [66 64];
p66.location =[83.5 73.5];
p66.connected= [51 65];

points = [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,...
        p18,p19,p20,p21,p22,p23,p24,p25,p26,p27,p28,p29,p30,p31,p32,p33,...
        p34,p35,p36,p37,p38,p39,p40,p41,p42,p43,p44,p45,p46,p47,p48,p49,...
        p50,p51,p52,p53,p54,p55,p56,p57,p58,p59,p60,p61,p62,p63,p64,p65,...
        p66];
[adj, coords] = to_graph(points);
end

