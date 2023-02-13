function y = AWGN(x,sigma)
%AWGN: simulate AWGN channel 
y = x+sigma*randn(size(x));
end

