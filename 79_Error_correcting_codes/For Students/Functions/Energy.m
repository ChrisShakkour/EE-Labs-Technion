function E = Energy(x)
%ENERGY: calculates enegrgy of a signal
E = sum(abs(x).^2,'All');%works for complex numbers
end

