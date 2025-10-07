select distinct geolocation_state
from wsl.geolocation
where geolocation_lat  = 0.0
order by geolocation_state


select* --distinct geolocation_state,geolocation_city,geolocation_lat,geolocation_lng
from wsl.geolocation
order by geolocation_state

where geolocation_lng  = 0.0


--clean 0.0 value for lat an lng

UPDATE wsl.geolocation
SET 
    geolocation_lat = CASE geolocation_state
        WHEN 'AC' THEN -9.97499
        WHEN 'AL' THEN -9.57131
        WHEN 'AP' THEN 1.413
        WHEN 'AM' THEN -3.41684
        WHEN 'BA' THEN -12.57974
        WHEN 'CE' THEN -5.4984
        WHEN 'DF' THEN -15.77972
        WHEN 'ES' THEN -19.1834
        WHEN 'GO' THEN -15.82704
        WHEN 'MA' THEN -4.9609
        WHEN 'MT' THEN -12.6819
        WHEN 'MS' THEN -20.7722
        WHEN 'MG' THEN -18.5122
        WHEN 'PA' THEN -3.4168
        WHEN 'PB' THEN -7.24
        WHEN 'PR' THEN -24.89
        WHEN 'PE' THEN -8.8137
        WHEN 'PI' THEN -7.7183
        WHEN 'RJ' THEN -22.9068
        WHEN 'RN' THEN -5.7945
        WHEN 'RS' THEN -30.0346
        WHEN 'RO' THEN -11.5057
        WHEN 'RR' THEN 2.7376
        WHEN 'SC' THEN -27.5954
        WHEN 'SP' THEN -23.5505
        WHEN 'SE' THEN -10.5741
        WHEN 'TO' THEN -10.1753
        ELSE geolocation_lat
    END,
    
    geolocation_lng = CASE geolocation_state
        WHEN 'AC' THEN -67.80757
        WHEN 'AL' THEN -36.782
        WHEN 'AP' THEN -51.77
        WHEN 'AM' THEN -65.85608
        WHEN 'BA' THEN -41.70073
        WHEN 'CE' THEN -39.3206
        WHEN 'DF' THEN -47.92972
        WHEN 'ES' THEN -40.3089
        WHEN 'GO' THEN -49.83622
        WHEN 'MA' THEN -45.2744
        WHEN 'MT' THEN -56.9211
        WHEN 'MS' THEN -54.7852
        WHEN 'MG' THEN -44.555
        WHEN 'PA' THEN -52.0836
        WHEN 'PB' THEN -36.782
        WHEN 'PR' THEN -51.55
        WHEN 'PE' THEN -36.9541
        WHEN 'PI' THEN -42.7289
        WHEN 'RJ' THEN -43.1729
        WHEN 'RN' THEN -36.5986
        WHEN 'RS' THEN -51.2177
        WHEN 'RO' THEN -63.5806
        WHEN 'RR' THEN -62.0751
        WHEN 'SC' THEN -48.548
        WHEN 'SP' THEN -46.6333
        WHEN 'SE' THEN -37.3857
        WHEN 'TO' THEN -48.2982
        ELSE geolocation_lng
    END
WHERE geolocation_lat = 0.0 AND geolocation_lng = 0.0;
