%���ܣ�������
%���ߣ�QingLing.Zhu email:qlzhu1991@gmail.com
%ʱ�䣺2014-3-18

clear;clc;
Command_disp;
TestNO=input('��ѡ��');
switch TestNO 
    case 1% �õ�dem����
        [DEM_X,DEM_Y,DEM_Z]=getDEM('dem_data.txt');
        Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
        deltaX=DEM_X(end)/(Xn-1);deltaY=DEM_Y(end)/(Yn-1);
        surf(DEM_X,DEM_Y,DEM_Z);
    case 2% ���������һ���������������µ���������ʱ��hight_ref=0�ȿ������
        getVolumeValue;
    case 3% ���ܱ����
        getAreaValue;
    %% ������
    case 4% �������S,T֮��Ķ���
        [DEM_X,DEM_Y,DEM_Z]=getDEM('dem_data.txt');
        Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
        S=[5,1];T=[5,Yn];        
        section=sectionOfTwoPoint(S,T,DEM_X,DEM_Y,DEM_Z);
        figure(1);clf;hold on;stem3(section(:,1),section(:,2),section(:,3),'fill','MarkerSize',3);%�����ö���
        %hold on;surf(DEM_X,DEM_Y,DEM_Z);hold off;
    case 5% ����֮��Ŀ����Է���LOS��Line Of Sight��            
        [DEM_X,DEM_Y,DEM_Z]=getDEM('dem_data.txt');
        Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
        S=[5,1];T=[5,Yn];stature=20;
        figure(1);clf;hold on;plot3(DEM_X(5),DEM_Y(1),DEM_Z(1,5)+stature,'or');%�����ӵ�
        section=sectionOfTwoPoint(S,T,DEM_X,DEM_Y,DEM_Z);
        stem3(section(:,1),section(:,2),section(:,3),'fill','MarkerSize',3);%�����ö���
        LOS(S,T,stature,section,DEM_X,DEM_Y,DEM_Z);
    case 6%R3��R2������ÿ����򣬲��Ա����ַ���  
        CM=[0.49,0,0.83];
        CM=repmat(CM,64,1);
        colormap(CM);
        SpointX=20;SpointY=50;%�ӵ�����
        S=[SpointX,SpointY];stature=20;%�ӵ��һЩ
        
        [DEM_X,DEM_Y,DEM_Z]=getDEM('dem_data.txt');
        Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
        
        figure(1);clf;title('R3�������������');hold on;%gtext('SKSK');��ʾ
        surf(DEM_X,DEM_Y,DEM_Z);
        isVisiable=zeros(Yn,Xn);%��ʼ��
        [isVisiable,time]=R3(isVisiable,S,stature,DEM_X,DEM_Y,DEM_Z);
        fprintf('R3�����������������ʱ��Ϊ��%d\n',time);            
        fprintf('R3�����������������Ϊ��%d\n',getVisualArea(isVisiable,DEM_X,DEM_Y));
        hold off;figure(2);clf;title('R2�������������');hold on;
        %surf(DEM_X,DEM_Y,DEM_Z);
        isVisiable=zeros(Yn,Xn);%��ʼ��
        [isVisiable,time]=R2(isVisiable,S,stature,DEM_X,DEM_Y,DEM_Z);
        fprintf('R2�����������������ʱ��Ϊ��%d\n',time);            
        fprintf('R2�����������������Ϊ��%d\n',getVisualArea(isVisiable,DEM_X,DEM_Y));
        hold off; 
    case 7%Split������ȡ������
        Split;
    otherwise
end