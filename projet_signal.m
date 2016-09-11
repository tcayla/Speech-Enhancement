clear all
close all

%% Partie 1-2.2

load 'fcno01fz.mat';


s1=fcno01fz;
soundsc(s1)



N=4096;
fech=8000;
f0=440;
sigma=5;
RSB=5;
n=length(s1);
axe_temps = axe_perso('temps',s1,fech);

%arguments de bruitage :bruitage(signal,type de bruit [BBG ou Bcol], Valeur
%du RSB,f0/fech)

[s1_bruitebg]=bruitage(s1,'BBG',RSB,sigma);
[s1_bruitecol]=bruitage(s1,'Bcol',RSB,f0/fech);

figure(1)
subplot(211), plot(axe_temps,s1), xlabel('temps'), ylabel('signal'), axis([0 6.7 -3*10^4 10^4])
subplot(212), spectrogram(s1, 256, 10, 256, fech,'yaxis'), xlabel('temps'), ylabel('frequence')

figure(2)
subplot(211), plot(axe_temps,s1_bruitebg), xlabel('temps'), ylabel('signal'), axis([0 6.7 -3*10^4 10^4])
subplot(212), spectrogram(s1_bruitebg, 256, 10, 256, fech,'yaxis'), xlabel('temps'), ylabel('frequence')

%% Partie 1-2.3

S1=abs(fftshift(fft(s1)));

S1_debruite0=debruite(S1_bruitecol,0);
S1_debruite3=debruite(S1_bruitecol,3);
S1_debruite5=debruite(S1_bruitecol,4);

s1_debruite0=ifft(ifftshift(S1_debruite0)); 
s1_debruite3=ifft(ifftshift(S1_debruite3));
s1_debruite5=ifft(ifftshift(S1_debruite5));

soundsc(s1_debruite0)
%On entend la frÈquence dÈbruitÈe tout le long

soundsc(s1_debruite3)
%On entend toujours la fr?quence d?bruit?e au dÈbut et ‡ la fin

soundsc(s1_debruite5); 
%On ne l'entend plus


%% D?finition des filtres RII et RIF

%RIF

teta=2*pi*f0/fech;
rz0=1; %On place le z?ro sur le cercle pour qu'il y ait rejection totale
z1=rz0*exp(1i*teta);
z2=rz0*exp(-1i*teta);

 
A0=[1,-2*rz0*cos(teta),rz0^2];

s1_rif=filter(A0,1,s1_bruitecol);
 
%RII
rp0=0.99; 
p1=rp0*exp(1i*teta); 
p2=rp0*exp(-1i*teta);

B0=[1, -2*rp0*cos(teta), rp0^2];
s1_rii=filter(A0,B0,s1_bruitecol);

%Calculer gain aprËs filtrage
Gain=10*log(abs(S1_rii).^2);


%% DÈcoupage en trames

t_trame=32*10^-3; %correspond ‡ 256 Èchantillons (puissance de 2 pour la fft), ordre de grandeur -> pseudo-pÈriodique

recouv=0.5;
 
[T, nb_trame]=decoupage(s1,t_trame,recouv,fech); 


%% Reconstruction du signal

s1new=reconstruction(T,t_trame,recouv,fech,nb_trame,n);

%% DÈbruitage par Hankel

seuil=200;

%bruitage du signal
[s1_bruitebg]=bruitage(s1,'BBG',RSB,sigma);

%dÈcoupage de la matrice en trame
Tbg=decoupage(s1_bruitebg,t_trame,recouv,fech); 

%dÈbruitage du signal par la mÈthode de Hankel
[signal_deb_bg, T_hankel_bg]=debruit_hankel(Tbg,20);


trame_origine=s1(18560:18560+floor(t_trame*fech));
trame_bg=s1_bruitebg(18560:18560+floor(t_trame*fech));
trame_dbg=signal_deb_bg(18560:18560+floor(t_trame*fech));

figure(28)
plot(trame_origine,'r'), xlabel('temps'), ylabel('signal')
hold on
plot(trame_bg,'g')
hold on
plot(trame_dbg,'b')


TR_OR=abs(fftshift(fft(trame_origine)));
TR_BG=abs(fftshift(fft(trame_bg)));
TR_DBG=abs(fftshift(fft(trame_dbg)));

figure(29)
plot(TR_OR,'r')
hold on
plot(TR_BG,'g')
hold on
plot(TR_DBG,'b')


bruit=s1_bruitebg-s1;
RSB_exp=10*log10(sum(abs(signal_deb_bg.^2))/sum(abs(bruit.^2)))
