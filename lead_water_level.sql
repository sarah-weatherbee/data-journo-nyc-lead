select
  Year_Collected,
  Borough,
  samples,
  [population 2019] as pop_2019,
  [households 2015-2019] as num_households,
  [percent of children under 5] as pct_under_5,
  round(
    cast(samples as float) / cast(
      replace([households 2015-2019], ',', '') as float
    ),
    4
  ) * 100 as 'pct_samples'
from
  (
    select
      [Year Collected] as year_collected,
      Borough_broad as Borough,
      count([Kit ID]) as samples
    from
      nyc_lead_water
    where
      Borough_broad is not "#N/A"
    group by
      [Year Collected],
      Borough_broad
    order by
      year_collected,
      count([Kit ID]) desc
  )
  LEFT JOIN NYC_borough_pop USING(Borough)
group by
  Borough,
  year_collected
order by
  Borough,
  year_collected,
  pct_samples desc;