%���ܣ����ɽ��ı����
%���룺��ֵ��ĸ߳�ֵ
%��������
%���ߣ�QingLing.Zhu email:qlzhu1991@gmail.com
%ʱ�䣺2014-3-18

S=0;%��ʼ�����Ϊ0
for i=1:(Yn-1)
    for j=1:(Xn-1)
        %��Z(i,j),Z(i,j+1),z(i+1,j),z(i+1��j+1)Χ�ɵ��ı��εĶԽ��߳���
        d=sqrt((X(i,j+1)-X(i+1,j))^2+(Y(i,j+1)-Y(i+1,j))^2);
        %���P=(a+b+c)/2
        P=(deltaX+deltaY+d)/2;
        %���S���ú��׹�ʽ
        S=S+sqrt(P*(P-deltaX)*(P-deltaY)*(P-d));
    end 
end

fprintf('�����Ϊ��%d\n',S);