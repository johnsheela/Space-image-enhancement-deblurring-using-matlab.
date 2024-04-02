originalImage = imread('C:\Users\SHARON ROSE J\Pictures\Screenshots\spaceimg1.png');
% Convert the image to grayscale if it's in color
grayImage = rgb2gray(originalImage);

% Assuming 'noisyBlurredImage' is the degraded image
% Define the blur kernel (e.g., Gaussian blur kernel)
blurKernel = fspecial('gaussian', [5 5], 2);

% Simulate noisy and blurred image
blurredImage = imfilter(grayImage, blurKernel, 'conv', 'circular');
noisyBlurredImage = imnoise(blurredImage, 'gaussian', 0, 0.01); % Gaussian noise

% Perform deconvolution with Wiener deconvolution
estimatedBlurredImage = deconvwnr(noisyBlurredImage, blurKernel, 0.14);

% Apply additional denoising techniques (median filtering) for further denoising
filterSize = 5; % Adjust filter size as needed
deblurredImage_medfilt = medfilt2(estimatedBlurredImage, [filterSize, filterSize]);

% Apply unsharp masking to enhance sharpness
sharpnessFactor = 4.4; % Adjust the sharpness factor as needed
unsharpImage = imsharpen(deblurredImage_medfilt, 'Amount', sharpnessFactor);

% Display the original and sharpened images
subplot(1, 5, 1);
imshow(grayImage);
title('Original Image');
subplot(1, 5, 2);
imshow(noisyBlurredImage);
title('Blurred Image');
subplot(1, 5, 3); imshow(estimatedBlurredImage); title('Deblurred Image (Wiener)');
subplot(1, 5, 4); imshow(deblurredImage_medfilt); title('Deblurred Image (Median Filter)');
subplot(1, 5, 5);
imshow(unsharpImage);
title('Sharpened Image');

%Noise Ratio
psnrValue = psnr(estimatedBlurredImage, grayImage);
ssimValue = ssim(estimatedBlurredImage, grayImage);
fprintf('PSNR_After Weiner: %.2f\n', psnrValue);
fprintf('SSIM_After Weiner: %.4f\n', ssimValue);
psnrValue2 = psnr(deblurredImage_medfilt, grayImage);
ssimValue2 = ssim(deblurredImage_medfilt, grayImage);
fprintf('PSNR_After Filter: %.2f\n', psnrValue2);
fprintf('SSIM_After Filter: %.4f\n', ssimValue2);
psnrValue3 = psnr(unsharpImage, grayImage);
ssimValue3 = ssim(unsharpImage, grayImage);
fprintf('PSNR_After Sharpening: %.2f\n', psnrValue2);
fprintf('SSIM_After Sharpening: %.4f\n', ssimValue2);