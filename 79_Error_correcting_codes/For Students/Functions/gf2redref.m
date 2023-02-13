 function [A, Row_ops] = gf2redref(H)
        [m,n] = size(H);
        Row_ops = eye(m);
        A = [H, Row_ops];
        nr = size(A, 2);
        
        % Loop over the entire matrix.
        i = 1;
        j = 1;
        
        while (i <= m) && (j <= n)
            while (A(i,j) == 0) && (j <= n)
                % Find value and index of first non-zero element in the remainder of column j.
                k = find(A(i:m,j),1) + i - 1;
                
                if (isempty(k))
                    j = j + 1;
                    continue;
                else
                    % Swap i-th and k-th rows.
                    A([i k],j:nr) = A([k i],j:nr);
                end
            end
            
            if (A(i,j) == 1) && (j <= n)
                % Save the right hand side of the pivot row
                aijn = A(i,j:nr);
                
                % Column we're looking at
                col = A(1:m,j);
                
                % Never Xor the pivot row against itself
                col(i) = 0;
                
                % This builds an matrix of bits to flip
                flip = col*aijn;
                
                % Xor the right hand side of the pivot row with all the other rows
                A(1:m,j:nr) = xor( A(1:m,j:nr), flip );
                
                j = j + 1;
            end
            
            i = i + 1;
        end
        Row_ops = A(1:m,(n+1):nr);
        A = A(1:m,1:n);
    end
