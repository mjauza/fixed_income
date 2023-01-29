include("./utils.jl")
using Dates

function cc_spot_rate(P_tT::Number, tau_tT::Number)
    """
    R(t,T)
    Countnously compunded spot rate
    P_tT    : P(t,T) zero coupon bond 
    tau_tT  : tau(t,T) year fraction between t, T
    """
    return -log(P_tT)/tau_tT    
end

function sc_spot_rate(P_tT::Number, tau_tT::Number)
    """
    L(t,T)
    Simply compunded spot rate
    P_tT    : P(t,T) zero coupon bond 
    tau_tT  : tau(t,T) year fraction between t, T
    """
    return  (1 - P_tT)/(tau_tT * P_tT)
end

function ac_spot_rate(P_tT::Number, tau_tT::Number, k = 1)
    """
    Y(t,T)
    anually compunded spot rate
    P_tT    : P(t,T) zero coupon bond 
    tau_tT  : tau(t,T) year fraction between t, T
    k       : number of compounding per year
    """
    return k/(P_tT^(1/k*tau_tT)) - k
end

function sc_forward_rate(P_tT::Number, P_tS::Number, tau_TS::Number)
    """
    F(t, T, S)
    Simply compunded forward rate
    P_tT    : P(t,T) zero coupon bond
    P_tS    : P(t,S) zero coupon bond 
    tau_TS  : tau(T,S) year fraction between T, S
    """
    return 1/tau_TS*(P_tT/P_tS - 1)
end

function swap_rate(P_arr, tau_arr)
    """
    Forward Swap rate
    CFs are at times T_(alpha + 1), ... T_beta

    P_arr, array of zcb prices, P(t, T_alpha) ... P(t, T_beta) 
    tau_arr, array of year fractions tau(T_alpha, T_(alpha+1)) ... tau(T_(beta-1), T_beta)
    """
    @assert length(P_arr) == length(tau_arr) + 1
    P_tTalpha = P_arr[begin]
    P_tTbeta = P_arr[end]
    den = sum(P_arr[2:end] .* tau_arr)
    num = P_tTalpha - P_tTbeta
    return num/den    
end





