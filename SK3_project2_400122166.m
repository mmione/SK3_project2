% Image Deblurring Program - Matt Mione 400122166 %

flag = 0;
prompt = "What type of blurring? 1: horizontal blurring 2: out of focus blurring. ";

while flag ~= 1 && flag ~=2
    
    flag = input(prompt);
    
end


row = 100;
image_original = im2double(imresize(rgb2gray(imread('test_spiralled.jpg')), [row row]));
figure(1);

imshow(image_original);
title("original image");

% We now have the ORIGINAL image. Going to create blurred versions. 

image_as_column = reshape(image_original', 1, row^2)'; 

blurring_matrix = zeros(row^2);

if flag == 1
    
    % HORIZONTAL BLUR MATRIX % 
    disp("HORIZONTAL BLURRING ");
    
    for inc = [0 1 2]

        for index = [1:row^2-inc] % Prevents us from writing outside the matrix.

           blurring_matrix(index,index+inc) = 1;

        end

    end

else
    
    % OUT OF FOCUS BLUR MATRIX %
    disp("OUT OF FOCUS BLURRING ");
    
    for inc = [0 1 2]

        num = 1;

        if inc == 0

            num=4;

        end

        for index = [1:row^2-inc] % Prevents us from writing outside the matrix.

           blurring_matrix(index,index+inc) = 1;

        end

    end
    
end

blurred_image_as_column = (1/3)*blurring_matrix*image_as_column; % The blurring process.

blurred_image = reshape(blurred_image_as_column', row, row)'; % Reverts the columnized image to the original matrix format. The inverse of the original action.

figure(2);

imshow(blurred_image);
title("blurred image");


% We have created the blurred image. 

% NOW: we will pass the blurred image and the blurring matrix into the
% gaussian elimination algorithm to solve for the ((hopefully)) ORIGINAL
% matrix. 

disp("Now solving the system using LU decomp. ");

deblurred_as_column = LU_decomp(blurring_matrix, blurred_image_as_column, row^2);

deblurred_image = reshape(deblurred_as_column', row, row)'; % Reverts the columnized image to the original matrix format. The inverse of the original action.

figure(3);
imshow(deblurred_image);
title("DE-blurred image");

