function [fl re]=lines(im_text)
% Divide text in lines
% im_text->input image; fl->first line; re->remain line
% Example:
% im_text=imread('TEST_3.jpg');
% [fl re]=lines(im_text);
% subplot(3,1,1);imshow(im_text);title('INPUT IMAGE')
% subplot(3,1,2);imshow(fl);title('FIRST LINE')
% subplot(3,1,3);imshow(re);title('REMAIN LINES')
im_text=clip(im_text);
num_fil=size(im_text,1);
for s=1:num_fil
    if sum(im_text(s,:))==0
        nm=im_text(1:s-1, :); % First line matrix
        rm=im_text(s:end, :);% Remain line matrix
        fl = clip(nm);
        re=clip(rm);
        %*-*-*Uncomment lines below to see the result*-*-*-*-
                 %subplot(2,1,1);imshow(fl);
                 %subplot(2,1,2);imshow(re);
        break
    else
        fl=im_text;%Only one line.
        re=[ ];
    end
end

function img_out=clip(img_in)
[f c]=find(img_in);
img_out=img_in(min(f):max(f),min(c):max(c));%Crops image