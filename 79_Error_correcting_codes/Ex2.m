clc
clear
close all

load('For Students/Data/Variables.mat');
addpath('For Students/Functions/');
%% Section 1
%##################################
emojis=' <: -) 8 -D ; -O : -X'; msg=str2bit(emojis);
msgLength = length ( msg );

%% Section 2
%##################################
bsc_msg = bsc(msg, 0.1);
str_msg = bit2str(bsc_msg);
fprintf("%s\n", str_msg);
xored = xor(bsc_msg, msg);
err_num = sum(double(xored));

%% Section 3
%##################################
rep_msg = repmat(msg,9,1);
bsc_msg = bsc(rep_msg,0.1);
dec_msg = zeros(1,numel(msg));

for i = 1:numel(msg)
    decode = 0;
    for j = 1:9
        decode = decode + bsc_msg(j,i);
    end
    dec_msg(i) = double(decode>4.5);
end
xored = xor(msg, dec_msg);
err_num = sum(xored(:)==1);
str_msg = bit2str(dec_msg);
fprintf("%s\n", str_msg);

%% Section 4
%##################################
rep_msg = repmat(msg,9,1);
bsc_msg = bsc(rep_msg,0.25);
sum_bsc_msg = sum(bsc_msg);
dec_msg = double(sum_bsc_msg>4.5);
xored = xor(msg, dec_msg);
err_num = sum(xored(:)==1);
str_msg = bit2str(dec_msg);
fprintf("%s\n", str_msg);

%% Section 5
%##################################
nVec =9:4:33; 
err_num_n = zeros(1,length(nVec));
for jj =1: length(nVec)
    n = nVec(jj);
    rep_msg = repmat(msg,n, 1);
    bsc_msg = bsc(rep_msg,0.25);
    sum_bsc_msg = sum(bsc_msg);
    dec_msg = double(sum_bsc_msg>n/2);
    xored = xor(msg, dec_msg);
    err_num_n(jj)= sum(xored(:)==1);
end
figure();
plot(nVec,err_num_n./length(msg), 'r');
xlabel('n');
ylabel('error');

%% Section 6
%##################################
nVec =9:4:33;
p=0:0.05:0.5;
err_num_nm = zeros(length(p),length(nVec));
for jj =1: length(nVec)
    n = nVec(jj);
    rep_msg = repmat(msg,n, 1);
    for k=1:length(p)
        for i=1:100
            bsc_msg = bsc(rep_msg,p(1, k));
            sum_bsc_msg = sum(bsc_msg);
            dec_msg = double(sum_bsc_msg>n/2);
            xored = xor(msg, dec_msg);
            err_num_nm(k,jj)= err_num_nm(k,jj)+sum(xored(:)==1);
        end
    end
end

figure()
plot(p,err_num_nm./length(msg)./100);
xlabel('probability');
ylabel('ratio');
