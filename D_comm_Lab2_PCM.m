clc
clear all
close all

n=5; % number of bits
n1=32; %  Frequency of analog signal
lengthb=2^n;
 
x=0:2*pi/n1:4*pi;               
s=2*sin(x);
subplot(5,1,1);
plot(s);
title('Analog Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
subplot(5,1,2);

% Sampling
stem(s);  title('Sampled Sinal'); 

% Quantization
 vmx=5;
 vmn=-vmx;
 dst=(vmx-vmn)/lengthb;
 part=vmn:dst:vmx;                                
 code=vmn-(dst/2):dst:vmx+(dst/2);        
 [ind,q]=quantiz(s,part,code);                    
                                                                     
 l1=length(ind);
 l2=length(q);
  
 for i=1:l1
    if(ind(i)~=0)                                           
       ind(i)=ind(i)-1;
    end 
 end   
  for i=1:l2
     if(q(i)==vmn-(dst/2))                      
         q(i)=vmn+(dst/2);
     end
 end    
 subplot(5,1,3);
 stairs(q);                                      
 title('Quantized Signal');

% Encoding
 code=de2bi(ind,'left-msb');             
 k=1;
 coded(k)=0;
for i=1:l1
    for j=1:n
        coded(k)=code(i,j);                 
        
        k=k+1;
    end
    
end
coded;
 subplot(5,1,4);
 stairs(coded);                                
axis([0 100 -2 3]);  
title('Encoded Signal');

% Decoding
 qunt=reshape(coded,n,length(coded)/n);
 index=bi2de(qunt','left-msb');                    
 q=dst*index+vmn+(dst/2);                       
 subplot(5,1,5);
 plot(q);                                                        
 
 title('Demodulated Signal');
