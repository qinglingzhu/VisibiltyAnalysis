%功能：求得三维地面的体积，相对于地面
%输入：插值后的数据
%输出：山体体积
%作者：QingLing.Zhu email:qlzhu1991@gmail.com
%时间：2014-3-18

%求四个顶点的高程，要除4
h1=0;h2=0;h3=0;
h1=Z(1,1)+Z(1,Xn)+Z(Yn,1)+Z(Yn,Xn);
h1=h1/4;
%求四条边的高程，要除2
for i=2:Yn-1
    h2=h2+Z(i,1);
end
for i=2:Yn-1
    h2=h2+Z(i,Xn);
end
for i=2:Xn-1
    h2=h2+Z(1,i);
end
for i=2:Xn-1
    h2=h2+Z(Yn,i);
end
h2=h2/2;
%求中间各个点的高程
for i=2:Yn-1
    for j=1:Xn-1
        h3=h3+Z(i,j);
    end
end
h=h1+h2+h3;
%求得体积
V=deltaX*deltaY*h;
fprintf('体积为：%d\n',V);
pause(0.1);