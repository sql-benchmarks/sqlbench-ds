-- SQLBench-DS query 34 derived from TPC-DS query 34 under the terms of the TPC Fair Use Policy.
-- TPC-DS queries are Copyright 2021 Transaction Processing Performance Council.
-- This query was generated at scale factor 3000.
select c_last_name
       ,c_first_name
       ,c_salutation
       ,c_preferred_cust_flag
       ,ss_ticket_number
       ,cnt from
   (select ss_ticket_number
          ,ss_customer_sk
          ,count(*) cnt
    from store_sales,date_dim,store,household_demographics
    where store_sales.ss_sold_date_sk = date_dim.d_date_sk
    and store_sales.ss_store_sk = store.s_store_sk  
    and store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
    and (date_dim.d_dom between 1 and 3 or date_dim.d_dom between 25 and 28)
    and (household_demographics.hd_buy_potential = '501-1000' or
         household_demographics.hd_buy_potential = '5001-10000')
    and household_demographics.hd_vehicle_count > 0
    and (case when household_demographics.hd_vehicle_count > 0 
	then household_demographics.hd_dep_count/ household_demographics.hd_vehicle_count 
	else null 
	end)  > 1.2
    and date_dim.d_year in (2000,2000+1,2000+2)
    and store.s_county in ('Sumner County','Gage County','Bronx County','Salem County',
                           'Perry County','San Miguel County','Hubbard County','Pennington County')
    group by ss_ticket_number,ss_customer_sk) dn,customer
    where ss_customer_sk = c_customer_sk
      and cnt between 15 and 20
    order by c_last_name,c_first_name,c_salutation,c_preferred_cust_flag desc, ss_ticket_number;

