%���ܣ�R2���������Է���LOS,�Զ����ϵ�ÿһ����з���
%���룺isVisible:�����Ծ���S�ӵ㣬stature�˸ߣ��߳�����
%����������Ծ���ʱ��
%���ߣ�QingLing.Zhu email:qlzhu1991@gmail.com
%ʱ�䣺2014-3-18

%������ɨ����������еĵ㣬�����ȷ����T��ST�߶������е���������϶�Ӧ�ĵ㡣
function [isVisiableOut,time]=R2(isVisiable,S,stature,DEM_X,DEM_Y,DEM_Z)
tic;
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
distance=ones(Yn,Xn)*Inf;
%�Ա߽�ɨ��x=1,y=1~Yn
for ii=1:Yn
    TpointX=1;TpointY=ii;
    section=sectionOfTwoPoint(S,[TpointX,TpointY],DEM_X,DEM_Y,DEM_Z);
    [distance, isVisiable]=TOS(distance,isVisiable,S,[TpointX,TpointY],stature,section,DEM_X,DEM_Y,DEM_Z);
end
%x=Xn,y=1~Yn
for ii=1:Yn
    TpointX=Xn;TpointY=ii;
    section=sectionOfTwoPoint(S,[TpointX,TpointY],DEM_X,DEM_Y,DEM_Z);
    [distance, isVisiable]=TOS(distance,isVisiable,S,[TpointX,TpointY],stature,section,DEM_X,DEM_Y,DEM_Z);
end
%x=1~Xn,y=1
for ii=1:Xn
    TpointX=ii;TpointY=1;
    section=sectionOfTwoPoint(S,[TpointX,TpointY],DEM_X,DEM_Y,DEM_Z);
    [distance, isVisiable]=TOS(distance,isVisiable,S,[TpointX,TpointY],stature,section,DEM_X,DEM_Y,DEM_Z);
end
%x=1~Xn,y=Yn
for ii=1:Xn
    TpointX=ii;TpointY=Yn;
    section=sectionOfTwoPoint(S,[TpointX,TpointY],DEM_X,DEM_Y,DEM_Z);
    [distance, isVisiable]=TOS(distance,isVisiable,S,[TpointX,TpointY],stature,section,DEM_X,DEM_Y,DEM_Z);
end
isVisiableOut=isVisiable;
time=toc;
function [distance, isVisiable]=TOS(distance,isVisiable,S,T,stature,section,DEM_X,DEM_Y,DEM_Z)
tempxx=section(:,1);tempyy=section(:,2);tempzz=section(:,3);
X=DEM_X;Y=DEM_Y;Z=DEM_Z;
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
deltaX=DEM_X(end)/(Xn-1);deltaY=DEM_Y(end)/(Yn-1);
SpointX=S(1);SpointY=S(2);TpointX=T(1);TpointY=T(2);
%������ɨ����������еĵ㣬�����ȷ����T��ST�߶������е���������϶�Ӧ�ĵ㡣
for i=1:size(tempzz,1)
    %�жϵ�T��X(1,TpointX),Y(TpointY,1),Z(TpointY,TpointX)��Ŀ�����    
    flag=0;
    %|-----|-----|----->X��
    %|-----|-----|
    %|-----|-----|
    %|
    %Y��
    if SpointX==TpointX%%�Դ�ֱ���д���,��tempyy�����ֵ��ΪX��
        %T���ӵ㣨tempxx(viewpoint,1),tempyy(viewpoint,1),tempzz(viewpoint,1))ֱ�ߵ�б��
        k1=(tempzz(i,1)-Z(SpointY,SpointX)-stature)/(tempyy(i,1)-Y(SpointY,1));
        %b=tempzz(viewpoint,1)+stature-k*tempxx(viewpoint,1);
        b1=tempzz(i,1)-k1*tempyy(i,1);
        if SpointY<TpointY
            for j=1:i%��ʼ������ӵ�%%%%����ΪʲôҪ��ȥĿ��㱾��������       
                temp=k1*tempyy(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                    flag=1;break;
                end
            end
        else%ĩ�����ӵ�
            for j=size(tempzz,1)-1:-1:i%Ҫȥ���ӵ㱾��
                temp=k1*tempyy(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                    flag=1;break;
                end
            end
        end
    %elseif horizontal_flag==1%%��ˮƽ���д���        
    else%%����ʹ��tempxx��ΪX��
        %T���ӵ㣨tempxx(viewpoint,1),tempyy(viewpoint,1),tempzz(viewpoint,1))ֱ�ߵ�б��
        k1=(tempzz(i,1)-Z(SpointY,SpointX)-stature)/(tempxx(i,1)-X(1,SpointX));
        %b=tempzz(viewpoint,1)+stature-k*tempxx(viewpoint,1);
        b1=tempzz(i,1)-k1*tempxx(i,1);
            
        %���ӵ㵽Ŀ������ɨ��
        if SpointX<TpointX
            for j=1:i%��ʼ������ӵ�%%%%����ΪʲôҪ��ȥĿ��㱾�����������ﻹ�����TpointX<tempxx     
                temp=k1*tempxx(j,1)+b1;%j����ֱ���϶�Ӧ�ĸ߳�ֵ
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                    flag=1;break;
                end
            end
        else%ĩ�����ӵ�
            for j=size(tempzz,1)-1:-1:i%Ҫȥ���ӵ㱾��%%%�����Ǽ���1����i�أ���������
                temp=k1*tempxx(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                    flag=1;break;
                end
            end
        end
    end
    %��ֱ���ϵ�i�����
    if(flag==0)
        %�������Ϊ����
        xi=round(tempxx(i,1)/deltaX);yi=round(tempyy(i,1)/deltaY);%��x��yȡ��
        %hold on;plot3(xi*deltaX,yi*deltaY,Z(yi,xi),'*r','MarkerSize',5);        
%         if xi==tempxx(i,1)/deltaX && abs(yi-tempyy(i,1)/deltaY)<distance(yi,xi)%��y�ཻ
%             distance(yi,xi)=abs(yi-tempyy(i,1)/deltaY);isVisiable(yi,xi)=1;  
%             hold on;plot3(xi*deltaX,yi*deltaY,Z(yi,xi),'*r','MarkerSize',5); 
%         elseif yi==tempyy(i,1)/deltaY &&distance(yi,xi)>abs(xi-tempxx(i,1)/deltaX)%��x�ཻ
%             distance(yi,xi)=abs(xi-tempxx(i,1)/deltaX);isVisiable(yi,xi)=1;  
%             hold on;plot3(xi*deltaX,yi*deltaY,Z(yi,xi),'*r','MarkerSize',5); 
%         else%�Ȳ���x����Ҳ����y����
%             d=sqrt((abs(xi-tempxx(i,1)/deltaX))^2+(yi-tempyy(i,1)/deltaY)^2);
%             if(distance(yi,xi)>d)
%                 
%         end
        d=sqrt((abs(xi-tempxx(i,1)/deltaX))^2+(yi-tempyy(i,1)/deltaY)^2);
        if(distance(yi,xi)>d)
            distance(yi,xi)=d;isVisiable(yi,xi)=1;  
            plot3(xi*deltaX,yi*deltaY,Z(yi,xi),'*r','MarkerSize',5); 
        end
        %hold on;plot3(xi*deltaX,yi*deltaY,Z(yi,xi),'*r','MarkerSize',5); 
        %hold on;plot3(tempxx(i,1),tempyy(i,1),tempzz(i,1),'*r');%����T���ɺ�ɫ
        %isVisiable(TpointY,TpointX)=1;
    else
        %hold on;plot3(tempxx(i,1),tempyy(i,1),tempzz(i,1),'or');%����T���ɺ�ɫ
    end
end
distanceOut=distance;isVisiableOut=isVisiable;