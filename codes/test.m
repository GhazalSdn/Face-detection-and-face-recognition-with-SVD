%% First Step

myFolder = 'D:\LA\Final\traningSet';
filePattern = fullfile(myFolder, '*.gif');
Files = dir(filePattern);
NF = length(Files);
images = cell(NF,1); 
imagesminusav = cell(NF,1);
finalEigenFace = cell(6,1);
Qt = cell(NF,1); 
for k = 1:length(Files)
  baseFileName = Files(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  images{k} = imread(fullFileName);
end


%% Second Step(computing average)

av=zeros(243,320);
 for k=1:150
    images{k} = im2single(images{k});    
    av   =av  + (1/115)*images{k}; 
 end
 figure,imshow(av);title('average')

 %% Third Step
 
for k=1:150
    imagesminusav{k}  = images{k} -av;
end
Q = zeros(243*320,150);
for k=1:150
    Q(:,k) = imagesminusav{k}(:);
end

%% Fourth Step

for k=1:150
    Qt{k}  = (imagesminusav{k}).';
end

%% Fifth Step

C = Q'*Q;

%% 6th and 7th Step(finding eigen values and eigen vectors)
    I = eye(length(C));
    [eigenVectors,eigenValues]= eig(C);
% it didn't work 
%     syms x
%     eigValue = double(solve((det(C-I*x)== 0),x));
%     eigVector = zeros(size(C));
%     for i = 1:length(C)
%     syms y
%     eq2 = (C-eigValue(i)*I)*y == 0;
%     eigVector(:,i) = double(solve(eq2,y));
%% 8th Step (finding eigen faces)
    maxValues = eigenValues([145,146,147,148,149,150],[145,146,147,148,149,150]); 
    maxVectors = eigenVectors(:,[145,146,147,148,149,150]);
    eigenFaces = Q*maxVectors;
    for k=1:6
     finalEigenFace{k} = reshape(eigenFaces(:,k),243,320);
    end
   for k=1:6
     figure(k+1),imshow(finalEigenFace{k});title('eigenFace')
   end
%% 9th Step(linear algorithm for findinf if a pic is in this dataset)
% as an example
% b = im2single(reshape(imread('D:\LA\Final\pic\subject03.happy.gif'),77760,1));
% eigenF = im2single(eigenFaces);
% answer = linsolve(eigenF,b);
% faceDetected = eigenFaces*answer;
% figure(10),imshow(reshape(faceDetected,243,320));title('FaceDetected')
    
%% findng Weights for each photo in dataset
weight = zeros(150,6);
for m=1:150  
  for k=1:6   
    weight(m,k) =   sum(Q(:,m).* finalEigenFace{k}(:)) ;
  end
end
%% Testing a photo from dataset and finding the most similarity (subject03.happy is as an example we can do this for everypic in testSet)
testingWeight = zeros(1,6);
testingPic = imread('D:\LA\Final\testSet\subject03.happy.gif');
testingPic   =  im2single(testingPic);
figure(8), imshow(testingPic); title('initial testing pic')
normalizedTestingPic = testingPic(:)-av(:); 
for k=1:6
  testingWeight(k)  =  sum(normalizedTestingPic.* finalEigenFace{k}(:)) ;
end
diffWeights = zeros(150,1);
for m=1:150  
    summ=0;
    for k=1:6
        summ = summ + (testingWeight(k) -weight(m,k)).^2;
    end
    diffWeights(m) =   sqrt( summ);
end
minimum=min(min(diffWeights));
[x,y]=find(diffWeights==minimum);
fprintf( 'most similarity found in  %d th image\n', x);
figure(9), imshow(images{x}); title('pic with the most similarity with th testingPic')






