function [ signal_bruite ] = bruitage(signal,type_bruit,RSB,info)

%On veut trouver b tel que RSB soit celui en argument. On modifie donc le
%bruit en argument avec nouveau_bruit=alpha*bruit

if strcmp(type_bruit,'BBG') == 1
    n=length(signal);
    sigma=info;
    bruit=sigma*randn(1,n);
alpha=sqrt((sum(signal.^2)/sum(bruit.^2))*10^(-RSB/10));
bruit=transpose(alpha*bruit);
signal_bruite=signal+bruit;


elseif strcmp(type_bruit,'Bcol') == 1
    n=length(signal);
    f=info;
    t=linspace(1,n,n);
    bruit=cos(2*pi*f*t);
    alpha=sqrt((sum(signal.^2)/sum(bruit.^2))*10^(-RSB/10));
bruit1=transpose(alpha*bruit);
signal_bruite=signal+bruit1;

end
end

