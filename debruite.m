function [ signal_debruite] = debruite(signal,ecart)
%La fonction recherche le maximum de la repr?sentation fr?quentielle du
%signal, puis att?nue les fr?quences concern?es
max=signal(1);
N=length(signal);
for i=1:N
    if signal(i)>max
        max=signal(i);
        imax=i;
    end
    
end

if ecart ~= 0
    
    for j=-ecart:ecart
        signal(imax+j)=0;
        signal(N+2-imax+j)=0;
    end
else
    signal(imax)=0;
     signal(N+2-imax)=0;
end

signal_debruite=signal;
end

