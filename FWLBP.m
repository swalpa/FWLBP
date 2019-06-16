%   FWLBP returns the fractal weighted local binary pattern histogram of an image depending on what mapping is used.
%   The original getmapping code of LBP is used and updated to the FWLBP by Swalpa Kumar Roy, CVPR Unit, ISI Kolkata.
%   This code can be used only for the academic and research purposes and can not be used for any commercial purposes.
%   Cite the paper 'S.K. Roy, N. Bhattarcharya, B. Chanda, B.B. Chaudhuri, and D.K. Ghosh, 
%   "FWLBP: A Scale Invariant Descriptor for Texture Classification", 
%   arXiv preprint arXiv:1801.03228, 2018',
%   In case you are using this code.


function h11 = FWLBP(path_image)
% path_image='datasets\AT&T\s1\1.pgm';
img = imread(path_image);
if length(size(img))==3
    img=rgb2gray(img);
end

im = single(img);
FRAC = fractalTrans(im);

% Simple Local Binary Pattern on the original Image
Gray = double(img); 
Gray = (Gray-mean(Gray(:)))/std(Gray(:))*20+128; % image normalization, to remove global intensity 

patternMappingriu2 = getmapping(8,'x');

h11=[lbpfrac(Gray,1,8,patternMappingriu2,'nh',FRAC) lbpfrac(Gray,2,8,patternMappingriu2,'nh',FRAC) lbpfrac(Gray,3,8,patternMappingriu2,'nh',FRAC)];
h11=h11/sum(h11);
end
