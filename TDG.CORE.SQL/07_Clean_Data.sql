UPDATE [dbo].[04_ACCOUNT]
SET address1_postalcode = REPLACE(address1_postalcode, ' ', ''),
	address1_country = 'Canada',
	address1_line1 = TRIM(address1_line1),
	address1_latitude  = CASE WHEN address1_latitude IS NULL OR address1_latitude = 0.00000 THEN NULL ELSE address1_latitude END,
	address1_longitude = CASE WHEN address1_longitude IS NULL OR address1_longitude = 0.00000 THEN NULL ELSE address1_longitude END;