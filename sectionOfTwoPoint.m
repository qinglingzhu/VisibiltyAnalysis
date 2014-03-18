%功能：两点之间的断面
%输入：S视点，T目标点，高程数据
%输出：断面信息
%作者：QingLing.Zhu email:qlzhu1991@gmail.com
%时间：2014-3-18

%% 视点S(SpointX,SpointY),目标点T(TpointX,TpointY)之间的断面
function section=sectionOfTwoPoint(S,T,DEM_X,DEM_Y,DEM_Z)
SpointX=S(1);SpointY=S(2);TpointX=T(1);TpointY=T(2);
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
deltaX=DEM_X(end)/(Xn-1);deltaY=DEM_Y(end)/(Yn-1);Z=DEM_Z;
%这里要注意水平和垂直的情况
vertical_flag=0;horizontal_flag=0;%水平和垂直标志
if SpointX==TpointX 
    vertical_flag=1;
elseif SpointY==TpointY
    horizontal_flag=1;
else
   k=(TpointY-SpointY)/(TpointX-SpointX);b=TpointY-k*TpointX;%非水平垂直的情况
end
tempxx=0;tempyy=0;tempzz=0;index=1;%保存该断面上的点
%遍历x轴上的网格
for i=min([SpointX,TpointX]):max([SpointX,TpointX])
    tempx=i;
    if vertical_flag==1%若垂直与x轴的话，即x都相等。则退出
        break;
    elseif horizontal_flag==1
        tempy=SpointY;
    else
       tempy=k*tempx+b;%由tempx求直线上的y
    end
    tempy1=floor(tempy+0.00000001);tempy2=ceil(tempy-0.000001);%取得tempy的上下限
    %这种方法也可以，但是不知道tempy是凸的还是凹的，所以不是很好求，还有待改进
    %tempz=abs(tempy-tempy1)*abs(Z(tempy2,tempx)-Z(tempy1,tempx))+Z(tempy1,tempx);   
    %if(tempy==tempy1&&tempy==tempy2)%这种情况是：刚好在网格点上的点，上下限都是一样的
    %上面的，当tempy=1是，会有误差出现
    if(tempy1==tempy2)
        tempz=Z(tempy1,tempx);
    else
        %按比例求得，离得近的比例大些。
        tempz=Z(tempy1,tempx)*abs(tempy-tempy2)+Z(tempy2,tempx)*abs(tempy-tempy1);
    end
    tempxx(index,1)=(tempx-1)*deltaX;tempyy(index,1)=(tempy-1)*deltaY;tempzz(index,1)=tempz;
    index=index+1;
    %stem3(tempx,tempy,tempz,'fill');hold on;%这里注意一下，使用网格点作为坐标系统，而非是像素点
    %hold on;stem3(tempx*deltaX,tempy*deltaY,tempz,'fill','MarkerSize',3);%使用像素坐标系统画出该点的
end
%遍历y轴上的网格
for i=min([SpointY,TpointY]):max([SpointY,TpointY])
	tempy=i;
    if vertical_flag==1%若垂直与x轴的话，即x都相等。则退出
        tempx=SpointX;
    elseif horizontal_flag==1
        break;%平行于x轴的情况
    else
        tempx=(tempy-b)/k;
    end
    tempx1=floor(tempx+0.0000001);tempx2=ceil(tempx-0.0000001);
    %tempz=abs(tempx-tempx1)*abs(Z(tempy,tempx2)-Z(tempy,tempx1))+Z(tempy,tempx1); 
    %当tempx=tempx1=tempx2时
    %if(tempx==tempx1&&tempx==tempx2)
    if tempx1==tempx2
        tempz=Z(tempy,tempx1);
        if SpointX~=TpointX
            continue;
        end
    else
        tempz=Z(tempy,tempx1)*abs(tempx-tempx2)+Z(tempy,tempx2)*abs(tempx-tempx1);
    end
    %stem3(tempx*deltaX,tempy*deltaY,tempz,'fill','MarkerSize',3);hold on;
    tempxx(index,1)=(tempx-1)*deltaX;tempyy(index,1)=(tempy-1)*deltaY;tempzz(index,1)=tempz;
    index=index+1;
end
%对tempxx,tempyy,tempzz重新排序
[tempxx,ss]=sort(tempxx);
tempyy=tempyy(ss,:);
tempzz=tempzz(ss,:);
section=[tempxx,tempyy,tempzz];