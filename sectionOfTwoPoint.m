%���ܣ�����֮��Ķ���
%���룺S�ӵ㣬TĿ��㣬�߳�����
%�����������Ϣ
%���ߣ�QingLing.Zhu email:qlzhu1991@gmail.com
%ʱ�䣺2014-3-18

%% �ӵ�S(SpointX,SpointY),Ŀ���T(TpointX,TpointY)֮��Ķ���
function section=sectionOfTwoPoint(S,T,DEM_X,DEM_Y,DEM_Z)
SpointX=S(1);SpointY=S(2);TpointX=T(1);TpointY=T(2);
Xn=size(DEM_X,2);Yn=size(DEM_Y,1);
deltaX=DEM_X(end)/(Xn-1);deltaY=DEM_Y(end)/(Yn-1);Z=DEM_Z;
%����Ҫע��ˮƽ�ʹ�ֱ�����
vertical_flag=0;horizontal_flag=0;%ˮƽ�ʹ�ֱ��־
if SpointX==TpointX 
    vertical_flag=1;
elseif SpointY==TpointY
    horizontal_flag=1;
else
   k=(TpointY-SpointY)/(TpointX-SpointX);b=TpointY-k*TpointX;%��ˮƽ��ֱ�����
end
tempxx=0;tempyy=0;tempzz=0;index=1;%����ö����ϵĵ�
%����x���ϵ�����
for i=min([SpointX,TpointX]):max([SpointX,TpointX])
    tempx=i;
    if vertical_flag==1%����ֱ��x��Ļ�����x����ȡ����˳�
        break;
    elseif horizontal_flag==1
        tempy=SpointY;
    else
       tempy=k*tempx+b;%��tempx��ֱ���ϵ�y
    end
    tempy1=floor(tempy+0.00000001);tempy2=ceil(tempy-0.000001);%ȡ��tempy��������
    %���ַ���Ҳ���ԣ����ǲ�֪��tempy��͹�Ļ��ǰ��ģ����Բ��Ǻܺ��󣬻��д��Ľ�
    %tempz=abs(tempy-tempy1)*abs(Z(tempy2,tempx)-Z(tempy1,tempx))+Z(tempy1,tempx);   
    %if(tempy==tempy1&&tempy==tempy2)%��������ǣ��պ���������ϵĵ㣬�����޶���һ����
    %����ģ���tempy=1�ǣ�����������
    if(tempy1==tempy2)
        tempz=Z(tempy1,tempx);
    else
        %��������ã���ý��ı�����Щ��
        tempz=Z(tempy1,tempx)*abs(tempy-tempy2)+Z(tempy2,tempx)*abs(tempy-tempy1);
    end
    tempxx(index,1)=(tempx-1)*deltaX;tempyy(index,1)=(tempy-1)*deltaY;tempzz(index,1)=tempz;
    index=index+1;
    %stem3(tempx,tempy,tempz,'fill');hold on;%����ע��һ�£�ʹ���������Ϊ����ϵͳ�����������ص�
    %hold on;stem3(tempx*deltaX,tempy*deltaY,tempz,'fill','MarkerSize',3);%ʹ����������ϵͳ�����õ��
end
%����y���ϵ�����
for i=min([SpointY,TpointY]):max([SpointY,TpointY])
	tempy=i;
    if vertical_flag==1%����ֱ��x��Ļ�����x����ȡ����˳�
        tempx=SpointX;
    elseif horizontal_flag==1
        break;%ƽ����x������
    else
        tempx=(tempy-b)/k;
    end
    tempx1=floor(tempx+0.0000001);tempx2=ceil(tempx-0.0000001);
    %tempz=abs(tempx-tempx1)*abs(Z(tempy,tempx2)-Z(tempy,tempx1))+Z(tempy,tempx1); 
    %��tempx=tempx1=tempx2ʱ
    %if(tempx==tempx1&&tempx==tempx2)
    if tempx1==tempx2
        tempz=Z(tempy,tempx1);
        if SpointX~=TpointX
            continue;
        end
    else
        tempz=Z(tempy,tempx1)*abs(tempx-tempx2)+Z(tempy,tempx2)*abs(tempx-tempx1);
    end
    %stem3(tempx*deltaX,tempy*deltaY,tempz,'fill','MarkerSize',3);hold on;
    tempxx(index,1)=(tempx-1)*deltaX;tempyy(index,1)=(tempy-1)*deltaY;tempzz(index,1)=tempz;
    index=index+1;
end
%��tempxx,tempyy,tempzz��������
[tempxx,ss]=sort(tempxx);
tempyy=tempyy(ss,:);
tempzz=tempzz(ss,:);
section=[tempxx,tempyy,tempzz];