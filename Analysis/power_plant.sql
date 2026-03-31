select top 10 *
from power_plants_raw

/*================================================================
Data Cleaning
==================================================================*/

--1. Data Validation
select
	country,
	country_long,
	name,

	--convert capacity to number
	try_cast (capacity_mw as float) as capacity_mw,

	-- convert coordinates
	try_cast (latitude as float) as latitude,
	try_cast(longitude as float) as longitude,

	primary_fuel,

	-- convert year
	try_cast(commissioning_year as int) as commisioning_year,

	owner

into clean_power_plants

from power_plants_raw

--2. Check Nulls

select 
	count (*) as total_rows,
	(select count(capacity_mw) as non_null_capacity
	from power_plants_clean
	where capacity_mw is not null) as non_null_capacity

from power_plants_clean

select 
    count(*) as total_rows,
    count(capacity_mw) as non_null_capacity,
    count(*) - count(capacity_mw) as null_capacity
from power_plants_clean;

select count(*) as zero_capacity
from power_plants_clean
where capacity_mw = 0;


/*================================================================
Analysis
==================================================================*/

--1.a) Classify energy types

select primary_fuel
into power_plants_clean
from power_plants_raw

select primary_fuel,
	count(*) as total_count,
	round(sum(capacity_mw),0) as total_capacity

from power_plants_clean
group by primary_fuel 
order by total_capacity desc

--1.b) Renewable/Non-Renewable segmentation

select 
	case
		when primary_fuel in ('Solar', 'Hydro', 'Wind', 'Biomass','Geothermal','wave and Tidal')
			then 'Renewable'
		else 'Non-Renewable'
		end as energy_type,
	
	round(avg(capacity_mw),0) as avg_capacity,

	format(round(sum(capacity_mw),0),'N0') as total_capacity

from power_plants_clean
group by case
		when primary_fuel in ('Solar', 'Hydro', 'Wind', 'Biomass','Geothermal','wave and Tidal')
			then 'Renewable'
		else 'Non-Renewable'
		end;

--ENERGY TYPE PERCENTAGE

SELECT 
    energy_type,
    format(round(total_capacity, 0), 'N0') as total_capacity,
    round(total_capacity * 100.0 / sum(total_capacity)over(),2) as percentage
from (
    select 
        case 
            when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
                then 'Renewable'
            else 'Non-Renewable'
        end as energy_type,

        sum(capacity_mw) as total_capacity

    from clean_power_plants
    group by 
        case 
            when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
                then 'Renewable'
            else 'Non-Renewable'
        end
)t;

/*========================================
2.a) Top Countries by Capacity
==========================================*/

select *
from power_plants_clean

select
	country_long,
	round(sum(capacity_mw),0) as total_capacity

from power_plants_clean
group by country_long 
order by total_capacity desc

--Top 10 Countries
select top 10
	country_long,
	round(sum(capacity_mw),0) as total_capacity

from power_plants_clean
group by country_long 
order by total_capacity desc

/*=========================================
2.b) RENEWABLE vs NON-RENEWABLES by COUNTRY
=========================================*/

select
	country,

	case 
		when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
			then 'Renewable'
        else 'Non-Renewable'
    end as energy_type,
	
	sum(capacity_mw) as total_capacity

from power_plants_clean

group by
	country,
	case 
		when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
			then 'Renewable'
        else 'Non-Renewable'
    end;

--% Per Country
select
	country,
	energy_type,
	total_capacity,

	round(total_capacity*100/sum(total_capacity)over(partition by country),2) as percentage

from (
	select
		country,
		case 
			when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
				then 'Renewable'
			else 'Non-Renewable'
		end as energy_type,
	
		sum(capacity_mw) as total_capacity

	from power_plants_clean

	group by
		country,
		 case 
			when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
				then 'Renewable'
			else 'Non-Renewable'
		end
	)t;


	--STRONGEST RENEWABLE COUNTRIES

select *

from (
	select
		country,
		energy_type,
		total_capacity,

		round(total_capacity*100/sum(total_capacity)over(partition by country),2) as percentage

	from (
		select
			country,
			case 
				when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
					then 'Renewable'
				else 'Non-Renewable'
			end as energy_type,
	
			sum(capacity_mw) as total_capacity

		from power_plants_clean

		group by
			country,
			case 
				when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
					then 'Renewable'
				else 'Non-Renewable'
			end
		)t
)x
where energy_type = 'Renewable'
	and percentage >70
	and total_capacity > 10000
order by percentage desc;


/*==================================
3. Growth Trends
====================================*/

select 
	[commisioning_year],
	case 
		when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
			then 'Renewable'
			else 'Non-Renewable'
		end as energy_type,
	count (*) as number_of_plants

from power_plants_clean

where [commisioning_year] is not null
	and [commisioning_year] >= 2000

group by 
	[commisioning_year],
	case 
		when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
			then 'Renewable'
			else 'Non-Renewable'
		end

order by [commisioning_year] desc

	

	select 
    case
        when primary_fuel IN ('Solar','Hydro','Wind','Biomass','Geothermal','Wave and Tidal')
            then 'Renewable'
        else 'Non-Renewable'
    end as energy_type,
    sum(capacity_mw) as total_capacity
from power_plants_clean
group by 
    case 
        when primary_fuel IN ('Solar','Hydro','Wind','Biomass','Geothermal','Wave and Tidal')
            then 'Renewable'
        else 'Non-Renewable'
    end;

select 
    energy_type,
    round(total_capacity,0) as total_capacity,
    round(total_capacity * 100.0 / sum(total_capacity) over(), 0) as percentage
from (
    select 
        case 
            when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
                then 'Renewable'
            else 'Non-Renewable'
        end as energy_type,
        sum(capacity_mw) as total_capacity
    from power_plants_clean
    group by 
        case 
            when primary_fuel IN ('Solar', 'Hydro', 'Wind', 'Biomass', 'Geothermal', 'Wave and Tidal')
                then 'Renewable'
            else 'Non-Renewable'
        end
) t;


