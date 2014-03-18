%功能：两点之间的可视性分析LOS（Line Of Sight）
%输入：S视点，T目标点，高程数据
%输出：null
%作者：QingLing.Zhu email:qlzhu1991@gmail.com
%时间：2014-3-18

%方法：扫描该线上所有的点，假设待确定点T，OT线段上所有点高于曲线上对应的点。
function LOS(S,T,stature,section,DEM_X,DEM_Y,DEM_Z)
tempxx=section(:,1);tempyy=section(:,2);tempzz=section(:,3);
X=DEM_X;Y=DEM_Y;Z=DEM_Z;
SpointX=S(1);SpointY=S(2);TpointX=T(1);TpointY=T(2);
for i=1:size(tempzz,1)
    %对于点T（tempxx(i,1),tempyy(i,1),tempzz(i,1)）点的可视性
    flag=0;
    if size(unique(tempxx),1)==1%%对垂直进行处理,用Y轴作为X轴
        %T到视点（tempxx(viewpoint,1),tempyy(viewpoint,1),tempzz(viewpoint,1))直线的斜率
        k1=(tempzz(i,1)-Z(SpointY,SpointX)-stature)/(tempyy(i,1)-Y(SpointY,1));
        %b=tempzz(viewpoint,1)+stature-k*tempxx(viewpoint,1);
        b1=tempzz(i,1)-k1*tempyy(i,1);
        if SpointY<TpointY
            for j=1:i%开始点就是视点
                temp=k1*tempyy(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                    flag=1;break;
                end
            end
        else
            for j=size(tempzz,1)-1:-1:i%要去掉该点本身
                temp=k1*tempyy(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                    flag=1;break;
                end
            end
        end
    %elseif horizontal_flag==1%%对水平进行处理        
    else%%其他使用X轴
        %T到视点（tempxx(viewpoint,1),tempyy(viewpoint,1),tempzz(viewpoint,1))直线的斜率
        k1=(tempzz(i,1)-Z(SpointY,SpointX)-stature)/(tempxx(i,1)-X(1,SpointX));
        %b=tempzz(viewpoint,1)+stature-k*tempxx(viewpoint,1);
        b1=tempzz(i,1)-k1*tempxx(i,1);
        if SpointX<TpointX
            for j=1:i%开始点就是视点
                temp=k1*tempxx(j,1)+b1;
                hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                    flag=1;break;
                end
            end
        else
            for j=size(tempzz,1)-1:-1:i%要去掉该点本身
                temp=k1*tempxx(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%防止有一点点误差吧。有点搞不懂
                    flag=1;break;
                end
            end
        end
    end
    if(flag==0)
        hold on;
        plot3(tempxx(i,1),tempyy(i,1),tempzz(i,1),'*r');%将该T点变成红色
    end
end