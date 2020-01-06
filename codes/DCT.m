%% DCT COMPRESSION
A = im2single(imread('D:\LA\Final\pic\subject01.noglasses.gif'));
B = dct2(A);
M = cell(5,1);
  
  for k=5:25:105
      M{(k-5)/25 +1} = B ;
     M{(k-5)/25 +1}(k+1:243,k+1:320) = 0;
     C = idct2(M{(k-5)/25 +1});
     error=sum(sum((A-C).^2));
  figure,imshow(C);title(sprintf('DCT compression with rank %d + error : %d ',k , error))
 end