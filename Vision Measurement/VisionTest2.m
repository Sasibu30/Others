clear
clc

%% ���� ��������
%w=imread('iphone7.png');
w=imread('gettodaze.jpg');

[a,b,c]=size(w);

W = zeros(a,b);

%% ������ ó��
%imresize(w,0.5) -> ����ũ�� �����Ͽ� ȭ�� �е� ����

% RGB ���ġ ó��
for ii=1:a
    for jj=1:b
        for kk=1:c
            W(ii,jj) = W(ii,jj) + double(w(ii,jj,kk));
        end        
    end
end
Wo=W/255/3;

W=W/255/3;


% W<Ư���� -> 0 ���� ����ȭ�Ͽ� ��� ��ȭ
for ii=1:a
    for jj=1:b
        if W(ii,jj)>0.7
            W(ii,jj) = 1;
        else
            W(ii,jj) = 0;
        end
    end
end

%Filter
BW1 = edge(W,'Canny');
W = edge(W,'Prewitt');

figure(1)
imshow(W)

%Prewitt Filter�� ��� ������ ó��
%�ʺ� ���ϱ�
LD = 1/4;

for jj=1:b
    if W(round(a*LD),jj) == 1
        W1_ind = jj;
        continue
    end
end

for jj=b:-1:1
    if W(round(a*LD),jj) == 1
        W2_ind = jj;
    end
end

%���� ���ϱ�
LD = 1/2;
round(b*LD)

for ii=1:a
    if W(ii,round(b*LD)) == 1
        L1_ind = ii;
        continue
    end
end

for ii=a:-1:1
    if W(ii,round(b*LD)) == 1
        L2_ind = ii;
    end
end

fprintf('���� �ʺ� = %f\n',abs(W2_ind - W1_ind));
fprintf('���� ���� = %f\n',abs(L2_ind - L1_ind));
        
        