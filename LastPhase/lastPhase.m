myFolder = 'D:\LA\Final\traningSet';
filePattern = fullfile(myFolder, '*.gif');
Files = dir(filePattern);
NF = length(Files);
images = cell(NF,1); 
ResizedImages = cell(NF , 1);
imagesminusav = cell(NF,1);
imagesMinusAverage = cell(NF,1);

for k = 1:length(Files)
  baseFileName = Files(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  images{k} = imread(fullFileName);
end
for k = 1:150
   ResizedImages{k} = reshape(images{k} , 243*320 , 1) ;
   
end
S = zeros(243*320,150);
for k=1:150
    S(:,k) = ResizedImages{k}(:);
end
av=zeros(243*320,1);
 for k=1:150
        ResizedImages{k} = im2single(ResizedImages{k});
    av   =av  + (1/150)*ResizedImages{k};
    
 end
 figure , imshow(reshape(av , 243,320));title('meanImage')
 for k=1:150
    imagesMinusAverage{k}  = ResizedImages{k} -av
 end
A = zeros(243*320,150);
for k=1:150
    A(:,k) = imagesMinusAverage{k}(:);
end

[U,Sigma,V]=svd(A,'econ');
X = zeros(150 , 150);
% X => feature matrix
X = U' * A ;
eigenImages = cell(10,1);
for n = 1:10
   eigenImages{n} = reshape((U(:,n)) , 243,320); 
end
 for g=1:10
    colormap gray;
     figure(g+1),imshow(eigenImages{g} );title('eigenImages')
     
 end
 
 myFolder2 = 'D:\LA\Final\testSet';
filePattern2 = fullfile(myFolder2, '*.gif');
Files2 = dir(filePattern2);
NF2 = length(Files2);
testImages = cell(NF2,1); 
TestResizedImages = cell(NF2 , 1);
TestResizedImagesMinusAverage = cell(NF2 , 1);
newX = cell(NF , 1);
for j = 1:length(Files2)
  baseFileName2 = Files2(j).name;
  fullFileName2 = fullfile(myFolder2, baseFileName2);
  fprintf(1, 'Now reading %s\n', fullFileName2);
  testImages{j} = imread(fullFileName2);
end
for t = 1:15
   TestResizedImages{t} = reshape(testImages{t} , 243*320 , 1) ;
   
end



% treshold = 1;
epsilon = cell(NF2,1);
normOfEpsilon = cell(NF2,1);
for q = 1:15
   TestResizedImagesMinusAverage{q} =double(TestResizedImages{q})  - av  ;
   newX{q} = U' *TestResizedImagesMinusAverage{q};
   for w=1:150
     epsilon{q}(w,1) =  ((newX{q} - X(:,w))' * (newX{q} - X(:,w)))^0.5;
     
   end
   normOfEpsilon{q} = norm(epsilon{q});
%      if normOfEpsilon{q} > 1
%          disp('Unknown face');
%      end
  
   
end

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 