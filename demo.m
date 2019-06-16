 clc
 clear all
 close all

 dn='/home/swalpa/Downloads/FWLBP/Brodatz32/Data/';
  
 db=dir(strcat(dn,'*.xv'));
 k=1;
 tic
 feature = [];
 
 
 % Radius and Neighborhood
 R1 = 1;
 R2 = 2;
 R3 = 3;
 P = 8;
 
 % LBP needed a mapping function
 patternMappingriu2 = getmapping(P,'x');
 
 
 
 for(i=1:1:length(db))

     fname=db(i).name;
     fname=strcat(dn,fname);
     im = load_xv_img(fname);
     %im=imread(fname);
     
    % Color Conversion
     if length(size(im)) == 3
        im = rgb2gray(im);
     end
     
     im = single(im);
     FRAC = fractalTrans(im);
     
     % Simple Local Binary Pattern on the original Image
     Gray = double(im); 
     Gray = (Gray-mean(Gray(:)))/std(Gray(:))*20+128; % image normalization, to remove global intensity 
     
     
     LBP_F1 = lbp(Gray,R1,P,patternMappingriu2,'h',FRAC);
     
     LBP_F2 = lbp(Gray,R2,P,patternMappingriu2,'h',FRAC);
     
     LBP_F3 = lbp(Gray,R3,P,patternMappingriu2,'h',FRAC);
    
     % The R = 1 and R = 2 feature is also gives outstanding results
          
     feature = [feature; LBP_F1/sum(LBP_F1) LBP_F2/sum(LBP_F2) LBP_F3/sum(LBP_F3)];
     
     k=k+1   
 end; 
 k-1
 
save('FWLBP_BR','feature');
%xlswrite('FKTH.xlsx',feature);
toc
