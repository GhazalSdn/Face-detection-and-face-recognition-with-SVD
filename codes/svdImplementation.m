%% SVD COMPRESSION

A = im2single((imread('D:\LA\Final\pic\subject01.noglasses.gif')));
[U,S,V]=svd(A);   
  
for k=5:25:105  
Ak = U(:,1:k)*S(1:k,1:k)*(V(:,1:k))';
error=sum(sum((A-Ak).^2));
figure,imshow(Ak);title(sprintf('Image created by using %d singular values + error : %d',k , error))  
end



% %%SVD COMPRESSION
% A = im2single((imread('D:\LA\Final\pic\subject01.noglasses.gif')));
% C = A' * A;
% sigma = zeros(243 , 320);
% editedEigenValues = zeros(320,320);
% V = zeros(320,320);
% U = zeros(243,243);
% [eigenVectors,eigenValues]= eig(C);
% for k = 1:320*320
%     editedEigenValues(k) = eigenValues(k);
%    if(eigenValues(k) <= 0)
%       editedEigenValues(k) = 0;
%    end
%     
% end
% for k = 1 :320
%     V(:,321-k) = eigenVectors(:,k);
% end
% for i = 320 : -1 : 78 
%     m = 320-i ;
%  sigma(1+m , 1+m) = sqrt(editedEigenValues(i , i));
% end
% for t = 1:243
%     U(: , t) = A*V(:,t);
% end
% 
% % svd = U*sigma*V'
% 
% for j=5:25:105  
% Ak = U(:,1:j)*sigma(1:j,1:j)*(V(:,1:j))';
% error=sum(sum((A-Ak).^2));
% figure,imshow(Ak);title(sprintf('Image created by using %d singular values + error : %d',j , error))  
% end
% 
% 


















