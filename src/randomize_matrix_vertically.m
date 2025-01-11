    function [random_arrangement, position_changes] = randomize_matrix_vertically(matrix)
        random_arrangement = matrix;
        position_changes = cell(size(matrix, 2), 1);
        for col = 1:size(matrix, 2)
            perm = randperm(size(matrix, 1));
            random_arrangement(:, col) = matrix(perm, col);
            position_changes{col} = [transpose(1:size(matrix, 1)), perm'];
        end
        
    end