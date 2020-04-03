function x = LU_decomp(A, B, size)
        
    % We want to solve Ax = B, where A and B are known and we are solving
    % x. 
    size=size;
    A = A; 
    B= B;
    
    L = ones(size); % This is the matrix we would like to fill. 
    
    L = tril(L); % Grabs the LOWER TRIANGULAR portion of the matrix. With this method, we get some unwanted ones. 
    
    
    for col = [1:2]
            
        for row = [1:2] % We will start from the top and make this simple. 
        
        divisor = A(row, col);
        number = A(row+1, col);
        
        scaling_factor = number/divisor;
        
        % Need to do the row operations now!
        
        A = A(row+1, [1:3]) + scaling_factor*A(row,[1:3]);
        
        if scaling_factor < 0 % Results if both signs are the same: 
            
            L(row+1, col) = scaling_factor;
        
        else 
            
            L(row+1, col) = -scaling_factor;
        
        end
        
        
        
        

    end   
    
    end
    disp(L);
    
    x = L;
    
end