%% ������������
%���ܣ������п�������������õ��Ŀ��������
%���룺�����Ծ��󣬸߳�����
%��������������
%���ߣ�QingLing.Zhu email:qlzhu1991@gmail.com
%ʱ�䣺2014-3-18
%���ĸ��㶼Ϊ���ӣ������ø������
function areaValue=getVisualArea(isVisiable,DEM_X,DEM_Y)
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
deltaX=DEM_X(end)/(Xn-1);deltaY=DEM_Y(end)/(Yn-1);
S=0;%��ʼ�����Ϊ0
for i=1:(Yn-1)
    for j=1:(Xn-1)
        %��Z(i,j),Z(i,j+1),z(i+1,j),z(i+1��j+1)Χ�ɵ��ı��εĶԽ��߳���
        if isVisiable(i,j)==1 &&isVisiable(i,j+1)==1 &&isVisiable(i+1,j)==1 &&isVisiable(i+1,j+1)==1 
            d=sqrt(deltaX^2+deltaY^2);
            %���P=(a+b+c)/2
            P=(deltaX+deltaY+d)/2;
            %���S���ú��׹�ʽ
            S=S+sqrt(P*(P-deltaX)*(P-deltaY)*(P-d));
            %plot3(X(i,j),Y(i,j),Z(i,j),'or');
        else
            %plot3(X(i,j),Y(i,j),Z(i,j),'ob');
        end
        
    end 
end
areaValue=S;