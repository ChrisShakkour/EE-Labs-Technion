clc
clear
close all

load('For Students/Data/Variables.mat');
addpath('For Students/Functions/');
%% Section 1
%##################################
names="lariene";
str_n=str2bit(names);
fprintf("name: ")
fprintf("%d", str_n);
fprintf("\n");

bsc_c=bsc(str_n, 0.1);
fprintf("Bsc:  ");
fprintf("%d", bsc_c);
fprintf("\n");
%##################################
%% Section 2
str_b=bit2str(bitStrErr1);
fprintf("str0.1:  ");
fprintf("%s", str_b);
fprintf("\n");

%##################################
%% Section 3

str_c=bit2str(bitStrErr2);
fprintf("str1:  ");
fprintf("%s", str_c);
fprintf("\n");

%##################################
%% Section 4
song = strcat(...
'What about sunrise?',...
'What about rain?',...
'What about all the things',...
'That you said we were to gain?',...
'What about killing fields?',...
'Is there a time?',...
'What about all the things',...
'That you said was yours and mine?',...
'Did you ever stop to notice',...
'All the blood weve shed before?',...
'Did you ever stop to notice',...
'This crying Earth, these weeping shores?',...
'Ah-ah-ah-ah-ah',...
'Ooh-ooh-ooh-ooh-ooh',...
'Ah-ah-ah-ah-ah',...
'Ooh-ooh-ooh-ooh-ooh',...
'What have we done to the world?',...
'Look what weve done',...
'What about all the peace',...
'That you pledge your only son?',...
'What about flowering fields?',...
'Is there a time?',...
'What about all the dreams',...
'That you said was yours and mine?',...
'Did you ever stop to notice',...
'All the children dead from war',...
'Did you ever stop to notice',...
'This crying Earth, these weeping shores?'...
);
bitStream = str2bit(song);

%##################################
%% Section 5
A=1; bitStrModulated = BPSK(bitStream,A); 
sigma=1; bitStrErr = AWGN(bitStrModulated,sigma);
figure(); plot(bitStrErr);

%##################################
%% Section 6
bitStrHard = double(bitStrErr<0);
xored = bitxor(bitStream,bitStrHard);
err_num = sum(xored(:) == 1);

%##################################
%% Section 7
A = logspace(-1,2,100); 
bitStrModulated = BPSK(bitStream,A(50)); 
sigma=1; bitStrErr = AWGN(bitStrModulated,sigma);
figure(); plot(bitStrErr);
bitStrHard = double(bitStrErr<0);
xored = bitxor(bitStream,bitStrHard);
err_num = sum(xored(:) == 1);

%##################################
%% Section 8
A = logspace(-1,2,100); BitErrorRate = zeros(1,numel(A));
rate_of_errors= zeros (1 , numel ( A ));
for aa = 1:numel(A)
    a = A(aa);
    bitStrModulated = BPSK(bitStream,a); 
    sigma=1; bitStrErr = AWGN(bitStrModulated,sigma);
    bitStrHard = double(bitStrErr<0);
    xored = bitxor(bitStream,bitStrHard);
    err_num = sum(xored(:) == 1);
    rate_of_errors(aa) = err_num./numel(bitStream);
    ... BPSK + AWGN + Hard Decision + Count Errors
end
    
figure();
semilogy(A,rate_of_errors, 'r');
xlabel('A amplitude');
ylabel('error percentage');
hold on;    

%##################################
