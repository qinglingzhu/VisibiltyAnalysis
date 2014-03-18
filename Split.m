%功能：Split方法求得特征值，极大极小值
%输入：null
%输出：null
%作者：QingLing.Zhu email:qlzhu1991@gmail.com
%时间：2014-3-18
%dem数据->断面->Split断面的特征点
function Split()
clear;clc;
%得到dem数据
[DEM_X,DEM_Y,DEM_Z]=getDEM('dem_data.txt');
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
deltaX=DEM_X(end)/(Xn-1);deltaY=DEM_Y(end)/(Yn-1);
%得到两点之间的断面
SpointX=1;SpointY=1;TpointX=Xn;TpointY=Yn;
section=sectionOfTwoPoint([1,1],[Xn,Yn],DEM_X,DEM_Y,DEM_Z);
figure(1);clf;hold on;stem3(section(:,1),section(:,2),section(:,3),'fill','MarkerSize',3);%画出该断面
%% Split方法
%求起始点和末尾点的直线
SX=(SpointX-1)*deltaX;SY=(SpointY-1)*deltaY;SZ=DEM_Z(SpointY,SpointX);%起始坐标(网格系统)--->转换为像素点坐标
TX=(TpointX-1)*deltaX;TY=(TpointY-1)*deltaY;TZ=DEM_Z(TpointY,TpointX);
S=[SX,SY,SZ];T=[TX,TY,TZ];
getFeaturePoint(S,T,section);%S和T是像素点坐标系统
