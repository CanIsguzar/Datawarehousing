SELECT EMPLOYEE_ID, (FIRSTNAME + ' ' + LASTNAME), EXPRESS
FROM SAT_EMPLOYEE;


SELECT s.WEATHER_ID, mist, rain, snow, thunder, ice
FROM SAT_WEATHER s
INNER JOIN HUB_WEATHER h ON (s.WEATHER_ID = h.WEATHER_ID);

SELECT * FROM hub_parcel

DROP VIEW consignment_fact;
go
CREATE VIEW consignment_fact AS
SELECT sc.SCHED_PICKUP_TIME, sum(price) as price, count(hc.consignment_id) as aantal, lpe.employee_id, mist, rain, snow, thunder, ice, (FIRSTNAME + ' ' + LASTNAME) as name, EXPRESS
FROM sat_consignment sc
INNER JOIN hub_consignment hc ON (sc.consignment_id = hc.consignment_id)
INNER JOIN LINK_PARCEL_CONSIGNMENT lpc ON (hc.consignment_id = lpc.consignment_id)
INNER JOIN hub_parcel hp ON (hp.parcel_id = lpc.parcel_id)
INNER JOIN sat_parcel sp ON (sp.parcel_id = hp.parcel_id)
INNER JOIN link_parcel_employee lpe ON (lpe.parcel_id = hp.parcel_id)
INNER JOIN sat_employee se ON (se.employee_id = lpe.employee_id)
INNER JOIN link_consignment_weather lcw ON (lcw.consignment_id = hc.consignment_id)
INNER JOIN sat_weather sw ON (lcw.weather_id = sw.weather_id)
GROUP BY sc.SCHED_PICKUP_TIME, lpe.employee_id, mist, rain, snow, thunder, ice, (FIRSTNAME + ' ' + LASTNAME), EXPRESS;
go
SELECT * FROM consignment_fact;

DROP VIEW personeel_dim;
go
CREATE VIEW personeel_dim AS
SELECT EMPLOYEE_ID, (FIRSTNAME + ' ' + LASTNAME) as NAME, EXPRESS
FROM SAT_EMPLOYEE;
go

SELECT * FROM personeel_dim; 


