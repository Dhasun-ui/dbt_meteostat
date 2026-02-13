WITH airport_and_flight_details AS (

SELECT  PF.ORIGIN AS origin_airport,
        PF.dest AS destination_airport,
        COUNT(DISTINCT tail_number) AS unique_airplanes,
        COUNT(DISTINCT airline) AS unique_airlines,
        count(PF.DIVERTED ) AS total_number_OF_diverted_flights,
        round (AVG(actual_elapsed_time),2) AS Avg_actual_elapsed_time_for_flights,
        round (AVG(arr_delay),2 ) AS Avg_delay_on_arrival,
        MAX(dep_delay) AS max_delay,
        MIN(dep_delay) AS min_delay
        FROM {{ ref('prep_flights') }} PF 
        GROUP BY PF.origin, PF.dest 
)

SELECT ap.city,
       ap.country,
       a.*
FROM airport_and_flight_details a 
JOIN {{ ref('prep_airports') }} ap 
ON a.origin_airport = ap.faa