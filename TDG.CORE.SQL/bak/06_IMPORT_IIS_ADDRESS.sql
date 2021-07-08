UPDATE [04_ACCOUNT]
SET 
--,name = T2.OPERATING_NAME,
ovs_legalname = T2.LEGAL_NAME,
ovs_accountnameenglish = T2.OPERATING_NAME,
address1_primarycontactname = T2.USER_CONTACT,
address1_telephone1 = T2.CONTACT_TFH,
address1_latitude = CASE WHEN ISNUMERIC(T2.LATITUDE_DEGREE_NBR) = 1 THEN CAST(T2.LATITUDE_DEGREE_NBR AS DECIMAL(38, 5)) ELSE NULL END,
address1_longitude = CASE WHEN ISNUMERIC(T2.LONGITUDE_DEGREE_NBR) = 1 THEN CAST(T2.LONGITUDE_DEGREE_NBR AS DECIMAL(38, 5)) ELSE NULL END,
address1_city  = TRIM(T2.CITY_TOWN_NAME_NM),
address1_country = TRIM(T2.COUNTRY),
address1_postalcode = TRIM(T2.POSTAL_CODE_TXT),
address1_stateorprovince = TRIM(T2.COUNTRY_SUBDIVISION_CD),
address1_line3 = TRIM(POBOX),
address1_postofficebox = TRIM(POBOX),

address1_line1 = 
CASE
	WHEN TRIM(T2.STREET) IS NULL OR TRIM(T2.STREET) = '' THEN
		address1_line1
	ELSE
		TRIM(T2.STREET)
END

FROM [04_ACCOUNT] T1
JOIN 
(
		SELECT 
		--IIS Number
		IIS.STAKEHOLDER_ID,

		--Legal Name
		--DATA MIGRATION RULES:
		--If Legal name doesn't exist in IIS, then include make the Legal Name "Legal Name was not on file in IIS, please confirm Legal Name".
		--BUSINESS REASON: This is what is used on the Inspection Report and Tickets and other official documents
		CASE 
		WHEN IIS.LEGAL_NAME_ENM IS NULL THEN 'Legal Name was not on file in IIS, please confirm Legal Name'
		ELSE TRIM(IIS.LEGAL_NAME_ENM)
		END LEGAL_NAME,

		--Operating Name
		--DATA MIGRATION RULES:
		--If Operating Name doesn't exist in IIS, then use the Legal Name in IIS for the Operating Name.
		--BUSINESS REASON: This is required so that you know the name of the company you are looking for by name.
		CASE 
		WHEN IIS.OPERATING_NAME_ENM IS NULL THEN IIS.LEGAL_NAME_ENM
		ELSE TRIM(IIS.OPERATING_NAME_ENM)
		END OPERATING_NAME,

		--Address 1 - Out of the box fields in ROM; Concept of "Civic General Address" in IIS
		--DATA MIGRATION RULE FOR ALL ADDRESS FIELDS
		--If the "Civic General Address" within the address from Address Type = "Civic" is blank, then use the Address Type = "Physical" to then fill in all the fields for the address

		--Street 1
		--DATA MIGRATION RULES:
		--Use the "Civic General Address" from IIS for this field for Address Type Civic. into this field.
		--If this field is blank in IIS, leave this field blank in ROM.
		IIS.PHYS_STREET_NUMBER_NUM,
		IIS.PHYS_STREET_NAME_NM,
		IIS.STREET_NUMBER_NUM,
		IIS.STREET_NAME_NM,

		CASE
			WHEN STREET_NAME_NM IS NULL AND (PHYS_STREET_NAME_NM IS NULL OR TRIM(PHYS_STREET_NAME_NM) = '') THEN 
				NULL
			WHEN (STREET_NAME_NM IS NULL OR TRIM(STREET_NAME_NM) = '0') AND PHYS_STREET_NAME_NM IS NOT NULL THEN
				CONCAT(IIS.PHYS_STREET_NUMBER_NUM, ' ', IIS.PHYS_STREET_NAME_NM)
			ELSE 
				CONCAT(IIS.STREET_NUMBER_NUM, ' ', STREET_NAME_NM)
		END STREET,

		--City
		--DATA MIGRATION RULES:
		--Migrate the IIS "City Town Name" for Address Type Civic. into this field
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'PHYSICAL' THEN IIS.PHYS_CITY_TOWN_NAME_NM
			ELSE IIS.CITY_TOWN_NAME_NM
		END CITY_TOWN_NAME_NM,

		--Province
		--DATA MIGRATION RULES:
		--Migrate the IIS "Country Sub Divsiion Code" for Address Type Civic. into this field
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'PHYSICAL' THEN IIS.PHYS_COUNTRY_SUBDIVISION_CD
			ELSE IIS.COUNTRY_SUBDIVISION_CD
		END COUNTRY_SUBDIVISION_CD,

		--Postal Code
		--DATA MIGRATION RULES:
		--Migrate the IIS "Postal Code" for Address Type Civic. into this field
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'PHYSICAL' THEN IIS.PHYS_POSTAL_CODE_TXT
			ELSE IIS.POSTAL_CODE_TXT
		END POSTAL_CODE_TXT,

		--Country
		--DATA MIGRATION RULES:
		--Migrate the IIS "Country" for Address Type Civic. into this field
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN 'Canada'
			WHEN IIS.[PHYS_COUNTRY_CD] IS NULL THEN 'Canada'
			ELSE IIS.[PHYS_COUNTRY_ENM]
		END COUNTRY,

		--Lat / Long
		--DATA MIGRATION RULES:
		--Migrate the IIS "Lat Long" for Address Type Civic. into this field
		--If this field is currently blank in IIS, leave it blank in ROM.
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.[LATITUDE_DEGREE_NBR]
			ELSE IIS.[PHYS_LATITUDE_DEGREE_NBR]
		END LATITUDE_DEGREE_NBR,

		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.LATITUDE_MINUTE_NBR
			ELSE IIS.[PHYS_LATITUDE_MINUTE_NBR]
		END LATITUDE_MINUTE_NBR,
		
		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.LONGITUDE_DEGREE_NBR
			ELSE IIS.[PHYS_LONGITUDE_DEGREE_NBR]
		END LONGITUDE_DEGREE_NBR,

		CASE
			WHEN ADDRESS_TYPE.[TYPE] = 'CIVIC' THEN IIS.LONGITUDE_MINUTE_NBR
			ELSE IIS.[PHYS_LONGITUDE_MINUTE_NBR]
		END LONGITUDE_MINUTE_NBR,

		--Street 3
		--DATA MIGRATION RULES:
		--Use the "PO Box" field from IIS for this field.
		--If this field is blank in IIS, leave this field blank in ROM.
		CASE
			WHEN IIS.UNIT_SUITE_NUM = 'P.O. Box' OR IIS.UNIT_SUITE_NUM = 'PO' THEN
				CONCAT('P.O. Box', ' ', STREET_NUMBER_NUM)
			WHEN IIS.UNIT_SUITE_NUM = 'RR' OR IIS.UNIT_SUITE_NUM = 'SS' THEN 
				CONCAT(IIS.UNIT_SUITE_NUM, ' ', STREET_NUMBER_NUM)
			ELSE 
				NULL
		END POBOX,

		--Phone
		--Out of the box field.
		--DATA MIGRATION RULES:
		--There is no field that needs to be migrated from IIS.
		IIS.CONTACT_PHONE,
		IIS.CONTACT_BUSINESS_PHONE,
		IIS.CONTACT_EMAIL,
		IIS.CONTACT_TFH,
		IIS.USER_CONTACT
		--Fax
		--Out of the box field.
		--DATA MIGRATION RULES:
		--There is no field that needs to be migrated from IIS.

		, ADDRESS_TYPE.[TYPE]
		FROM [03_SITES] SITES
		JOIN [10_IIS_EXPORT] IIS ON SITES.IIS_ID = IIS.STAKEHOLDER_ID
		JOIN (
			SELECT
			STAKEHOLDER_ID,
			CASE
				WHEN	(STREET_NUMBER_NUM IS NULL		OR TRIM(STREET_NUMBER_NUM) = '')		AND 
						(STREET_NAME_NM IS NULL			OR TRIM (STREET_NAME_NM) = '')			AND 
						(CITY_TOWN_NAME_NM IS NULL		OR TRIM(CITY_TOWN_NAME_NM) = '')		AND 
						(COUNTRY_SUBDIVISION_CD IS NULL OR TRIM(COUNTRY_SUBDIVISION_CD) = '')	AND 
						(POSTAL_CODE_TXT IS NULL		OR TRIM(POSTAL_CODE_TXT) = '') THEN
						'PHYSICAL'
				ELSE
					'CIVIC'
			END [TYPE]
			FROM [10_IIS_EXPORT]
		) ADDRESS_TYPE ON IIS.STAKEHOLDER_ID = ADDRESS_TYPE.STAKEHOLDER_ID
) T2

ON T1.ovs_iisid = T2.STAKEHOLDER_ID;


--MOC Registration Number
--Required to be migrated from IIS.  This field will be required for linking to FDR.
--get this field from the workplan uploads
UPDATE [04_ACCOUNT]
SET 
	ovs_mocid = T2.MOC_ID
FROM [04_ACCOUNT] T1
JOIN 
(
	SELECT DISTINCT SITES.IIS_ID, WORKPLANS.MOC_ID
	FROM [03_SITES] SITES
	JOIN [dbo].[09_WORKPLAN_IMPORT] WORKPLANS ON CAST(SITES.IIS_ID as varchar(10)) = WORKPLANS.IIS_ID
	WHERE MOC_ID IS NOT NULL and MOC_ID <> ''
) T2 
ON T1.ovs_iisid = T2.IIS_ID;


--View accounts linked to Sites
--SELECT *  
--FROM [04_ACCOUNT] T1
--JOIN [03_SITES] T2 ON T1.ovs_iisid = T2.IIS_ID;


--SITE OPERATING PROFILE TAGS:
--The following are all characteristics of a site that will be used to build / filter the questionnaire.

--During Data Migration the expectation is that these tags will be extracted / translated from the existing data in IIS and imported into ROM.

--Means of Containment
--DATA MIGRATION RULES:
--Migrate the 
--Means of Containment Facility Type
--DATA MIGRATION RULES:

--Mode
--DATA MIGRATION RULES:
--This field is in IIS as "Mode".  It is check boxes in IIS.
--Migrate the value from IIS to Mode.
--This is a Mandatory field.
--Valid Values
--Rail 
--Road
--Air
--Marine
--The field name remains as "Mode".
--This is a tag that will be associated with a site.  It will need to be in the Site Operating Profile section; these values are used to build / filter the questionnaire.
--Multiple values for Mode can be selected
