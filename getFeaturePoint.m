%功能：输入起始点S和末尾点T,计算之间的特征点
%输入：S1起始点，T1末尾点，section断面
%输出：null
%作者：QingLing.Zhu email:qlzhu1991@gmail.com
%时间：2014-3-18

function getFeaturePoint(S1,T1,section)
%阀值设定为
threshold=20;
tempxx=section(:,1);tempyy=section(:,2);tempzz=section(:,3);
plot3([S1(1);T1(1)],[S1(2);T1(2)],[S1(3);T1(3)]);%画出起始点到末点的直线
k1=(T1(3)-S1(3))/(T1(1)-S1(1));b1=T1(3)-k1*T1(1);
A=k1;B=-1;C=b1; 
d=abs(A*tempxx+B*tempzz+C)/sqrt(A^2+B^2);
[value,index]=max(d);
hold on;plot3(tempxx(index),tempyy(index),tempzz(index),'or'); 
featurePoint=[tempxx(index),tempyy(index),tempzz(index)];
if d(index)>threshold
    getFeaturePoint(S1,featurePoint,section(1:index,:));
    getFeaturePoint(featurePoint,T1,section(index:size(section,1),:));
end