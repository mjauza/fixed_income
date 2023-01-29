
function FRA(N::Number, P_tS::Number, tau_TS::Number, K::Number, F_tTS::Number)
    """
    Value of FRA at time t, for FRA duation T,S with strike rate K
    N::Number, notional
    P_tS::Number, P(t,S) zcb
    tau_TS::Number,  tau(T,S) year fraction
    K::Number, strike rate of FRA
    F_tTS::Number, forward rate at t F(t, T, S)
    """
    return N*P_tS*tau_TS*(K - F_tTS)
end

function receiver_IRS(N::Number, K::Number, P_tTalpha::Number, P_tTbeta::Number, tau_arr, P_tTi_arr)
    """
    Receiver Interest Rate Swap value
    CFs are at times T_(alpha + 1), ... T_beta
    N::Number  notional 
    K::Number  swap strike rate (ie. fixed rate)
    P_tTalpha::Number P(t,T_alpha) 
    P_tTbeta::Number, P(t,T_beta)
    tau_arr, array, year fractions CF times of tau(T_(alpha + 1), T_(alpha + 2)) ... tau(T_(beta - 1), T_beta)
    P_tTi_arr array of zcb prices P(t, T_(alpha + 1)) ... P(t, T_beta)
    """
    @assert length(tau_arr) == length(P_tTi_arr)
    return -N*P_tTalpha + N*P_tTbeta + N*K*sum(tau_arr .* P_tTi_arr)
end

