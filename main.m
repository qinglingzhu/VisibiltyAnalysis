%功能：主程序
%作者：QingLing.Zhu email:qlzhu1991@gmail.com
%时间：2014-3-18

clear;clc;
Command_disp;
TestNO=input('请选择：');
switch TestNO 
    case 1% 得到dem数据
        [DEM_X,DEM_Y,DEM_Z]=getDEM('dem_data.txt');
        Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
        deltaX=DEM_X(end)/(Xn-1);deltaY=DEM_Y(end)/(Yn-1);
        surf(DEM_X,DEM_Y,DEM_Z);
    case 2% 求体积方法一，方法二在求上下等体积断面的时候将hight_ref=0既可以求得
        getVolumeValue;
    case 3% 求总表面积
        getAreaValue;
    %% 求等体高
    case 4% 求出两点S,T之间的断面
        [DEM_X,DEM_Y,DEM_Z]=getDEM('dem_data.txt');
        Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
        S=[5,1];T=[5,Yn];        
        section=sectionOfTwoPoint(S,T,DEM_X,DEM_Y,DEM_Z);
        figure(1);clf;hold on;stem3(section(:,1),section(:,2),section(:,3),'fill','MarkerSize',3);%画出该断面
        %hold on;surf(DEM_X,DEM_Y,DEM_Z);hold off;
    case 5% 两点之间的可视性分析LOS（Line Of Sight）            
        [DEM_X,DEM_Y,DEM_Z]=getDEM('dem_data.txt');
        Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
        S=[5,1];T=[5,Yn];stature=20;
        figure(1);clf;hold on;plot3(DEM_X(5),DEM_Y(1),DEM_Z(1,5)+stature,'or');%画出视点
        section=sectionOfTwoPoint(S,T,DEM_X,DEM_Y,DEM_Z);
        stem3(section(:,1),section(:,2),section(:,3),'fill','MarkerSize',3);%画出该断面
        LOS(S,T,stature,section,DEM_X,DEM_Y,DEM_Z);
    case 6%R3和R2方法求得可视域，并对比两种方法  
        CM=[0.49,0,0.83];
        CM=repmat(CM,64,1);
        colormap(CM);
        SpointX=20;SpointY=50;%视点坐标
        S=[SpointX,SpointY];stature=20;%视点高一些
        
        [DEM_X,DEM_Y,DEM_Z]=getDEM('dem_data.txt');
        Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
        
        figure(1);clf;title('R3方法计算可视域');hold on;%gtext('SKSK');标示
        surf(DEM_X,DEM_Y,DEM_Z);
        isVisiable=zeros(Yn,Xn);%初始化
        [isVisiable,time]=R3(isVisiable,S,stature,DEM_X,DEM_Y,DEM_Z);
        fprintf('R3方法计算可视域所花时间为：%d\n',time);            
        fprintf('R3方法计算可视域的面积为：%d\n',getVisualArea(isVisiable,DEM_X,DEM_Y));
        hold off;figure(2);clf;title('R2方法计算可视域');hold on;
        %surf(DEM_X,DEM_Y,DEM_Z);
        isVisiable=zeros(Yn,Xn);%初始化
        [isVisiable,time]=R2(isVisiable,S,stature,DEM_X,DEM_Y,DEM_Z);
        fprintf('R2方法计算可视域所花时间为：%d\n',time);            
        fprintf('R2方法计算可视域的面积为：%d\n',getVisualArea(isVisiable,DEM_X,DEM_Y));
        hold off; 
    case 7%Split方法获取特征点
        Split;
    otherwise
end