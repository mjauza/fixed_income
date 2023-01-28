# Funcions for Bond pricing
using Roots
using Plots


function coupon_bond_price(N, C, r, t_arr)
    # get discount factors
    df = (1/(1 + r)) .^ t_arr
    # get the price
    price = sum(C * df) + N * last(df)
    return price    
end

function ytm(bond_price::Number, C::Number, N::Number , t_arr)
    fun(r) = bond_price - coupon_bond_price(N,C,r,t_arr)
    yield = find_zero(fun, 0.02)
    return yield
end

function mac_duration(N::Number, C::Number, r::Number, t_arr)
    price = coupon_bond_price(N,C,r,t_arr)
    a = t_arr * C / ((1+r) .^ t_arr)
    a_sum = sum(a)
    last_t = last(t_arr)
    b = last_t*N/((1+r)^last_t)
    dur = (a_sum + b) / price
    return dur
end


function bootstrap_spot(t_arr, C_arr, P_arr, F_arr)
    """
    t_arr  : array of cash flow times
    C_arr  : array of coupons for each bond
    P_arr  : array of prices for each bond
    F_arr  : array of face values of each bond
    """
    @assert length(t_arr) == length(C_arr)
    @assert length(t_arr) == length(P_arr)
    @assert length(t_arr) == length(F_arr)

    s1 = ytm(P_arr[1], C_arr[1], F_arr[1] , t_arr[1])
    
    s_arr = [s1]

    for k in 2:length(t_arr)
        P_k = P_arr[k]
        F_k = F_arr[k]
        C_k = C_arr[k]
        df_arr = (1 / ((1 .+ s_arr).^(1:k-1)))
        s_k = ((C_k + F_k)/(P_k - C_k*sum(df_arr))) ^ (1/k) - 1
        append!(s_arr, s_k)        
    end

    return s_arr
end

function get_df(s_arr, t_arr)
    return 1/((1 .+ s_arr) .^ t_arr)
end



