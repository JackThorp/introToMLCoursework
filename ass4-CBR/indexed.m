function [ indexed ] = indexed( index, AU_vector )
% returns true if AUvector has subcomponents in vector.
        
    indexed = false;
    for x=1:length(index)
        if( numel(intersect(index{x}, AU_vector))> (numel(index{x})/2) )
            indexed = true;
            return;
        end
    end
    
end

