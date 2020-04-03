clear all
close all
clc

% number of rows of your reference image. Use a small number if your computer is slow
row = 100;
img_ori = im2double(imresize(rgb2gray(imread('Lenna.png')), [row NaN]));
figure
imshow(img_ori)
title('Reference Image')


% the linear motion of a camera by len pixels horizontally
len = round(0.1 * size(img_ori,1));

for i = 1:size(img_ori,1)
    for j = 1:size(img_ori,2)-len+1
        img_motion(i, j) = mean(img_ori(i, j:j+len-1));
    end
end
figure
imshow(img_motion)
title('Motion Blur Image')


motion_matrix = zeros(numel(img_motion), numel(img_ori));
order = reshape((1:numel(img_motion))', size(img_motion));
for i = 1:size(img_ori,1)
    fprintf('building motion matrix...%.1f%%\n', i/size(img_ori,1)*100);
    for j = 1:size(img_ori,2)-len+1
        img_temp = zeros(size(img_ori));
        img_temp(i, j:j+len-1) = 1.0/len;
        motion_matrix(order(i, j), :) = reshape(img_temp, 1, []);
    end
end


img_matrix_blur = reshape(motion_matrix * reshape(img_ori, [], 1), size(img_motion));
if max(max(abs(img_matrix_blur - img_motion))) > 1e-10
    error('wrong motion matrix');
end


boundary_matrix = zeros((len-1)*size(img_ori,1), numel(img_ori));
boundary_counter = 1;
for i = 1:size(img_ori,1)
    fprintf('building boundary matrix...%.1f%%\n', i/size(img_ori,1)*100);
    for j = 1:len-1
        img_temp = zeros(size(img_ori));
        img_temp(i, j) = 1.0;
        boundary_matrix(boundary_counter, :) = reshape(img_temp, 1, []);
        boundary_vector(boundary_counter, 1) = img_ori(i, j);
        boundary_counter = boundary_counter + 1;
    end
end

% linear equations: Ax = b
A = [motion_matrix; boundary_matrix];
b = [reshape(img_motion, [], 1); boundary_vector];
img_deblur = reshape(Solving_Linear_Equations_with_LU_decomposition(A, b), size(img_ori));


if max(max(abs(img_deblur - img_ori))) > 1e-10
    error('wrong deblur image');
end
figure
imshow(img_deblur)
title('Deblur Image')
disp('Done!')



function x = Solving_Linear_Equations_with_LU_decomposition(A, b)
% write your code here
% the output x should be inv(A)*b (or A\b), but you CANNOT use it as your final answer.
% you CANNOT use any high-level function in your code, for example inv(), matrix division, factorLU(), solve(), etc.

% for demonstration only:
x = A\b;

end

