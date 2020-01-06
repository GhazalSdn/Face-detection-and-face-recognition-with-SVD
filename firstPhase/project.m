%% First Step

myFolder = 'D:\LA\Final\pic';
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
 for k=1:165
    images{k} = im2single(images{k});    
    av   =av  + (1/165)*images{k}; 
 end
 figure,imshow(av);title('average')

 %% Third Step
 
for k=1:165
    imagesminusav{k}  = images{k} -av;
end
Q = zeros(243*320,165);
for k=1:165
    Q(:,k) = imagesminusav{k}(:);
end

%% Fourth Step

for k=1:165
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
    maxValues = eigenValues([160,161,162,163,164,165],[160,161,162,163,164,165]); 
    maxVectors = eigenVectors(:,[160,161,162,163,164,165]);
    eigenFaces = Q*maxVectors;
    for k=1:6
     finalEigenFace{k} = reshape(eigenFaces(:,k),243,320);
    end
   for k=1:6
     figure(k+1),imshow(finalEigenFace{k});title('eigenFace')
   end

    
%% findng Weights for each photo of dataset
weight = zeros(165,6);
for m=1:165  
  for k=1:6   
    weight(m,k) =   sum(Q(:,m).* finalEigenFace{k}(:)) ;
  end
end



