function [ indexed ] = indexed( index, AU_vector )
% returns true if AUvector has subcomponents in vector.
        
    indexed = false;
    for x=1:length(index)
        if(isequal(intersect(index{x}, AU_vector), index{x}))
            indexed = true;
            return;
        end
    end
    
end

