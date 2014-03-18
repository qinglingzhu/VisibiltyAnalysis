%% 计算可视域面积
%功能：计算有可视域分析方法得到的可视域面积
%输入：可视性矩阵，高程数据
%输出：可视域面积
%作者：QingLing.Zhu email:qlzhu1991@gmail.com
%时间：2014-3-18
%若四个点都为可视，则计算该格网面积
function areaValue=getVisualArea(isVisiable,DEM_X,DEM_Y)
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
deltaX=DEM_X(end)/(Xn-1);deltaY=DEM_Y(end)/(Yn-1);
S=0;%初始化面积为0
for i=1:(Yn-1)
    for j=1:(Xn-1)
        %求Z(i,j),Z(i,j+1),z(i+1,j),z(i+1，j+1)围成的四边形的对角线长度
        if isVisiable(i,j)==1 &&isVisiable(i,j+1)==1 &&isVisiable(i+1,j)==1 &&isVisiable(i+1,j+1)==1 
            d=sqrt(deltaX^2+deltaY^2);
            %求得P=(a+b+c)/2
            P=(deltaX+deltaY+d)/2;
            %求得S，用海伦公式
            S=S+sqrt(P*(P-deltaX)*(P-deltaY)*(P-d));
            %plot3(X(i,j),Y(i,j),Z(i,j),'or');
        else
            %plot3(X(i,j),Y(i,j),Z(i,j),'ob');
        end
        
    end 
end
areaValue=S;