%Biologinis neuronas
%Neuronas turi tris sinapses: AMPA, GABAA ir GABAB.
%Neuronas generuoja veikimo potenciala, kai membranos potencialas virsija 
%slenkstine itampa threshold (generavimo mechanizmas nemodeliuotas)

%Parametrai:
%T - eksperimento trukme, s
%synapses - sinapsiu pridejimas/pasalinimas nurodomas siame vektoriuje:
%    synapses(1)=0; AMPA sinapses nera;   synapses(1)=1; AMPA sinapse yra;
%    synapses(2)=0; GABAA sinapses nera;  synapses(2)=1; GABAA sinapse yra;
%    synapses(3)=0; GABAB sinapses nera;  synapses(3)=1; GABAB sinapse yra;
%time_eventsAMPA, time_eventsGABAA, time_eventsGABAB - sinapsiu aktyvavimo 
%    laiko momentai nurodomi siuose vektoriuose; 
%w_AMPA, w_GABAA, w_GABAB - sinapsiu svoriai, teigiami.
%    Sinapses svoris > 1 - sinapse stipreja; 
%    Sinapses svoris < 1 - sinapse silpneja; 

%Randamas neurono sugeneruotu veikimo potencialu skaicius ir daznis. 
%Grafiskai pavaizduojama:
%1. Membranos potencialas
%2. Sinapsiu laidumai
%3. Neurono isejimas kaip dvejetaine funkcija: 0 - veikimo potencialas
%   negeneruojamas, 1 - veikimo potencialas generuojamas;
%4. Neurono iejimas, t.y. sinapsiu aktyvavimas,  kaip dvejetaine funkcija: 
%   0 - sinapse neaktyvuojama, 1 - sinapse aktyvuojama

%Ausra Saudargiene 2016

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%Darbines atminties isvalymas
clear;
%paveikslu uzdarymas
close all;

%Eksperimento parametrai 
T=60e-3; %eksperimento trukme sec

%Sinapsiu aktyvumas
synapses=[1 0 0]; %AMPA GABAA GABAB; 1 - aktyvi, 0 neaktyvi
%Sinapsiu aktyvavimo laiko momentai 
%time_eventsAMPA=10e-3; %AMPA sinapses aktyvavimo laikas sec 
time_eventsAMPA=[10e-3 12e-3 14e-3 16e-3 18e-3]; %AMPA sinapses aktyvavimo laikas sec
time_eventsGABAA=[12e-3 22e-3 32e-3 42e-3 52e-3]; %GABAA sinapses aktyvavimo laikas sec
time_eventsGABAB=[10e-3 20e-3 30e-3 40e-3 50e-3]; %GABAB sinapses aktyvavimo laikas sec


%Sinapsiu svoriai
w_AMPA=1;
w_GABAA=1;
w_GABAB=1;

%-------------------------
%Zingsniu skaicius
dt=0.1e-3; %laiko zingsnis sec

Nsteps=round(T/dt+1); %eksperimento zingsniu skaicius

%-------------------------
%AMPA sinapses aktyvavimas 
%-------------------------
%sukuriamas Nsteps ilgio vektorius spikeAMPA
%1 - AMPA sinapse aktyvuojama
%0 - AMPA sinapse neaktyvuojama
spikeAMPA=zeros(1,Nsteps);
%eventsAMPA - vektorius, kuriame nurodomi laiko zingsniai, kai aktyvuojama AMPA sinapse 
eventsAMPA=round(time_eventsAMPA/dt+1);
if synapses(1)==1
    spikeAMPA(eventsAMPA)=1; %veikimo potencialas 100jame laiko zingsnyje; 100*dt=10e-3s=10ms
end

%-------------------------
%GABAA sinapses aktyvavimas
%-------------------------
%sukuriamas Nsteps ilgio vektorius spikeGABAA
%1 - GABAA sinapse aktyvuojama
%0 - GABAA sinapse neaktyvuojama
spikeGABAA=zeros(1,Nsteps);
%eventsGABAA - vektorius, kuriame nurodomi laiko zingsniai, kai aktyvuojama GABAA sinapse 
eventsGABAA=round(time_eventsGABAA/dt+1);
if synapses(2)==1
    spikeGABAA(eventsGABAA)=1; 
end

%-------------------------
%GABAB sinapses aktyvavimas
%-------------------------
%sukuriamas Nsteps ilgio vektorius spikeGABAB
%1 - GABAB sinapse aktyvuojama
%0 - GABAB sinapse neaktyvuojama
spikeGABAB=zeros(1,Nsteps);
%eventsGABAB - vektorius, kuriame nurodomi laiko zingsniai, kai aktyvuojama GABAB sinapse 
eventsGABAB=round(time_eventsGABAB/dt+1);
if synapses(3)==1
    spikeGABAB(eventsGABAB)=1; %spike at the 100th time step; 100*dt=10e-3s=10ms
end

%---------------------------------------------
%Neurono parameterai
%---------------------------------------------
%AMPA parameterai
gconstAMPA=5e-9;%maksimalus laidumas Siemensai S
tauAMPA=5e-3;%laiko konstanta sec
E_AMPA=0; %reversinis potencialas V

%GABAA parametrai 
gconstGABAA=120e-9;% maksimalus laidumas Siemensai S
tauGABAA=5e-3;% laiko konstanta sec
E_GABAA=-0.070;%;  %reversinis potencialas V

%GABAB parametrai
gconstGABAB=5e-9;%maksimalus laidumas Siemensai S
tauGABAB=50e-3;%laiko konstanta sec
E_GABAB=-0.090;%; reversinis potencialas V

%Membranos parameterai
Vrest=-0.070; %ramybes potencialas V
R=100e+6;     %varza Ohm
C=50e-12;     %talpa F
threshold=-0.054; % veikimo potencialu generavimo slenkstis V
Vspike=0; % membranos potencialas, zymintis veikimo potencialo generavima V (iprastinis 0.04V)
spike_count=0; %Veikimp potencialu skaicius  

%---------------------------------------------
%Integravimas: membranos potencialo lygtis 
%---------------------------------------------

%Pradines salygos
%membranos potencialas
Vmem(1)=Vrest;
%sinapsiu laidumai
gAMPA(1)=0;
gNMDA1(1)=0;
gGABAB(1)=0;
gGABAA(1)=0;
%sinapsiu sroves
I_AMPA(1)=0;
I_GABAA(1)=0;
I_GABAB(1)=0;

%---------------------------------------------
%Ciklas: pradzia
%---------------------------------------------
for i=2:Nsteps
    
  t(i)=(i-1)*dt;

  %AMPA sinapses laidumas 
  %Stochastic activation: Poisson ISI
  %spikeAMPA(i)=spikePoisson(100,dt);
   
  if (spikeAMPA(i)==1) %AMPA presinaptinis veikimo potencialas, sinapse aktyvuojama, laidumas padideja 
      delta_gAMPA=gconstAMPA;
  else                 %AMPA presinaptinio veikimo potencialo nera, laidumas mazeja arba lygus 0
      delta_gAMPA=-gAMPA(i-1)/tauAMPA*dt;
  end
  gAMPA(i)=gAMPA(i-1)+delta_gAMPA; 
    
 
  %GABAB sinapses laidumas
  if (spikeGABAA(i)==1) 
      delta_gGABAA=gconstGABAA;
  else                 
      delta_gGABAA=-gGABAA(i-1)/tauGABAA*dt;
  end
  gGABAA(i)=gGABAA(i-1)+delta_gGABAA; 
  
  
  %GABAB sinapses laidumas
  if (spikeGABAB(i)==1) 
      delta_gGABAB=gconstGABAB;
  else                 
      delta_gGABAB=-gGABAB(i-1)/tauGABAB*dt;
  end
  gGABAB(i)=gGABAB(i-1)+delta_gGABAB; 
  
  %Sinapsiu sroves
  I_AMPA(i)=w_AMPA*gAMPA(i)*(Vmem(i-1)-E_AMPA);
  I_GABAA(i)=w_GABAA*gGABAA(i)*(Vmem(i-1)-E_GABAA);
  I_GABAB(i)=w_GABAB*gGABAB(i)*(Vmem(i-1)-E_GABAB);
  synInputs=I_AMPA(i)+I_GABAA(i)+I_GABAB(i);
  
  %Membranos potencialo pokytis 
  deltaVmem(i)=((Vrest-Vmem(i-1))/R-synInputs)*dt/C;
  %Membranos potencialas
  Vmem(i)=Vmem(i-1)+deltaVmem(i);
  
  %Tikrinimas, ar nevirðijamas GABAB sinapsiø reversinis potencialas
  if Vmem(i)<=E_GABAB
     Vmem(i)=E_GABAB;
  end
  
  neuro_output(i)=0; % isejimo neurono reiksme 0/1 
  
  %veikimo potencialo generavimas 
  if Vmem(i)>threshold
      Vmem(i-1)=Vspike; % veikimo potencialas
      Vmem(i)=Vrest;
      spike_count=spike_count+1; %veikimo potencialu skaicius 
      neuro_output(i)=1;
  end
  
end
%---------------------------------------------
%Ciklas: pabaiga
%---------------------------------------------

figure(1); %hold on 
subplot(4,1,1);
plot(t*1000,Vmem,'r', 'Linewidth',2)
title('Membranos potencialas', 'Fontsize', 14)
xlabel('t, ms');
ylabel('Vmem, V')

subplot(4,1,3);
plot(t*1000,neuro_output,'r','Linewidth',2)
title('Neurono isejimas 0/1', 'Fontsize', 14)
xlabel('t, ms');

subplot(4,1,4);
plot(t*1000,spikeAMPA,'r', t*1000, spikeGABAA, 'g', t*1000, spikeGABAB, 'b','Linewidth',2)
legend('AMPA', 'GABAA', 'GABAB')
title('Neurono iejimas 0/1','Fontsize', 14)
xlabel('t, ms');

subplot(4,1,2);
plot(t*1000,gAMPA,'r', t*1000,gGABAA, 'g', t*1000,gGABAB, 'b','Linewidth',2)
title('AMPA, GABAA ir GABAB sinapsiu laidumas', 'Fontsize', 14)
legend('AMPA', 'GABAA', 'GABAB')
ylabel('g, S')
xlabel('t, ms');

time_experiment=(Nsteps-1)*dt;
f=spike_count/time_experiment; % isejimo neurono veikimo potencialu generavimo daznis 

fprintf('\nIsejimo neurono veikimo potencialu skaicius N=%d\n',spike_count );
fprintf('Isejimo neurono daznis f=%4.1fHz \n',f );
 
