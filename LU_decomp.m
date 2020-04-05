function x = LU_decomp(A, B, size)
        
    % We want to solve Ax = B, where A and B are known and we are solving
    % x. 
    
    size = size;
    A = A; 
    B= B;
    
    L = ones(size); % This is the matrix we would like to fill. 
    
    L = tril(L); % Grabs the LOWER TRIANGULAR portion of the matrix. With this method, we get some unwanted ones. 
    
    rowshift = 1;
    
    for col = [1:size-1]
            
        for row = [rowshift:size-1] % We will start from the top and make this simple. 
        
        divisor = A(rowshift, col);
        number = A(row+1, col);
        
        scaling_factor = -number/divisor;
        
        % Need to do the row operations now!
        
        A(row+1, [1:size]) = A(row+1, [1:size]) + scaling_factor*A(rowshift,[1:size]);
        
       
        L(row+1, col) = -scaling_factor;
             
        % this row is done, move onto the lower one!
        
        end   
    
        rowshift = rowshift + 1 ; % We need to shift down rows gradually as we reach the bottom of the matrix. 
        
    end
    
    U = A;
    
    %disp(L);
    %disp(U);
    
    % We now have the upper and lower matrices. We can use these to solve
    % for x, what we are looking for. 
    
    y = gauss_elim(L,B,size);
    
    x_solved = gauss_elim(U,y,size);
    
    disp("Solution")
    disp(x_solved);
    x = x_solved;
    
end