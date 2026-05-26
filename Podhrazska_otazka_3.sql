-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
--kroky: 
--1.Spočítá se průměrná cena každé potraviny za jednotlivé roky.
--2.Pomocí LAG() se ke každému roku doplní cena z předchozího roku.
--3.Vypočítá se meziroční procentuální růst ceny:
--4.Pro každou potravinu se spočítá průměrný meziroční růst.
--5.Výsledky se seřadí od nejnižšího růstu a vybere se 10 nejpomaleji zdražujících potravin.

WITH price_years AS (
    -- průměrná cena za rok a potravinu
    SELECT
        food_name,
        year,
        ROUND(AVG(average_food_price)::numeric, 2) AS avg_price
    FROM t_michaela_podhrazska_project_sql_primary_final
    GROUP BY food_name, year
),

price_with_lag AS (
    -- cena z předchozího roku
    SELECT
        food_name,
        year,
        avg_price,
        LAG(avg_price) OVER (
            PARTITION BY food_name
            ORDER BY year
        ) AS prev_year_price
    FROM price_years
),

price_growth AS (
    -- výpočet meziročního růstu v %
    SELECT
        food_name,
        year,
        ROUND(
            ((avg_price - prev_year_price) / prev_year_price) * 100, --Kolik procent se cena změnila oproti předchozímu roku
            2
        ) AS pct_growth
    FROM price_with_lag
    WHERE prev_year_price IS NOT NULL
)

-- výběr potraviny s nejpomalejším růstem
SELECT
    food_name,
    ROUND(AVG(pct_growth)::numeric, 2) AS avg_yearly_growth
FROM price_growth
GROUP BY food_name
ORDER BY avg_yearly_growth ASC
LIMIT 10;

--výsledek: cukr krystalový měl největší deflaci pro dané roky