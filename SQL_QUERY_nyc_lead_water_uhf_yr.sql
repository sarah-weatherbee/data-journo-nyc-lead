/* nyc water resident submitted lead sample testing data analytics grouped by uhf neighborhood name and year.
Via 'UHF_code NOT IN ("#N/A", "999")' the query excludes zip codes that have no corresponding
UHF code (#N/A); also excludes test rows I added UHF code (#999).
Data from
nycopendata: https://data.cityofnewyork.us/Environment/Free-Residential-at-the-tap-Lead-and-Copper-Data/k5us-nav4/data */

select
  Year_Coll,
  count(distinct(Kit_ID)) as num_samples,
  Borough_broad,
  UHF_code as neighb_code,
  Neighb_Name,
  0.015 as epa_pb_lim,
  /*lead first draw calcs*/
  100 * sum(
    case
      when Lead_First_Draw_mg_L > 0.015 then 1
      else 0
    end
  ) / count(distinct(Kit_ID)) as pct_1d_pb_over_epa,
  MAX(Lead_First_Draw_mg_L) as max_1d_pb,
  MIN(Lead_First_Draw_mg_L) as min_1d_pb,
  AVG(Lead_First_Draw_mg_L) as avg_1d_pb,
  statistics_median(cast(Lead_First_Draw_mg_L as float)) as med_1d_pb,
  MAX(Lead_First_Draw_mg_L) - MIN(Lead_First_Draw_mg_L) as range_1d_pb,
  statistics_median(cast(Lead_First_Draw_mg_L as float)) - 0.015 as med_1d_pb_diff_epa,
  AVG(Lead_First_Draw_mg_L) - 0.015 as avg_1d_pb_diff_epa,
  /*lead 1-2 min flush calcs*/
  100 * sum(
    case
      when Lead_1_2_Min_Flush_mg_L > 0.015 then 1
      else 0
    end
  ) / count(distinct(Kit_ID)) as pct_2d_pb_over_epa,
  MAX(Lead_1_2_Min_Flush_mg_L) as max_2d_pb,
  MIN(Lead_1_2_Min_Flush_mg_L) as min_2d_pb,
  AVG(Lead_1_2_Min_Flush_mg_L) as avg_2d_pb,
  statistics_median(cast(Lead_1_2_Min_Flush_mg_L as float)) as med_2d_pb,
  MAX(Lead_1_2_Min_Flush_mg_L) - MIN(Lead_1_2_Min_Flush_mg_L) as range_2d_pb,
  statistics_median(cast(Lead_1_2_Min_Flush_mg_L as float)) - 0.015 as med_2d_pb_diff_epa,
  AVG(Lead_1_2_Min_Flush_mg_L) - 0.015 as avg_2d_pb_diff_epa
from
  SOURCE_NYC_lead_levels
where
  UHF_code NOT IN ("#N/A", "999")
group by
  Neighb_Name,
  Year_Coll
order by
  Neighb_Name,
  Year_Coll,
  AVG(Lead_First_Draw_mg_L)