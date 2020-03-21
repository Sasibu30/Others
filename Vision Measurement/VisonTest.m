clear
clc

%% 파일 가져오기
%w=imread('irisEx.jpg');
%w=imread('irisEx2.jpg');
w=imread('plate.jpg');
%w=imread('ExC.jpg');
%w=imread('ExC2.jpg');
[a,b,c]=size(w);

W = zeros(a,b);

%% 데이터 처리
%imresize(w,0.5) -> 영상크기 조절하여 화소 밀도 조절

% RGB 평균치 처리
for ii=1:a
    for jj=1:b
        for kk=1:c
            W(ii,jj) = W(ii,jj) + double(w(ii,jj,kk));
        end        
    end
end
Wo=W/255/3;

W=W/255/3;


% W<특정값 -> 0 으로 양자화하여 대비 강화
for ii=1:a
    for jj=1:b
        if W(ii,jj)<0.5
            W(ii,jj) = 0;
        else
            W(ii,jj) = 1;
        end
    end
end
figure(1)
imshow(W)

% W<특정값 -> 1 흰자 데이터만 추출
inten = 0.7;
for ii=1:a
    for jj=1:b
        if Wo(ii,jj)>0.5 && (double(w(ii,jj,2))/double(w(ii,jj,1))) > inten && (double(w(ii,jj,2))/double(w(ii,jj,1)))<= (2-inten) && (double(w(ii,jj,3))/double(w(ii,jj,1))) > inten && (double(w(ii,jj,3))/double(w(ii,jj,1))) <= (2-inten)
            WW(ii,jj) = 1;
        else
            WW(ii,jj) = 0;
        end
    end
end

%{
% prewit 필터
px = zeros(3,3); px(:,1) = -1; px(:,3)=1;
py = zeros(3,3); py(1,:) = -1; py(3,:)=1;

Wx=filter2(px,W);
Wy=filter2(py,W);
%}

% Laplician fileter --> zero cross
%{
La = fspecial('laplacian',0);
W = filter2(La,W);
imshow(W)
%}

%Filter
BW1 = edge(W,'Canny');
W = edge(W,'Prewitt');


aa=1;
r = zeros(a,b);
index = 0;
sum=0;


% Filter 쓰지 않을 경우
%{
for ii =1:a
    aa=1;
    for jj=1:b
        
        if W(ii,jj) == 0 && index == 0
            index = 1; % -> 현재 상태 알려주는 인덱스
        elseif W(ii,jj) == 0 && index == 1
            sum = sum+1;
        elseif W(ii,jj) == 1 && index == 1
            r(ii,aa) = sum;
            index = 0;
            sum = 0;
            aa=aa+1;
        end
    end
end

for ii=1:a
    for jj=1:b
        r_max(ii,1) = max(max(r(ii,:)));
    end
end
%}


%Prewitt Filter일 경우 데이터 처리
%
for ii =1:a
    aa=1;
    sum = 0;
    index = 0;
    for jj=1:b
        if W(ii,jj) == 1 && index == 0 
            index = 1; % -> 엣지 검출 인덱스
        elseif W(ii,jj) == 0 && index == 1 
            index = 2;
        elseif W(ii,jj) == 0 && index == 2 
            sum = sum+1;
        elseif W(ii,jj) == 1 && index == 2
            r(ii,aa) = sum;
            index = 0;
            sum = 0;
        end
        if W(ii,jj) == 0 && index == 2
            r(ii,aa) = 0;  
        end
         aa=aa+1;
    end
end

for ii=1:a
    for jj=1:b
        r_max(ii,1) = max(max(r(ii,:)));
    end
end
%}

%{
% 테두리 윈도우에서 선 겹치는 부분 제외 (1/10 )
ttt=1/3;

for ii=1:round(a*ttt)
    r_max(ii,:) = 0;
end

for ii= (a - round(a*ttt)):a
    r_max(ii,:) = 0;
end

fprintf('예상 직경 = %f\n',max(max(r_max)));
%}
%%
WC = zeros(a,b);

for ii=1:a
    for jj=1:b
        if WW(ii,jj) == W(ii,jj)
            WC(ii,jj) = 1;
        end
    end
end

figure(3);
imshow(WC)
        
        
        