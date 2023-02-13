function C = CreateRLL1InfCode(n)
if(n == 2)
    C = zeros(2,2); C(2,:) = [1 0];
elseif(n == 3)
    C = zeros(3,3); C(2,:) = [0 1 0]; C(3,:) = [1 0 0];
else
    Cn1 = CreateRLL1InfCode(n-1);
    Cn2 = CreateRLL1InfCode(n-2);
    C = [
        zeros(size(Cn1,1),1) Cn1;
        ones(size(Cn2,1),1) zeros(size(Cn2,1),1) Cn2]; 
end

end

