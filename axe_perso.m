function [ axe ] = axe_perso(type_axe,signal,fech)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n=length(signal);

if strcmp(type_axe,'temps') == 1
    
axe=(1:n)/fech;

elseif strcmp(type_axe,'freq') == 1
axe=(-fech/2:fech/n:fech/2-fech/n);

end
end

