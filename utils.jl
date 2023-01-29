using Dates

function dcc_act365(date1::Date, date2::Date)
    return (date2 - date1).value / 365    
end

function dcc_act360(date1::Date, date2::Date)
    return (date2 - date1).value / 360    
end

function dcc_30365(date1::Date, date2::Date)
    d1 = Dates.day(date1)
    d2 = Dates.day(date2)
    m1 = Dates.month(date1)
    m2 = Dates.month(date2)
    y1 = Dates.year(date1)
    y2 = Dates.year(date2)
    num = max(30 - d1, 0) + min(d2, 30) + 360*(y2-y1) + 30*(m2-m1-1)
    return num/360   
end

