image = imread('../bd/nude.jpg');
hsv_image = rgb2hsv(image) ;

[m s ] = mean(hsv_image(:,:,1))

%imshow(image);