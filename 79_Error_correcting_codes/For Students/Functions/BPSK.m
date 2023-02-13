function x = BPSK(c,A)
%BPSK: perform BPSK modulation '0' -> +A, '1'-> -A
x = A*(1-2*c);
end

