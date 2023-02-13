function out = ConstChannel(in)
if (sum(in.*[0 in(1:end-1)])>0)
    error("Input to channel does not satisfy channel constraint");
else
    out = in;
end
end

