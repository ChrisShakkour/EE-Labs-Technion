function H = regLDPCpar(wc,wv,wordLen,MaxIter)

parNum = wv*wordLen/wc;
if parNum ~= round(parNum)
    error('size mismatch');
end

bit_vec = repmat(1:wordLen,wv,1); bit_vec = bit_vec(:);
par_vec = repmat(1:parNum,wc,1);par_vec = par_vec(:);

iter = 1; cond = 1;
while cond
    rand_ind = randperm(length(par_vec));
    par_vec_rand = par_vec(rand_ind);
    Nuniq = size(unique([bit_vec,par_vec_rand],'rows'),1);
    if Nuniq == length(bit_vec) 
        cond = 0;
    end
    iter = iter + 1;
end
H=sparse(par_vec_rand,bit_vec,1);
end