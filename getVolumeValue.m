%���ܣ������ά��������������ڵ���
%���룺��ֵ�������
%�����ɽ�����
%���ߣ�QingLing.Zhu email:qlzhu1991@gmail.com
%ʱ�䣺2014-3-18

%���ĸ�����ĸ̣߳�Ҫ��4
h1=0;h2=0;h3=0;
h1=Z(1,1)+Z(1,Xn)+Z(Yn,1)+Z(Yn,Xn);
h1=h1/4;
%�������ߵĸ̣߳�Ҫ��2
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
%���м������ĸ߳�
for i=2:Yn-1
    for j=1:Xn-1
        h3=h3+Z(i,j);
    end
end
h=h1+h2+h3;
%������
V=deltaX*deltaY*h;
fprintf('���Ϊ��%d\n',V);
pause(0.1);