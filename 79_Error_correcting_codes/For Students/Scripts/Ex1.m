song = strcat('SONG LYRICS ',...
                'MORE LYRICS ',...
                'MANY MORE');
bitStream = str2bit(song);

A=1; bitStrModulated = BPSK(bitStream,A); 
sigma=1; bitStrErr = AWGN(bitStrModulated,sigma);
figure(); plot(bitStrErr);

A = logspace(-1,2,100); BitErrorRate = zeros(1,numel(A));
for aa = 1:numel(A)
    a = A(aa);
    ... BPSK + AWGN + Hard Decision + Count Errors
end
