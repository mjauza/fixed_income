include("./bonds.jl")

function ir_swap(df_arr)
    r = (1 - last(df_arr))/sum(df_arr)
    return r    
end