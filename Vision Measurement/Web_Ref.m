% color edge extraction
clear
clc

c_img = imread('irisEx.jpg');

[R,C,X] = size(c_img);

% RGB color space

r_ch = c_img(:,:,1);
g_ch = c_img(:,:,2);
b_ch = c_img(:,:,3);

r_ch_edge = double(edge(r_ch,'prewitt'));
g_ch_edge = double(edge(g_ch,'prewitt'));
b_ch_edge = double(edge(b_ch,'prewitt'));

new_color_edge_map = zeros(R,C,X);

new_color_edge_map(:,:,1) = mat2gray(r_ch_edge);
new_color_edge_map(:,:,2) = mat2gray(g_ch_edge);
new_color_edge_map(:,:,3) = mat2gray(b_ch_edge);

new_gray_edge_map=zeros(R,C);

new_gray_edge_map = sqrt(r_ch_edge.^2.0 + g_ch_edge.^2.0 +b_ch_edge.^2.0)/sqrt(3.0);

figure(1);
subplot(1,3,1); imshow(c_img); title('원 영상');
subplot(1,3,2); imshow(new_color_edge_map);title('칼라요소 합친것');
subplot(1,3,3); imshow(mat2gray(new_gray_edge_map));title('그레이 에지맵');


% HSV color space

[H,S,V] = rgb2hsv(c_img);
V_edge = edge(V,'prewitt');
figure(2);
imshow(V_edge); title('밝기 채널에 의해 수행된 결과');

%---------------------------matlab code 부분 끝-----------------------------