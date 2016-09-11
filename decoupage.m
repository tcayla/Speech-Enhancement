function [ T,nb_trame ] = decoupage(signal, temps_trame, recouvrement,fech)


nb_ech_trame=floor(temps_trame*fech);
ech_non_recouv=floor((1-recouvrement)*nb_ech_trame);
nb_trame=floor(length(signal)/ech_non_recouv-1);
nb_ech_recouv=ceil(recouvrement*nb_ech_trame);

spad=[signal' zeros(1,-length(signal)+(nb_trame-1)*ech_non_recouv+nb_ech_trame)]; %zero-padding pour que la derni?re trame soit pleine

h=hamming(floor(temps_trame*fech));

T=zeros(nb_trame,nb_ech_trame);
for j=1:nb_ech_trame
    T(1,j)=spad(j);
end

for i=2:nb_trame-1
    for j=1:nb_ech_trame
        T(i,j)=spad(ech_non_recouv*(i-1)+j);
    end
end

 

 
 for j=1:(nb_ech_trame*recouvrement)
T(nb_trame,j)=T(nb_trame-1,floor(nb_ech_trame*(1-recouvrement)+j));
 end
% 1 trame : 1 ligne de T

%% Fenêtrage (Hamming)
for i=1:nb_trame
    T(i,:)=T(i,:).*h';
    
end



end

