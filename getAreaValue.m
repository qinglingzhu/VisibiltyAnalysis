%功能：求得山体的表面积
%输入：插值后的高程值
%输出：面积
%作者：QingLing.Zhu email:qlzhu1991@gmail.com
%时间：2014-3-18

S=0;%初始化面积为0
for i=1:(Yn-1)
    for j=1:(Xn-1)
        %求Z(i,j),Z(i,j+1),z(i+1,j),z(i+1，j+1)围成的四边形的对角线长度
        d=sqrt((X(i,j+1)-X(i+1,j))^2+(Y(i,j+1)-Y(i+1,j))^2);
        %求得P=(a+b+c)/2
        P=(deltaX+deltaY+d)/2;
        %求得S，用海伦公式
        S=S+sqrt(P*(P-deltaX)*(P-deltaY)*(P-d));
    end 
end

fprintf('总面积为：%d\n',S);