%���ܣ�����֮��Ŀ����Է���LOS��Line Of Sight��
%���룺S�ӵ㣬TĿ��㣬�߳�����
%�����null
%���ߣ�QingLing.Zhu email:qlzhu1991@gmail.com
%ʱ�䣺2014-3-18

%������ɨ����������еĵ㣬�����ȷ����T��OT�߶������е���������϶�Ӧ�ĵ㡣
function LOS(S,T,stature,section,DEM_X,DEM_Y,DEM_Z)
tempxx=section(:,1);tempyy=section(:,2);tempzz=section(:,3);
X=DEM_X;Y=DEM_Y;Z=DEM_Z;
SpointX=S(1);SpointY=S(2);TpointX=T(1);TpointY=T(2);
for i=1:size(tempzz,1)
    %���ڵ�T��tempxx(i,1),tempyy(i,1),tempzz(i,1)����Ŀ�����
    flag=0;
    if size(unique(tempxx),1)==1%%�Դ�ֱ���д���,��Y����ΪX��
        %T���ӵ㣨tempxx(viewpoint,1),tempyy(viewpoint,1),tempzz(viewpoint,1))ֱ�ߵ�б��
        k1=(tempzz(i,1)-Z(SpointY,SpointX)-stature)/(tempyy(i,1)-Y(SpointY,1));
        %b=tempzz(viewpoint,1)+stature-k*tempxx(viewpoint,1);
        b1=tempzz(i,1)-k1*tempyy(i,1);
        if SpointY<TpointY
            for j=1:i%��ʼ������ӵ�
                temp=k1*tempyy(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                    flag=1;break;
                end
            end
        else
            for j=size(tempzz,1)-1:-1:i%Ҫȥ���õ㱾��
                temp=k1*tempyy(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                    flag=1;break;
                end
            end
        end
    %elseif horizontal_flag==1%%��ˮƽ���д���        
    else%%����ʹ��X��
        %T���ӵ㣨tempxx(viewpoint,1),tempyy(viewpoint,1),tempzz(viewpoint,1))ֱ�ߵ�б��
        k1=(tempzz(i,1)-Z(SpointY,SpointX)-stature)/(tempxx(i,1)-X(1,SpointX));
        %b=tempzz(viewpoint,1)+stature-k*tempxx(viewpoint,1);
        b1=tempzz(i,1)-k1*tempxx(i,1);
        if SpointX<TpointX
            for j=1:i%��ʼ������ӵ�
                temp=k1*tempxx(j,1)+b1;
                hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                    flag=1;break;
                end
            end
        else
            for j=size(tempzz,1)-1:-1:i%Ҫȥ���õ㱾��
                temp=k1*tempxx(j,1)+b1;
                %hold on;plot3(tempxx(j,1),tempyy(j,1),temp,'or');
                if(tempzz(j,1)>temp+0.0001)%��ֹ��һ������ɡ��е�㲻��
                    flag=1;break;
                end
            end
        end
    end
    if(flag==0)
        hold on;
        plot3(tempxx(i,1),tempyy(i,1),tempzz(i,1),'*r');%����T���ɺ�ɫ
    end
end