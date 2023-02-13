function G=G2H(H)
[A, ~] = gf2redref(H); %rank H
% swap columns to convert H into a systematic form
S=sum(A,1);
J=find(S==1);
Swap1=find(J~=(1:length(J)));
Swap2=J(Swap1);  
for j=1:length(Swap1)
    A(:,[Swap1(j) Swap2(j)])=A(:,[Swap2(j) Swap1(j)]);
end
% find the corrsponding generating matrix
G=gen2par(A);
%swap back columns
for j=(length(Swap1):-1:1)
    G(:,[Swap1(j) Swap2(j)])=G(:,[Swap2(j) Swap1(j)]);
end
assert(any(any(mod(G*H',2)))==0)

end