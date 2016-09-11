function [ signal] = reconstruction(T,t_trame,recouv,fech,nb_trame,n)

nb_ech_trame=floor(t_trame*fech);
ech_non_recouv=floor((1-recouv)*nb_ech_trame);

nb_ech_recouv=ceil(recouv*nb_ech_trame);
h=hamming(floor(t_trame*fech));

signal=T(1,1:ech_non_recouv);

for i=2:nb_trame
    for j=1:nb_ech_recouv
        signal=[signal (T(i,j)+T(i-1,j+ech_non_recouv))/(h(j)+h(j+ech_non_recouv))];
    end
    if recouv<0.5
        if recouv==0
            for j=nb_ech_recouv+1:ech_non_recouv
                signal=[signal T(i,j)];
            end
        else
            for j=nb_ech_recouv:ech_non_recouv
                signal=[signal T(i,j)];
            end
        end
    end
end

if recouv == 0
    signal = [signal T(nb_trame,nb_ech_recouv+1:nb_ech_trame)];
else
    signal = [signal T(nb_trame,nb_ech_recouv:nb_ech_trame-1)];
    
    if length(signal)<n
        signal=[signal zeros(1,n-length(signal))];
    else if length(signal)>n
            signal=signal(1:n);
        end
    end
    
    
end

