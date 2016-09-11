function [ signal_fin, T_hankel ] = debruit_hankel(T, seuil )

[h w]=size(T);
T_hankel=zeros(h,w);
for i=1:h 
    H=hankel(T(i,1:floor(w/2)),T(i,floor(w/2):end));
    [U,S,V] = svd(H);
    [hS,wS]=size(S);
    [hH,wH]=size(H); 
    % Reconstruction
   
   for j=seuil:hS
       for k=seuil:wS
           if j==k
               S(j,k)=0;
           end
       end
   end
   
   H_s = U*S*V';
   
   
  
   a=sum(T(i,:))/w;
   H_s=H_s+a;
   
  
    T_hankel(i,:)=[H_s(:,1)' H_s(hH,2:end)];
end
temps_trame=32*10^-3;
recouvrement=0.5;
fech=8000;
n=53248;
signal_fin=reconstruction(T_hankel,temps_trame,recouvrement,fech,h,n);
           
end

