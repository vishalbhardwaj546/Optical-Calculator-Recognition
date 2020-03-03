% OCR (Optical Character Recognition).


warning off 
clc, close all, clear all
imagen=imread('TEST_5.jpg');
imshow(imagen);
title('INPUT IMAGE')

% Convert to gray scale
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end

% Convert to BW
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);

% Remove all object containing fewer than 50 pixels
imagen = bwareaopen(imagen,50);

%Storage matrix word from image
word=[ ];
re=imagen;

fid = fopen('text.txt', 'wt');

load templates
global templates
% Compute the number of letters in template file
num_letters=size(templates,2);
while 1
    %Fcn 'lines' separate lines in text
    [fl re]=lines(re);
    imgn=fl;
    %Uncomment line below to see lines one by one
    %imshow(fl);pause(0.5)    
        
    % Label and count connected components
    [L Ne] = bwlabel(imgn);    
    for n=1:Ne
        [r,c] = find(L==n);
        % Extract letter
        n1=imgn(min(r):max(r),min(c):max(c));  
        % Resize letter (same size of template)
        img_r=imresize(n1,[42 24]);
        %Uncomment line below to see letters one by one
        %imshow(img_r);pause(0.5)
       
        % Call fcn to convert image to text
        letter=read_letter(img_r,num_letters);
        % Letter concatenation
        word=[word letter];
    end
   
    fprintf(fid,'%s\n',word);
    
    word=[ ];
    
    if isempty(re)
        break
    end    
end
fclose(fid);

winopen('text.txt')

clear all