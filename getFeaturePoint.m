%���ܣ�������ʼ��S��ĩβ��T,����֮���������
%���룺S1��ʼ�㣬T1ĩβ�㣬section����
%�����null
%���ߣ�QingLing.Zhu email:qlzhu1991@gmail.com
%ʱ�䣺2014-3-18

function getFeaturePoint(S1,T1,section)
%��ֵ�趨Ϊ
threshold=20;
tempxx=section(:,1);tempyy=section(:,2);tempzz=section(:,3);
plot3([S1(1);T1(1)],[S1(2);T1(2)],[S1(3);T1(3)]);%������ʼ�㵽ĩ���ֱ��
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