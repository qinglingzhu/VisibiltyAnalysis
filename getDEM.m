%���ܣ����ɵȸ���ȡ�õ����ݽ��в�ֵ
%���룺�ļ��ĸ�ʽ��x,y,z)
%��������������ĸ߳�
%���ߣ�QingLing.Zhu email:qlzhu1991@gmail.com
%ʱ�䣺2014-3-18

function [DEM_X,DEM_Y,DEM_Z]=getDEM(file)
%% �ӵȸ��������У��õ�dem����
%�����ļ�������ɢ���x,y,z������
A=load(file);
x=A(:,1);y=A(:,2);z=A(:,3);
xmin=min(x);xmax=max(x);
ymin=min(y);ymax=max(y);
%��Ϊȡ���ʱ��y��ȡ��ֵ�����ǵ��ӽǲ�һ��������������Ҫת��һ�£���
y=ones(size(y,1),1)*ymax-y;
%Xn��Yn��ʾ��x��ָ��Xn�ݣ���y��ָ��Yn��
Xn=62;Yn=92;
deltaX=(xmax-xmin)/(Xn-1);
deltaY=(ymax-ymin)/(Yn-1);
fprintf('x����СֵΪ��%d,���ֵΪ:%d,deltaxֵΪ��%d\n',xmin,xmax,deltaX);
fprintf('y����СֵΪ��%d,���ֵΪ:%d,deltayֵΪ��%d\n',ymin,ymax,deltaY);
pause(0.1);
[X,Y,Z]=griddata(x,y,z,linspace(xmin,xmax,Xn)',linspace(ymin,ymax,Yn),'v4');%��ֵ
%��Z�ᶼ��10����֤��0��ʼ
for i=1:Yn
    for j=1:Xn
        Z(i,j)=Z(i,j)+8;
    end
end
DEM_X=X(1,:);DEM_Y=Y(:,1);DEM_Z=Z;