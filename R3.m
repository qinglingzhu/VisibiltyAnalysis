%���ܣ�R3--�޸��������������
%���룺isVisible:�����Ծ���S�ӵ㣬stature�˸ߣ��߳�����
%����������Ծ���ʱ��
%���ߣ�QingLing.Zhu email:qlzhu1991@gmail.com
%ʱ�䣺2014-3-18
%ɨ����������еĵ㣬�����ȷ����T��ST�߶������е���������϶�Ӧ�ĵ㡣
function [isVisiableOut,time]=R3(isVisiable,S,stature,DEM_X,DEM_Y,DEM_Z)
tic;
X=DEM_X;Y=DEM_Y;Z=DEM_Z;
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
SpointX=S(1);SpointY=S(2);
hold on;plot3(DEM_X(1,SpointX),DEM_Y(SpointY,1),DEM_Z(SpointY,SpointX)+stature,'ow');
for ii=1:Xn
    for jj=1:Yn
        TpointX=ii;TpointY=jj;      
        section=sectionOfTwoPoint(S,[TpointX,TpointY],DEM_X,DEM_Y,DEM_Z);
        tempxx=section(:,1);tempyy=section(:,2);tempzz=section(:,3);
        %for i=1:size(tempzz,1)
            %�жϵ�T��X(1,TpointX),Y(TpointY,1),Z(TpointY,TpointX)��Ŀ�����    
            flag=0;
            %|-----|-----|----->X��
            %|-----|-----|
            %|-----|-----|
            %|
            %Y��
            if SpointX==TpointX %%�Դ�ֱ���д���,��tempyy�����ֵ��ΪX��
               % �ӵ�S(SpointX,SpointY),Ŀ���T(TpointX,TpointY)֮���ֱ�ߣ���k1,b1��ʾ
                k1=(Z(TpointY,TpointX)-Z(SpointY,SpointX)-stature)/(Y(TpointY,1)-Y(SpointY,1));
                b1=Z(TpointY,TpointX)-k1*Y(TpointY,1);
                if SpointY<TpointY
                    for j=1:size(tempzz,1)%��ʼ������ӵ�%%%%����ΪʲôҪ��ȥĿ��㱾��������       
                        temp=k1*tempyy(j,1)+b1;
                        %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                        if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                            flag=1;break;
                        end
                    end
                else%ĩ�����ӵ�
                    for j=size(tempzz,1)-1:-1:1%Ҫȥ���ӵ㱾��
                        temp=k1*tempyy(j,1)+b1;
                        %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                        if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                            flag=1;break;
                        end
                    end
                end
            %elseif horizontal_flag==1%%��ˮƽ���д���        
            else%%����ʹ��tempxx��ΪX��
                % �ӵ�S(SpointX,SpointY),Ŀ���T(TpointX,TpointY)֮���ֱ�ߣ���k1,b1��ʾ
                k1=(Z(TpointY,TpointX)-Z(SpointY,SpointX)-stature)/(X(1,TpointX)-X(1,SpointX));
                b1=Z(TpointY,TpointX)-k1*X(1,TpointX);

                %���ӵ㵽Ŀ������ɨ��
                if SpointX<TpointX
                    for j=1:size(tempzz,1)-1%��ʼ������ӵ�%%%%����ΪʲôҪ��ȥĿ��㱾�����������ﻹ�����TpointX<tempxx     
                        temp=k1*tempxx(j,1)+b1;%j����ֱ���϶�Ӧ�ĸ߳�ֵ
                        %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                        if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                            flag=1;break;
                        end
                    end
                else%ĩ�����ӵ�
                    for j=size(tempzz,1)-1:-1:1%Ҫȥ���ӵ㱾��
                        temp=k1*tempxx(j,1)+b1;
                        %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                        if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                            flag=1;break;
                        end
                    end
                end
            end
            if(flag==0)
                plot3(X(1,TpointX),Y(TpointY,1),Z(TpointY,TpointX),'*r','MarkerSize',5);%����T���ɺ�ɫ
                isVisiable(TpointY,TpointX)=1;
            else
                isVisiable(TpointY,TpointX)=0;
            end

        %end
    end
end
isVisiableOut=isVisiable;
time=toc;