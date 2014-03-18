%功能：R3--无复用逐点计算可视域法
%输入：isVisible:可视性矩阵，S视点，stature人高，高程数据
%输出：可视性矩阵，时间
%作者：QingLing.Zhu email:qlzhu1991@gmail.com
%时间：2014-3-18
%扫描该线上所有的点，假设待确定点T，ST线段上所有点高于曲线上对应的点。
function [isVisiableOut,time]=R3(isVisiable,S,stature,DEM_X,DEM_Y,DEM_Z)
tic;
X=DEM_X;Y=DEM_Y;Z=DEM_Z;
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
SpointX=S(1);SpointY=S(2);
hold on;plot3(DEM_X(1,SpointX),DEM_Y(SpointY,1),DEM_Z(SpointY,SpointX)+stature,'ow');
for ii=1:Xn
    for jj=1:Yn
        TpointX=ii;TpointY=jj;      
        section=sectionOfTwoPoint(S,[TpointX,TpointY],DEM_X,DEM_Y,DEM_Z);
        tempxx=section(:,1);tempyy=section(:,2);tempzz=section(:,3);
        %for i=1:size(tempzz,1)
            %判断点T（X(1,TpointX),Y(TpointY,1),Z(TpointY,TpointX)点的可视性    
            flag=0;
            %|-----|-----|----->X轴
            %|-----|-----|
            %|-----|-----|
            %|
            %Y轴
            if SpointX==TpointX %%对垂直进行处理,用tempyy里面的值作为X轴
               % 视点S(SpointX,SpointY),目标点T(TpointX,TpointY)之间的直线，用k1,b1表示
                k1=(Z(TpointY,TpointX)-Z(SpointY,SpointX)-stature)/(Y(TpointY,1)-Y(SpointY,1));
                b1=Z(TpointY,TpointX)-k1*Y(TpointY,1);
                if SpointY<TpointY
                    for j=1:size(tempzz,1)%开始点就是视点%%%%这里为什么要出去目标点本身？？？？       
                        temp=k1*tempyy(j,1)+b1;
                        %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                        if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                            flag=1;break;
                        end
                    end
                else%末点是视点
                    for j=size(tempzz,1)-1:-1:1%要去掉视点本身
                        temp=k1*tempyy(j,1)+b1;
                        %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                        if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                            flag=1;break;
                        end
                    end
                end
            %elseif horizontal_flag==1%%对水平进行处理        
            else%%其他使用tempxx作为X轴
                % 视点S(SpointX,SpointY),目标点T(TpointX,TpointY)之间的直线，用k1,b1表示
                k1=(Z(TpointY,TpointX)-Z(SpointY,SpointX)-stature)/(X(1,TpointX)-X(1,SpointX));
                b1=Z(TpointY,TpointX)-k1*X(1,TpointX);

                %对视点到目标点进行扫描
                if SpointX<TpointX
                    for j=1:size(tempzz,1)-1%开始点就是视点%%%%这里为什么要出去目标点本身？？？？这里还需调整TpointX<tempxx     
                        temp=k1*tempxx(j,1)+b1;%j点在直线上对应的高程值
                        %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                        if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                            flag=1;break;
                        end
                    end
                else%末点是视点
                    for j=size(tempzz,1)-1:-1:1%要去掉视点本身
                        temp=k1*tempxx(j,1)+b1;
                        %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                        if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                            flag=1;break;
                        end
                    end
                end
            end
            if(flag==0)
                plot3(X(1,TpointX),Y(TpointY,1),Z(TpointY,TpointX),'*r','MarkerSize',5);%将该T点变成红色
                isVisiable(TpointY,TpointX)=1;
            else
                isVisiable(TpointY,TpointX)=0;
            end

        %end
    end
end
isVisiableOut=isVisiable;
time=toc;