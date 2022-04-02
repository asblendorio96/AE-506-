clear
clc

%Trim Velocity components
initu = 228.7;
initv = 0;
initw = -6.646;

%Initial rates
initp=0;
initq=0;
initr=0;

%Initial attitude
initbank = 0;
initpitch=initw/initu;
inithead=0;

%Initial Position
initnorth=0;
initeast=0;
initalt=6000;

% NAVION stability derivatives

% CL
cla=4.44;
cladot=0;
clq=3.8;
clde=0.355;
clo=0.41;

% CD
cda2=0.33;
cdo=0.05;

% CM
cma=-0.683;
cmde=-0.923;
cmadot=-4.36;
cmq=-9.96;

%CY
cyb = -0.564;
cydr = 0.157;

%CL - Roll
clb = -0.074;
clp = -0.410;
clr = 0.107;
clda = -0.134;
cldr = 0.107;

%CN
cnb = 0.071;% needs to be positive
cnp = -0.0575;
cnr = -0.125;
cnda = -0.0035;
cndr = -0.072;

sw=175.3;%
b=44;%
cbar = 4+2/12;%page 26
weight = 3695;%

%DATUM 5.3769 [ft] fwd of stub wing rib

%Scaling factor Page 38 is 11.0628141. Calculate the AC location wrt DATUM
sweep_i=10.66*pi/180; sweep_o=1*pi/180; TR_i=0.67552; TR_o=0.72176; y_b=6.46166;
Si=33.16423; So=54.87255; C_bar=4.34761;
yMAC_i=1/3*((1+2*TR_i)/(1+TR_i))*b/2;yMAC_o=1/3*((1+2*TR_o)/(1+TR_o))*b/2;
yMAC=(yMAC_i*Si+(y_b+yMAC_o)*So)/(Si+So);
xLE=((yMAC_i*tan(sweep_i))*Si+((y_b*tan(sweep_i)+yMAC_o*tan(sweep_o))*So))/(Si+So);
xAC=(xLE+C_bar/4);%in Ft, assumeing .25 chord

xCG=7.9550-5.3769-xAC;
%Page 278 7.955ft off datum,make AC the new DATUM point,modefy the POH [x]
%Negative value is in front of the AC, Positive is aft of AC
cg=[xCG 0 0];

ac=[0 0 0];

%eng=[0 0 0];

jx= 1048;
jy=3000;
jz =3500;
jxz=0;

% Controls

elevator = 1.11*3.141/180; % Negative nose up 
aileron = 0;
rudder = 0;
throtle = 1;

control = [elevator, aileron, rudder, throtle];

%% Engine Placement and Orientation
%Left
Vect_L=[0.998,-0.057,0.017];%
%Toe Out 3.25deg, pitch down by 1 deg
Pos_L=[-3.6507-xAC,5.1875,0];%position of propeller disc
%Right
Vect_R=[0.998,0.057,0.017];%
Pos_R=[-3.6507-xAC,-5.1875,0];%