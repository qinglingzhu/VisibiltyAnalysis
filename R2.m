%功能：R2方法可视性分析LOS,对断面上的每一点进行分析
%输入：isVisible:可视性矩阵，S视点，stature人高，高程数据
%输出：可视性矩阵，时间
%作者：QingLing.Zhu email:qlzhu1991@gmail.com
%时间：2014-3-18

%方法：扫描该线上所有的点，假设待确定点T，ST线段上所有点高于曲线上对应的点。
function [isVisiableOut,time]=R2(isVisiable,S,stature,DEM_X,DEM_Y,DEM_Z)
tic;
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
distance=ones(Yn,Xn)*Inf;
%对边界扫描x=1,y=1~Yn
for ii=1:Yn
    TpointX=1;TpointY=ii;
    section=sectionOfTwoPoint(S,[TpointX,TpointY],DEM_X,DEM_Y,DEM_Z);
    [distance, isVisiable]=TOS(distance,isVisiable,S,[TpointX,TpointY],stature,section,DEM_X,DEM_Y,DEM_Z);
end
%x=Xn,y=1~Yn
for ii=1:Yn
    TpointX=Xn;TpointY=ii;
    section=sectionOfTwoPoint(S,[TpointX,TpointY],DEM_X,DEM_Y,DEM_Z);
    [distance, isVisiable]=TOS(distance,isVisiable,S,[TpointX,TpointY],stature,section,DEM_X,DEM_Y,DEM_Z);
end
%x=1~Xn,y=1
for ii=1:Xn
    TpointX=ii;TpointY=1;
    section=sectionOfTwoPoint(S,[TpointX,TpointY],DEM_X,DEM_Y,DEM_Z);
    [distance, isVisiable]=TOS(distance,isVisiable,S,[TpointX,TpointY],stature,section,DEM_X,DEM_Y,DEM_Z);
end
%x=1~Xn,y=Yn
for ii=1:Xn
    TpointX=ii;TpointY=Yn;
    section=sectionOfTwoPoint(S,[TpointX,TpointY],DEM_X,DEM_Y,DEM_Z);
    [distance, isVisiable]=TOS(distance,isVisiable,S,[TpointX,TpointY],stature,section,DEM_X,DEM_Y,DEM_Z);
end
isVisiableOut=isVisiable;
time=toc;
function [distance, isVisiable]=TOS(distance,isVisiable,S,T,stature,section,DEM_X,DEM_Y,DEM_Z)
tempxx=section(:,1);tempyy=section(:,2);tempzz=section(:,3);
X=DEM_X;Y=DEM_Y;Z=DEM_Z;
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
deltaX=DEM_X(end)/(Xn-1);deltaY=DEM_Y(end)/(Yn-1);
SpointX=S(1);SpointY=S(2);TpointX=T(1);TpointY=T(2);
%方法：扫描该线上所有的点，假设待确定点T，ST线段上所有点高于曲线上对应的点。
for i=1:size(tempzz,1)
    %判断点T（X(1,TpointX),Y(TpointY,1),Z(TpointY,TpointX)点的可视性    
    flag=0;
    %|-----|-----|----->X轴
    %|-----|-----|
    %|-----|-----|
    %|
    %Y轴
    if SpointX==TpointX%%对垂直进行处理,用tempyy里面的值作为X轴
        %T到视点（tempxx(viewpoint,1),tempyy(viewpoint,1),tempzz(viewpoint,1))直线的斜率
        k1=(tempzz(i,1)-Z(SpointY,SpointX)-stature)/(tempyy(i,1)-Y(SpointY,1));
        %b=tempzz(viewpoint,1)+stature-k*tempxx(viewpoint,1);
        b1=tempzz(i,1)-k1*tempyy(i,1);
        if SpointY<TpointY
            for j=1:i%开始点就是视点%%%%这里为什么要出去目标点本身？？？？       
                temp=k1*tempyy(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                    flag=1;break;
                end
            end
        else%末点是视点
            for j=size(tempzz,1)-1:-1:i%要去掉视点本身
                temp=k1*tempyy(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                    flag=1;break;
                end
            end
        end
    %elseif horizontal_flag==1%%对水平进行处理        
    else%%其他使用tempxx作为X轴
        %T到视点（tempxx(viewpoint,1),tempyy(viewpoint,1),tempzz(viewpoint,1))直线的斜率
        k1=(tempzz(i,1)-Z(SpointY,SpointX)-stature)/(tempxx(i,1)-X(1,SpointX));
        %b=tempzz(viewpoint,1)+stature-k*tempxx(viewpoint,1);
        b1=tempzz(i,1)-k1*tempxx(i,1);
            
        %对视点到目标点进行扫描
        if SpointX<TpointX
            for j=1:i%开始点就是视点%%%%这里为什么要出去目标点本身？？？？这里还需调整TpointX<tempxx     
                temp=k1*tempxx(j,1)+b1;%j点在直线上对应的高程值
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                    flag=1;break;
                end
            end
        else%末点是视点
            for j=size(tempzz,1)-1:-1:i%要去掉视点本身%%%这里是减到1还是i呢？？？？？
                temp=k1*tempxx(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                    flag=1;break;
                end
            end
        end
    end
    %若直线上的i点可视
    if(flag==0)
        %其最近点为可视
        xi=round(tempxx(i,1)/deltaX);yi=round(tempyy(i,1)/deltaY);%对x和y取整
        %hold on;plot3(xi*deltaX,yi*deltaY,Z(yi,xi),'*r','MarkerSize',5);        
%         if xi==tempxx(i,1)/deltaX && abs(yi-tempyy(i,1)/deltaY)<distance(yi,xi)%与y相交
%             distance(yi,xi)=abs(yi-tempyy(i,1)/deltaY);isVisiable(yi,xi)=1;  
%             hold on;plot3(xi*deltaX,yi*deltaY,Z(yi,xi),'*r','MarkerSize',5); 
%         elseif yi==tempyy(i,1)/deltaY &&distance(yi,xi)>abs(xi-tempxx(i,1)/deltaX)%与x相交
%             distance(yi,xi)=abs(xi-tempxx(i,1)/deltaX);isVisiable(yi,xi)=1;  
%             hold on;plot3(xi*deltaX,yi*deltaY,Z(yi,xi),'*r','MarkerSize',5); 
%         else%既不在x轴上也不在y轴上
%             d=sqrt((abs(xi-tempxx(i,1)/deltaX))^2+(yi-tempyy(i,1)/deltaY)^2);
%             if(distance(yi,xi)>d)
%                 
%         end
        d=sqrt((abs(xi-tempxx(i,1)/deltaX))^2+(yi-tempyy(i,1)/deltaY)^2);
        if(distance(yi,xi)>d)
            distance(yi,xi)=d;isVisiable(yi,xi)=1;  
            plot3(xi*deltaX,yi*deltaY,Z(yi,xi),'*r','MarkerSize',5); 
        end
        %hold on;plot3(xi*deltaX,yi*deltaY,Z(yi,xi),'*r','MarkerSize',5); 
        %hold on;plot3(tempxx(i,1),tempyy(i,1),tempzz(i,1),'*r');%将该T点变成红色
        %isVisiable(TpointY,TpointX)=1;
    else
        %hold on;plot3(tempxx(i,1),tempyy(i,1),tempzz(i,1),'or');%将该T点变成红色
    end
end
distanceOut=distance;isVisiableOut=isVisiable;