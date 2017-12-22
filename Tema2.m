%Numar 21
%Semnal dreptunghiular cu perioada P=40[sec]
%Durata semnalelor D=21[sec]
%Numar de coeficienti Fourier N=50

P=40; 
D=21; 
N=50; 
f=1/P; 
w0=2*pi*f; %frecventa unghiulara
rez=0.1; %rezolutia temporala a semnalului

s1=[ones(1,D/rez),zeros(1,(P-D)/rez)]; %o perioada din semnalul dreptunghiular
t=0:rez:P; %timpul echivalent petru o perioada
perioada=P/rez;%cate esantioane avem intr-o perioada
inter1=0:rez:P;
stem(inter1(1:400),s1)
title('Semnalul Dreptunghiular x(t)')
xlabel('t[s]')
ylabel('A')
semnal=repmat(s1,1,5);%repetam semnalul initial de 5 ori
%Determinam coeficientii Seriei Fourier Exponentiale
xk=zeros(1,2*N+1);
for m=-N:1:N
    for l=1:1:perioada
    xk(m+N+1)= xk(m+N+1)+semnal(l)*exp(-1i*m*w0*t(l));
    end
end
figure
stem((-N:N),abs(xk)) %spectrul semnalului
title('Spectrul  de amplitudini al x(t)') 
s_rec=zeros(1,perioada); %initializam semnalul ce va fi reconstruit
for l=1:1:perioada
    for m=-N:1:N
        s_rec(l)= s_rec(l)+xk(m+N+1)*exp(1i*m*w0*t(l));
    end
end
s_rec=s_rec/perioada;%normam semnalul reconstruit
figure
plot(real(s_rec))
hold on
plot(s1,'color','g')
title('x(t)-verde, Reconstructia folosind N coeficienti-albastru')

%Conform cursului de Sisteme si Semnale, semnalul periodic real poate fi 
%aproximat prin sume de oscilatii armonice, care ne dau spectrele de
%amplitudine si de faza. Cunoasterea spectrelor de amplitudine si de faza,
%determina complet semnalul periodic. Semnalul reconstruit cu N coeficienti
%calculati se apropie de semnalul x(t) dreptunghiular, dar cu o oarecare
%eroare. Daca avem un numar N mai mare de coeficienti, semnalul reconstruit
%ar s-ar apropia mai precis de forma semnalului dreptunghiular x(t).
