# 4.-Projekt-Engeto
Cílem projektu bylo zodpovědět 5 výzkumných otázek týkající se dostupnosti základních potravin u široké veřejnosti. 
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

Vychází se ze dvou tabulek: primární tabulka t_michaela_podhrazska_project_SQL_primary_final je vytvořena v souboru Podhrazska_1.sql. Sekundární tabulka t_michaela_poodhrazska_project_SQL_secondary_final je vytvořena v souboru Podhrazska_2.sql.  

ODPOVĚDI NA VÝZKUMNÉ OTÁZKY
## 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Data jsou uložena v souboru Podhrazska_otazka_1.sql. Ve výsledné tabulce si lze vyfiltrovat dané odvětví a vpravo ve sloupci „trend“ vidíme, jestli odvětví oproti předchozímu roku rostlo „growth“, anebo „drop“ klesalo. 
Průměrná hrubá mzda v Kč v letech 2006 – 2018 ROSTLA pro odvětví: 
- administrativní a podpůrné činnosti, 
- doprava a skladování, 
- ostatní činnosti, 
- zdravotní a sociální péče, 
- zpracovatelský průmysl. 
V ostatních odvětvích došlo vždy minimálně k jednomu zakolísání v průběhu daných let.

## 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
Data jsou uložena v souboru Podhrazska_otazka_2.sql.
- 2006	Chléb konzumní kmínový	- 	1261.93 Kg;
- 2018	Chléb konzumní kmínový	- 	1319.32 Kg;
- 2006	Mléko polotučné pasterované	-	1408.75 Litru;
- 2018	Mléko polotučné pasterované	- 	1613.53 Litru

## 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
Data jsou uložena v souboru Podhrazska_otazka_3.sql.
Z dat bylo vyfiltrováno 10 potravin. 
- Cukr krystalový	-1.92
- Rajská jablka červená kulatá	-0.74
- Banány žluté	0.81
- Vepřová pečeně s kostí	0.99
- Přírodní minerální voda uhličitá	1.02
- Šunkový salám	1.86
- Jablka konzumní	2.01
- Pečivo pšeničné bílé	2.20
- Hovězí maso zadní bez kosti	2.54
- Kapr živý	2.60

Z dat lze vyčíst, že cukr krystalový měl největší deflaci pro dané roky. Druhá potravina s deflací byly rajská jablka. Ostatní potraviny v tabulce už zdražují (inflací). 

## 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
Data jsou uložena v souboru Podhrazska_otazka_4.sql.
V žádném roce (2007-2018) nedošlo ke zvýšení o více než 10%.  
- 2007	6.74	6.79	-0.05	NO
- 2008	6.19	8.06	-1.87	NO
- 2009	-6.41	3.25	-9.66	NO
- 2010	1.95	2.00	-0.05	NO
- 2011	3.35	2.27	1.08	NO
- 2012	6.72	3.14	3.58	NO
- 2013	5.10	-1.56	6.66	NO
- 2014	0.74	2.54	-1.80	NO
- 2015	-0.54	2.42	-2.96	NO
- 2016	-1.21	3.66	-4.87	NO
- 2017	9.63	6.40	3.23	NO
- 2018	2.16	7.55	-5.39	NO

## 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
Data jsou uložena v souboru Podhrazska_otazka_5.sql.
Výstupem tohoto SQL dotazu je tabulka, která ukazuje:
- meziroční procentní změnu HDP, 
- meziroční procentní změnu mezd, 
- meziroční procentní změnu cen potravin. 
Pro každý rok je vidět, o kolik procent se hodnoty změnily oproti předchozímu roku.

Z analýzy vyplývá, že růst HDP měl ve většině případů pozitivní vliv na růst mezd. Mzdy během sledovaného období převážně rostly i v letech, kdy ekonomický růst zpomalil nebo došlo k poklesu HDP. Naopak ceny potravin vykazovaly výraznější výkyvy a jejich vývoj nebyl na růstu HDP přímo závislý. Nejvýraznější dopad ekonomické krize byl patrný v roce 2009, kdy došlo k výraznému poklesu HDP i cen potravin.






















