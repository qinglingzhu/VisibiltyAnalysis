%���ܣ�Split�����������ֵ������Сֵ
%���룺null
%�����null
%���ߣ�QingLing.Zhu email:qlzhu1991@gmail.com
%ʱ�䣺2014-3-18
%dem����->����->Split�����������
function Split()
clear;clc;
%�õ�dem����
[DEM_X,DEM_Y,DEM_Z]=getDEM('dem_data.txt');
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
deltaX=DEM_X(end)/(Xn-1);deltaY=DEM_Y(end)/(Yn-1);
%�õ�����֮��Ķ���
SpointX=1;SpointY=1;TpointX=Xn;TpointY=Yn;
section=sectionOfTwoPoint([1,1],[Xn,Yn],DEM_X,DEM_Y,DEM_Z);
figure(1);clf;hold on;stem3(section(:,1),section(:,2),section(:,3),'fill','MarkerSize',3);%�����ö���
%% Split����
%����ʼ���ĩβ���ֱ��
SX=(SpointX-1)*deltaX;SY=(SpointY-1)*deltaY;SZ=DEM_Z(SpointY,SpointX);%��ʼ����(����ϵͳ)--->ת��Ϊ���ص�����
TX=(TpointX-1)*deltaX;TY=(TpointY-1)*deltaY;TZ=DEM_Z(TpointY,TpointX);
S=[SX,SY,SZ];T=[TX,TY,TZ];
getFeaturePoint(S,T,section);%S��T�����ص�����ϵͳ
