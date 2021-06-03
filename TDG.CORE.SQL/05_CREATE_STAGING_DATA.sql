--DEFAULT MASTER DATA
BEGIN

	--============================================STATIC VALUES==========================================
	--OVERSIGHT TYPES
	DECLARE @CONST_OVERSIGHTTYPE_GCTARGETED              VARCHAR(50) = '72afccd3-269e-eb11-b1ac-000d3ae924d1';
	DECLARE @CONST_OVERSIGHTTYPE_GCIPT                   VARCHAR(50) = '50D0BDF1-269E-EB11-B1AC-000D3AE924D1';
	DECLARE @CONST_OVERSIGHTTYPE_MOCTARGETED             VARCHAR(50) = '864BAA27-279E-EB11-B1AC-000D3AE924D1';
	DECLARE @CONST_OVERSIGHTTYPE_GCCONSIGNMENT           VARCHAR(50) = '460B6C2A-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_MOCOPPORTUNITY          VARCHAR(50) = 'F6A0B96E-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_CIVDOCREVIEW            VARCHAR(50) = 'A4965081-5F9C-EB11-B1AC-000D3AE92708';
	DECLARE @CONST_OVERSIGHTTYPE_GC_CEP                  VARCHAR(50) = 'abf3c4d9-269e-eb11-b1ac-000d3ae924d1';
	DECLARE @CONST_OVERSIGHTTYPE_GC_FOLLOWUP             VARCHAR(50) = '1cd7bd09-279e-eb11-b1ac-000d3ae924d1';
	DECLARE @CONST_OVERSIGHTTYPE_GC_TRIGGERED            VARCHAR(50) = '9dee7316-5f9c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_OVERSIGHTTYPE_GC_OPPORTUNITY          VARCHAR(50) = '07966e1c-5f9c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_OVERSIGHTTYPE_GC_UNDECLARED           VARCHAR(50) = '1cc06b3f-5f9c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_OVERSIGHTTYPE_MOC_FACILITY_IPT        VARCHAR(50) = 'e99ab21b-279e-eb11-b1ac-000d3ae924d1';
	DECLARE @CONST_OVERSIGHTTYPE_MOC_FACILITY_FOLLOWUP   VARCHAR(50) = 'c1e09a33-279e-eb11-b1ac-000d3ae924d1';
	DECLARE @CONST_OVERSIGHTTYPE_MOC_FACILITY_TRIGGERED  VARCHAR(50) = 'ea95bc68-5f9c-eb11-b1ac-000d3ae92708';

	--WORK ORDER TYPES
	DECLARE @CONST_WORKORDERTYPE_INSPECTION              VARCHAR(50) = 'b1ee680a-7cf7-ea11-a815-000d3af3a7a7';
	DECLARE @CONST_WORKORDERTYPE_REGULATORYAUTHORIZATION VARCHAR(50) = '46706c0a-ad60-eb11-a812-000d3ae9471c';

	--RATIONALS
	DECLARE @CONST_RATIONALE_PLANNED                     VARCHAR(50) = '994C3EC1-C104-EB11-A813-000D3AF3A7A7';
	DECLARE @CONST_RATIONALE_UNPLANNED                   VARCHAR(50) = '47F438C7-C104-EB11-A813-000D3AF3A7A7';

	--BOOKABLE RESOURCE CATEGORY
	DECLARE @CONST_CATEGORY_INSPECTOR                    VARCHAR(50) = '06DB6E56-01F9-EA11-A815-000D3AF3AC0D';

	--TDG CORE BOOKABLE RESOURCE
	--used as a default value in case inspectors are not able to be loaded or are not licensed in dynamics yet 
	DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID          VARCHAR(50) = '2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7';

	--TERRITORIES / REGIONS
	DECLARE @CONST_TERRITORY_HQ_ES                       VARCHAR(50) = '2e7b2f75-989c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_TERRITORY_HQ_CR                       VARCHAR(50) = '52c72783-989c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_TERRITORY_ATLANTIC                    VARCHAR(50) = 'FAB76E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_QUEBEC                      VARCHAR(50) = 'FCB76E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_PACIFIQUE                   VARCHAR(50) = 'FEB76E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_PNR                         VARCHAR(50) = '02B86E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_ONTARIO                     VARCHAR(50) = '50B21A84-DB04-EB11-A813-000D3AF3AC0D';

	DECLARE @CONST_WORKORDER_STATUS_CLOSED_POSTED		 VARCHAR(50) = '690970004';
	--===================================================================================================

	--=============================================DYNAMIC VALUES===========================================
	--these variables can change with the environment, so double check these match the environment you're syncing to
	--ROM-ACC-TDG-DATA VALUES
	DECLARE @CONST_TDGCORE_USERID                        VARCHAR(50) = 'ae39bb8b-4b92-eb11-b1ac-000d3ae85ba1';
	DECLARE @CONST_TDGCORE_DOMAINNAME                    VARCHAR(50) = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDG_TEAMID                            VARCHAR(50) = 'd5ddb27a-56b7-eb11-8236-000d3a84ec03';
	DECLARE @CONST_TDG_TEAMNAME                          VARCHAR(50) = 'Transportation of Dangerous Goods';
	DECLARE @CONST_TDG_BUSINESSUNITID                    VARCHAR(50) = '4E122E0C-73F3-EA11-A815-000D3AF3AC0D';
	DECLARE @CONST_PRICELISTID                           VARCHAR(50) = 'b92b6a16-7cf7-ea11-a815-000d3af3a7a7';

	--DEV
	-- DECLARE @CONST_TDGCORE_BOOKABLE_RESOURCE_ID       VARCHAR(50) = '2cfc9150-d6a3-eb11-b1ac-000d3ae8bee7';
	-- DECLARE @CONST_TDGCORE_USERID                     VARCHAR(50) = '15abdd9e-8edd-ea11-a814-000d3af3afe0';
	-- DECLARE @CONST_TDGCORE_DOMAINNAME                 VARCHAR(50) = 'tdg.core@034gc.onmicrosoft.com';
	-- DECLARE @CONST_TDG_TEAMID                         VARCHAR(50) = 'ed81d4e5-55b7-eb11-8236-0022483bc30f';
	-- DECLARE @CONST_TDG_TEAMNAME                       VARCHAR(50) = 'Transportation of Dangerous Goods';
	-- DECLARE @CONST_TDG_BUSINESSUNITID                 VARCHAR(50) = '4E122E0C-73F3-EA11-A815-000D3AF3AC0D';
	--===================================================================================================

	--===================================================================================================
	--CRM CONSTANTS
	DECLARE @CONST_OWNERIDTYPE_TEAM VARCHAR(50)			= 'team';
	DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER VARCHAR(50)	= 'systemuser';
	--===================================================================================================

END

--CONVERT EXCEL DATA TO REGULATED ENTITY RECORDS IN STAGING TABLE
--===================================================================================================
--===================================================================================================
INSERT INTO
  DBO.SOURCE__REGULATED_ENTITIES (
    [REGULATED_ENTITY_ID],
    [REGULATED_ENTITY_ID_SOURCE],
    IIS_ID,
    [REGULATED_ENTITY_NAME],
    [CONSOLIDATED_COMMON_ENGLISH_NAME],
    [CONSOLIDATED_COMMON_FRENCH_NAME]
  )
SELECT
  NEWID() [REGULATED_ENTITY_ID],
  REGENT.REGULATED_ENTITY_ID [REGULATED_ENTITY_ID_SOURCE],
  REGENT.MATCHING_ID [IIS_ID],
  TRIM(REGENT.REGULATED_ENTITY_NAME) [REGULATED_ENTITY_NAME],
  TRIM(REGENT.REGULATED_ENTITY_NAME) [CONSOLIDATED_COMMON_ENGLISH_NAME],
  TRIM(REGENT.REGULATED_ENTITY_NAME) [CONSOLIDATED_COMMON_ENGLISH_NAME]
FROM
  (
    SELECT
      REGULATED_ENTITY_ID,
      REGULATED_ENTITY_NAME,
      MATCHING_ID,
      COUNT(REGULATED_ENTITY_ID) COUNT_OF
    FROM
      (
        SELECT
          REGULATED_ENTITY_ID,
          REGULATED_ENTITY_NAME,
          MATCHING_ID
        FROM
          [dbo].SOURCE__DATA_CONSOLIDATION
      ) REGENT_NAMES
    WHERE
      REGULATED_ENTITY_NAME IS NOT NULL
    GROUP BY
      REGULATED_ENTITY_ID,
      REGULATED_ENTITY_NAME,
      MATCHING_ID
    HAVING
      COUNT(REGULATED_ENTITY_ID) > 1
  ) REGENT


  --CONVERT REGULATED ENTITY RECORDS TO ACCOUNTS--
  --===================================================================================================
  --===================================================================================================
INSERT INTO
  [dbo].STAGING__ACCOUNT (
    [description],
    [accountnumber],
    id,
    accountid,
    [ovs_legalname],
    [name],
    [ovs_accountnameenglish],
    [ovs_accountnamefrench],
    [owninguser],
    [owningbusinessunit],
    [owneridtype],
    [ownerid],
    [customertypecode]
  )
SELECT
  CONCAT(
    'Converted from IIS.',
    CHAR(13) + CHAR(10),
    'IIS ID: ',
    [IIS_ID],
    CHAR(13) + CHAR(10),
    'Data Consolidation Matching ID: ',
    [REGULATED_ENTITY_ID_SOURCE]
  ) [description],
  [REGULATED_ENTITY_ID_SOURCE] [accountnumber],
  [REGULATED_ENTITY_ID] [id],
  [REGULATED_ENTITY_ID] [accountid],
  [REGULATED_ENTITY_NAME] [ovs_legalname],
  [REGULATED_ENTITY_NAME] [name],
  [CONSOLIDATED_COMMON_ENGLISH_NAME] [ovs_accountnameenglish],
  [CONSOLIDATED_COMMON_FRENCH_NAME] [ovs_accountnamefrench],
  @CONST_TDGCORE_USERID [owninguser],
  @CONST_TDG_BUSINESSUNITID [owningbusinessunit],
  @CONST_OWNERIDTYPE_SYSTEMUSER [owneridtype],
  @CONST_TDGCORE_USERID [ownerid],
  948010000 [customertypecode]
FROM
  [dbo].SOURCE__REGULATED_ENTITIES REGENT;


--SITES
--===================================================================================================
--===================================================================================================
INSERT INTO
  [dbo].SOURCE__SITES (
    [SITE_ID],
    [IIS_ID],
    [REGULATED_ENTITY_ID],
    [REGULATED_ENTITY_ID_SOURCE],
    [REGULATED_ENTITY_NAME],
    [COMPANY_NAME_FORMATTED],
    [COMPANY_NAME],
    [COUNTRY_SUBDIVISION_CD],
    [CITY_TOWN_NAME_NM],
    [ADDRESS],
    [POSTAL_CODE_TXT],
    [COMPLETED],
    [PLANNED2021]
  )
SELECT
  NEWID() [SITE_ID],
  SITES.IIS_ID,
  NULL [REGULATED_ENTITY_ID],
  SITES.REGULATED_ENTITY_ID [REGULATED_ENTITY_ID_SOURCE],
  SITES.[REGULATED_ENTITY_NAME],
  SITES.COMPANY_NAME_FORMATTED,
  SITES.COMPANY_NAME,
  SITES.COUNTRY_SUBDIVISION_CD,
  SITES.CITY_TOWN_NAME_NM,
  SITES.ADDRESS,
  SITES.POSTAL_CODE_TXT,
  SITES.COMPLETED,
  SITES.[PLANNED2021]
FROM
  (
    SELECT
      [COMPLETED],
      [ASSIGNED_TO],
      [IIS_ID],
      [COMPANY_NAME_FORMATTED],
      [PLANNED2021],
      [COMPANY_NAME],
      [COUNTRY_SUBDIVISION_CD],
      [CITY_TOWN_NAME_NM],
      [ADDRESS],
      [POSTAL_CODE_TXT],
      [FILE_STATUS_CD],
      [SOUNDEX_NAME],
      [MATCHING_ID],
      [FUZZY_MATCH],
      [REGULATED_ENTITY_ID],
      [REGULATED_ENTITY_NAME],
      [CONSOLIDATED_COMMON_ENGLISH_NAME],
      [CONSOLIDATED_COMMON_FRENCH_NAME],
      [NOTES]
    FROM
      [dbo].SOURCE__DATA_CONSOLIDATION
  ) SITES --link SITES to regulated entities
UPDATE
  SITES
SET
  SITES.REGULATED_ENTITY_ID = REGENT.REGULATED_ENTITY_ID
FROM
  [dbo].SOURCE__SITES AS SITES
  INNER JOIN DBO.SOURCE__REGULATED_ENTITIES AS REGENT ON SITES.[REGULATED_ENTITY_ID_SOURCE] = REGENT.[REGULATED_ENTITY_ID_SOURCE];


DROP TABLE IF EXISTS #TEMP_ACCOUNTS;
CREATE TABLE #TEMP_ACCOUNTS (
[accountnumber]            [nvarchar](20) NULL,
[description]              [nvarchar](max) NULL,
[Id]                       [uniqueidentifier] NOT NULL,
[ovs_iisid]                [nvarchar](25) NULL,
[ovs_legalname]            [nvarchar](250) NULL,
[name]                     [nvarchar](160) NULL,
[ovs_accountnameenglish]   [nvarchar](4000) NULL,
[address1_stateorprovince] [nvarchar](50) NULL,
[address1_city]            [nvarchar](80) NULL,
[address1_line1]           [nvarchar](250) NULL,
[address1_postalcode]      [nvarchar](20) NULL,
[owninguser]               [uniqueidentifier] NULL,
[owningbusinessunit]       [uniqueidentifier] NULL,
[owneridtype]              [nvarchar](4000) NULL,
[ownerid]                  [uniqueidentifier] NULL,
[customertypecode]         int,
[msdyn_serviceterritory]   [uniqueidentifier] NULL,
[territoryid]              [uniqueidentifier] NULL,
[parentaccountid]          [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

--CONVERT SITE ENTITY RECORDS TO ACCOUNTS--
INSERT INTO
  #TEMP_ACCOUNTS
  (
    [accountnumber],
    [description],
    [ID],
    [ovs_iisid],
    [ovs_legalname],
    [name],
    [ovs_accountnameenglish],
    [address1_stateorprovince],
    [address1_city],
    [address1_line1],
    [address1_postalcode],
    [owninguser],
    [owningbusinessunit],
    [owneridtype],
    [ownerid],
    [customertypecode],
    [msdyn_serviceterritory],
    [territoryid],
    [parentaccountid]
  )
SELECT
  IIS_ID [accountnumber],
  CONCAT(
    'Converted from IIS.',
    CHAR(13) + CHAR(10),
    'IIS ID: ',
    IIS_ID
  ) [description],
  NEWID()                     [ID],
  IIS_ID                      [ovs_iisid],
  LEGAL_NAME_ENM              [ovs_legalname],
  COMPANY_NAME                [name],
  OPERATING_NAME_ENM          [ovs_accountnameenglish],
  T1.[COUNTRY_SUBDIVISION_CD] [address1_stateorprovince],
  [CITY_TOWN_NAME_NM]         [address1_city],
  [ADDRESS]                   [address1_line1],
  [POSTAL_CODE_TXT]           [address1_postalcode],
  @CONST_TDGCORE_USERID           [owninguser],
  @CONST_TDG_BUSINESSUNITID   [owningbusinessunit],
  @CONST_OWNERIDTYPE_SYSTEMUSER     [owneridtype],
  @CONST_TDGCORE_USERID           [ownerid],
  948010001                   [customertypecode],
  [msdyn_serviceterritory]    [msdyn_serviceterritory],
  [msdyn_serviceterritory]    [territoryid],
  T1.REGULATED_ENTITY_ID      [parentaccountid]
FROM
  (
    SELECT
      T1.*,
      CASE
        WHEN T2.LEGAL_NAME_ENM IS NULL
        OR T2.LEGAL_NAME_ENM = '' THEN NULL
        ELSE T2.LEGAL_NAME_ENM
      END LEGAL_NAME_ENM,
      [T2].OPERATING_NAME_ENM,
      T3.[msdyn_serviceterritory],
      NULL [parentaccountid]
    FROM
      SOURCE__SITES T1
      LEFT JOIN SOURCE__IIS_EXPORT T2 ON T1.IIS_ID = T2.STAKEHOLDER_ID
      LEFT JOIN [dbo].SOURCE__TERRITORY_TRANSLATION T3 ON UPPER(TRIM(T1.[COUNTRY_SUBDIVISION_CD])) = UPPER(TRIM(T3.[COUNTRY_SUBDIVISION_CD])) --Make sure that no regulated entity ids do not go into the system as sites
      --AND STAKEHOLDER_ID NOT IN
      --(
      -- SELECT
      -- IIS_ID
      -- FROM
      -- [02_REGULATED_ENTITIES]
      --)
  ) T1
INSERT INTO
  STAGING__ACCOUNT (
    [accountnumber],
    [description],
    [id],
    [accountid],
    [ovs_iisid],
    [ovs_legalname],
    [name],
    [ovs_accountnameenglish],
    [address1_stateorprovince],
    [address1_city],
    [address1_line1],
    [address1_postalcode],
    [owninguser],
    [owningbusinessunit],
    [owneridtype],
    [ownerid],
    [customertypecode],
    [msdyn_serviceterritory],
    [territoryid],
    [parentaccountid]
  )
SELECT
  [accountnumber],
  [description],
  [id],
  [id] [accountid],
  [ovs_iisid],
  [ovs_legalname],
  [name],
  [ovs_accountnameenglish],
  [address1_stateorprovince],
  [address1_city],
  [address1_line1],
  [address1_postalcode],
  [owninguser],
  [owningbusinessunit],
  [owneridtype],
  [ownerid],
  [customertypecode],
  [msdyn_serviceterritory],
  [territoryid],
  [parentaccountid]
FROM
  #TEMP_ACCOUNTS;
  --LOGIC FOR IIS DATA
  --===================================================================================================
  --===================================================================================================
UPDATE
  STAGING__ACCOUNT
SET
  --,name = T2.OPERATING_NAME,
  ovs_legalname = T2.LEGAL_NAME,
  ovs_accountnameenglish = T2.OPERATING_NAME,
  address1_primarycontactname = T2.USER_CONTACT,
  address1_telephone1 = T2.CONTACT_TFH,
  address1_latitude = CASE
    WHEN ISNUMERIC(T2.LATITUDE_DEGREE_NBR) = 1 THEN CAST(T2.LATITUDE_DEGREE_NBR AS DECIMAL(38, 5))
    ELSE NULL
  END,
  address1_longitude = CASE
    WHEN ISNUMERIC(T2.LONGITUDE_DEGREE_NBR) = 1 THEN CAST(T2.LONGITUDE_DEGREE_NBR AS DECIMAL(38, 5))
    ELSE NULL
  END,
  address1_city = TRIM(T2.CITY_TOWN_NAME_NM),
  address1_country = TRIM(T2.COUNTRY),
  address1_postalcode = TRIM(T2.POSTAL_CODE_TXT),
  address1_stateorprovince = TRIM(T2.COUNTRY_SUBDIVISION_CD),
  address1_line3 = TRIM(POBOX),
  address1_postofficebox = TRIM(POBOX),
  address1_line1 = CASE
    WHEN TRIM(T2.STREET) IS NULL
    OR TRIM(T2.STREET) = '' THEN address1_line1
    ELSE TRIM(T2.STREET)
  END
FROM
  STAGING__ACCOUNT T1
  JOIN (
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
        WHEN STREET_NAME_NM IS NULL
        AND (
          PHYS_STREET_NAME_NM IS NULL
          OR TRIM(PHYS_STREET_NAME_NM) = ''
        ) THEN NULL
        WHEN (
          STREET_NAME_NM IS NULL
          OR TRIM(STREET_NAME_NM) = '0'
        )
        AND PHYS_STREET_NAME_NM IS NOT NULL THEN CONCAT(
          IIS.PHYS_STREET_NUMBER_NUM,
          ' ',
          IIS.PHYS_STREET_NAME_NM
        )
        ELSE CONCAT(IIS.STREET_NUMBER_NUM, ' ', STREET_NAME_NM)
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
        WHEN IIS.UNIT_SUITE_NUM = 'P.O. Box'
        OR IIS.UNIT_SUITE_NUM = 'PO' THEN CONCAT('P.O. Box', ' ', STREET_NUMBER_NUM)
        WHEN IIS.UNIT_SUITE_NUM = 'RR'
        OR IIS.UNIT_SUITE_NUM = 'SS' THEN CONCAT(IIS.UNIT_SUITE_NUM, ' ', STREET_NUMBER_NUM)
        ELSE NULL
      END POBOX,
      --Phone
      --Out of the box field.
      --DATA MIGRATION RULES:
      --There is no field that needs to be migrated from IIS.
      IIS.CONTACT_PHONE,
      IIS.CONTACT_BUSINESS_PHONE,
      IIS.CONTACT_EMAIL,
      IIS.CONTACT_TFH,
      IIS.USER_CONTACT --Fax
      --Out of the box field.
      --DATA MIGRATION RULES:
      --There is no field that needs to be migrated from IIS.
,
      ADDRESS_TYPE.[TYPE]
    FROM
      SOURCE__SITES SITES
      JOIN SOURCE__IIS_EXPORT IIS ON SITES.IIS_ID = IIS.STAKEHOLDER_ID
      JOIN (
        SELECT
          STAKEHOLDER_ID,
          CASE
            WHEN (
              STREET_NUMBER_NUM IS NULL
              OR TRIM(STREET_NUMBER_NUM) = ''
            )
            AND (
              STREET_NAME_NM IS NULL
              OR TRIM (STREET_NAME_NM) = ''
            )
            AND (
              CITY_TOWN_NAME_NM IS NULL
              OR TRIM(CITY_TOWN_NAME_NM) = ''
            )
            AND (
              COUNTRY_SUBDIVISION_CD IS NULL
              OR TRIM(COUNTRY_SUBDIVISION_CD) = ''
            )
            AND (
              POSTAL_CODE_TXT IS NULL
              OR TRIM(POSTAL_CODE_TXT) = ''
            ) THEN 'PHYSICAL'
            ELSE 'CIVIC'
          END [TYPE]
        FROM
          SOURCE__IIS_EXPORT
      ) ADDRESS_TYPE ON IIS.STAKEHOLDER_ID = ADDRESS_TYPE.STAKEHOLDER_ID
  ) T2 ON T1.ovs_iisid = T2.STAKEHOLDER_ID;


--MOC Registration Number
--Required to be migrated from IIS.  This field will be required for linking to FDR.
--get this field from the workplan uploads
UPDATE
  STAGING__ACCOUNT
SET
  ovs_mocid = T2.MOC_ID
FROM
  STAGING__ACCOUNT T1
  JOIN (
    SELECT
      DISTINCT SITES.IIS_ID,
      WORKPLANS.MOC_ID
    FROM
      SOURCE__SITES SITES
      JOIN [dbo].SOURCE__WORKPLAN_IMPORT WORKPLANS ON CAST(SITES.IIS_ID AS varchar(10)) = WORKPLANS.IIS_ID
    WHERE
      MOC_ID IS NOT NULL
      AND MOC_ID <> ''
  ) T2 ON T1.ovs_iisid = T2.IIS_ID;


--View accounts linked to Sites
--SELECT *
--FROM STAGING__ACCOUNT T1
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
--Try to sanitize some bad data from IIS
UPDATE
  [dbo].STAGING__ACCOUNT
SET
  address1_postalcode = REPLACE(address1_postalcode, ' ', ''),
  address1_country = 'Canada',
  address1_line1 = TRIM(address1_line1),
  address1_latitude = CASE
    WHEN address1_latitude IS NULL
    OR address1_latitude = 0.00000 THEN NULL
    ELSE address1_latitude
  END,
  address1_longitude = CASE
    WHEN address1_longitude IS NULL
    OR address1_longitude = 0.00000 THEN NULL
    ELSE address1_longitude
  END;


--WORK ORDERS
INSERT INTO
  [dbo].SOURCE__IIS_INSPECTIONS (
    [MONTH],
    [YEAR],
    FILE_NUMBER_NUM,
    FILE_STATUS_ETXT,
    FILE_STATUS_FTXT,
    ACTIVITY_DATE_DTE,
    ACTIVITY_ID,
    STAKEHOLDER_ID,
    id,
    ovs_iisid,
    INSPECTION_REASON_ETXT,
    INSPECTION_REASON_FTXT,
    ACTIVITY_TYPE_CD,
    ACTIVITY_TYPE_ENM,
    SUBACTIVITY_TYPE_CDS,
    SUBACTIVITY_TYPE_ENMS,
    PRIMARY_INSPECTOR,
    PRIMARY_INSPECTOR_ID,
    PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
    PRIMARY_INSPECTOR_USER_ID,
    SECONDARY_INSPECTOR,
    SECONDARY_INSPECTOR_ID,
    SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
    SECONDARY_INSPECTOR_USER_ID
  )
SELECT
  MONTH(ACTIVITY_DATE_DTE) [MONTH],
  YEAR(ACTIVITY_DATE_DTE) [YEAR],
  *
FROM
  (
    SELECT
      YD095.FILE_NUMBER_NUM,
      TD001.FILE_STATUS_ETXT,
      TD001.FILE_STATUS_FTXT,
      CONVERT(datetime, YD040.ACTIVITY_DATE_DTE) ACTIVITY_DATE_DTE,
      YD040.ACTIVITY_ID,
      YD040.STAKEHOLDER_ID,
      NULL id,
      --ACCOUNTS.id,
      NULL ovs_iisid,
      --ACCOUNTS.[ovs_iisid],
      TD038.INSPECTION_REASON_ETXT,
      TD038.INSPECTION_REASON_FTXT,
      CATEGORIES.ACTIVITY_TYPE_CD,
      CATEGORIES.ACTIVITY_TYPE_ENM,
      CATEGORIES.SUBACTIVITY_TYPE_CDS,
      CATEGORIES.SUBACTIVITY_TYPE_ENMS,
      PRIMARY_INSPECTOR.name PRIMARY_INSPECTOR,
      PRIMARY_INSPECTOR.STAKEHOLDER_ID PRIMARY_INSPECTOR_ID,
      PRIMARY_INSPECTOR.bookableresourceid PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
      PRIMARY_INSPECTOR.userid PRIMARY_INSPECTOR_USER_ID,
      SECONDARY_INSPECTOR.name SECONDARY_INSPECTOR,
      SECONDARY_INSPECTOR.STAKEHOLDER_ID SECONDARY_INSPECTOR_ID,
      SECONDARY_INSPECTOR.bookableresourceid SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
      SECONDARY_INSPECTOR.userid SECONDARY_INSPECTOR_USER_ID
    FROM
      YD040_ACTIVITY YD040
      JOIN YD095_STAKEHOLDER_FILE YD095 ON YD040.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM
      JOIN TD001_FILE_STATUS TD001 ON YD095.FILE_STATUS_CD = TD001.FILE_STATUS_CD
      JOIN (
        SELECT
          CAT.FILE_NUMBER_NUM,
          CAT.ACTIVITY_TYPE_CD,
          CAT.ACTIVITY_TYPE_ENM,
          ISNULL(SUBCAT.SUBACTIVITY_TYPE_CDS, 'N/A') SUBACTIVITY_TYPE_CDS,
          ISNULL(SUBCAT.SUBACTIVITY_TYPE_ENMS, 'N/A') SUBACTIVITY_TYPE_ENMS
        FROM
          (
            SELECT
              YD101.FILE_NUMBER_NUM,
              TD045.ACTIVITY_TYPE_CD,
              TD045.ACTIVITY_TYPE_ENM
            FROM
              [dbo].[YD101_FILE_ACTIVITY_TYPE] YD101
              JOIN TD045_ACTIVITY_TYPE TD045 ON YD101.ACTIVITY_TYPE_CD = TD045.ACTIVITY_TYPE_CD
            WHERE
              ACTIVITY_TYPE_PARENT_CD IS NULL
              AND TD045.DATE_DELETED_DTE IS NULL --AND YD101.DATE_DELETED_DTE IS NULL
            GROUP BY
              YD101.FILE_NUMBER_NUM,
              TD045.ACTIVITY_TYPE_CD,
              TD045.ACTIVITY_TYPE_ENM
          ) CAT
          LEFT JOIN (
            SELECT
              YD101.FILE_NUMBER_NUM,
              STRING_AGG (ISNULL(TD045.ACTIVITY_TYPE_CD, 'N/A'), ',') AS SUBACTIVITY_TYPE_CDS,
              STRING_AGG (ISNULL(TD045.ACTIVITY_TYPE_ENM, 'N/A'), ',') AS SUBACTIVITY_TYPE_ENMS
            FROM
              [dbo].[YD101_FILE_ACTIVITY_TYPE] YD101
              JOIN TD045_ACTIVITY_TYPE TD045 ON YD101.ACTIVITY_TYPE_CD = TD045.ACTIVITY_TYPE_CD
            WHERE
              ACTIVITY_TYPE_PARENT_CD IS NOT NULL
              AND TD045.DATE_DELETED_DTE IS NULL --AND YD101.DATE_DELETED_DTE IS NULL
            GROUP BY
              YD101.FILE_NUMBER_NUM
          ) SUBCAT ON CAT.FILE_NUMBER_NUM = SUBCAT.FILE_NUMBER_NUM
      ) CATEGORIES ON CATEGORIES.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM
      LEFT JOIN YD041_INSPECTION YD041 ON YD040.ACTIVITY_ID = YD041.ACTIVITY_ID
      LEFT JOIN TD038_INSPECTION_REASON TD038 ON YD041.INSPECTION_REASON_CD = TD038.INSPECTION_REASON_CD
      LEFT JOIN (
        SELECT
          YD048.ACTIVITY_ID,
          YD048.STAKEHOLDER_ID,
          name,
          BR.bookableresourceid,
          BR.userid
        FROM
          YD048_ACTIVITY_ASSIGNMENT YD048
          JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON YD048.STAKEHOLDER_ID = YD083.STAKEHOLDER_ID
          JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR ON UPPER(
            TRIM(
              CONCAT(
                CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM, ' '),
                YD083.STAKEHOLDER_NAME_FAMILY_NM
              )
            )
          ) = UPPER([dbo].[ReplaceASCII](name))
        WHERE
          YD083.DATE_DELETED_DTE IS NULL
          AND YD048.DATE_DELETED_DTE IS NULL
          AND ASSIGN_ROLE_CD = '1'
      ) PRIMARY_INSPECTOR ON PRIMARY_INSPECTOR.ACTIVITY_ID = YD040.ACTIVITY_ID
      LEFT JOIN (
        SELECT
          YD048.ACTIVITY_ID,
          YD048.STAKEHOLDER_ID,
          name,
          BR.bookableresourceid,
          BR.userid
        FROM
          YD048_ACTIVITY_ASSIGNMENT YD048
          JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON YD048.STAKEHOLDER_ID = YD083.STAKEHOLDER_ID
          JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR ON UPPER(
            TRIM(
              CONCAT(
                CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM, ' '),
                YD083.STAKEHOLDER_NAME_FAMILY_NM
              )
            )
          ) = UPPER([dbo].[ReplaceASCII](name))
        WHERE
          YD083.DATE_DELETED_DTE IS NULL
          AND YD048.DATE_DELETED_DTE IS NULL
          AND ASSIGN_ROLE_CD = '2'
      ) SECONDARY_INSPECTOR ON SECONDARY_INSPECTOR.ACTIVITY_ID = YD040.ACTIVITY_ID --JOIN [dbo].STAGING__ACCOUNT ACCOUNTS ON ACCOUNTS.ovs_iisid = YD040.STAKEHOLDER_ID
      --WHERE
      --YD040.DATE_DELETED_DTE IS NULL AND
      --YD095.DATE_DELETED_DTE IS NULL AND
      --YD041.DATE_DELETED_DTE IS NULL AND
      -- TD045.ACTIVITY_TYPE_CD,
      --TD045.ACTIVITY_TYPE_ENM,
      --TD045.ACTIVITY_TYPE_FNM,
      --YD101.DATE_DELETED_DTE IS NULL
      --AND TD045.ACTIVITY_TYPE_PARENT_CD IS NULL AND TD045.DATE_DELETED_DTE IS NULL
    GROUP BY
      YD095.FILE_NUMBER_NUM,
      TD001.FILE_STATUS_ETXT,
      TD001.FILE_STATUS_FTXT,
      YD040.INSPECTION_DATE_DTE,
      YD040.ACTIVITY_ID,
      YD040.STAKEHOLDER_ID,
      --ACCOUNTS.id,
      --ACCOUNTS.ovs_iisid,
      CATEGORIES.FILE_NUMBER_NUM,
      CATEGORIES.ACTIVITY_TYPE_CD,
      CATEGORIES.ACTIVITY_TYPE_ENM,
      CATEGORIES.SUBACTIVITY_TYPE_CDS,
      CATEGORIES.SUBACTIVITY_TYPE_ENMS,
      TD038.INSPECTION_REASON_ETXT,
      TD038.INSPECTION_REASON_FTXT,
      YD040.ACTIVITY_DATE_DTE,
      PRIMARY_INSPECTOR.name,
      PRIMARY_INSPECTOR.STAKEHOLDER_ID,
      PRIMARY_INSPECTOR.bookableresourceid,
      PRIMARY_INSPECTOR.userid,
      SECONDARY_INSPECTOR.name,
      SECONDARY_INSPECTOR.STAKEHOLDER_ID,
      SECONDARY_INSPECTOR.bookableresourceid,
      SECONDARY_INSPECTOR.userid
  ) T;


--connect the IIS Inspections to the Accounts in ROM
UPDATE
  SOURCE__IIS_INSPECTIONS
SET
  id = ACCOUNTS.Id,
  ovs_iisid = STAKEHOLDER_ID
FROM
  SOURCE__IIS_INSPECTIONS
  JOIN [dbo].STAGING__ACCOUNT ACCOUNTS ON ACCOUNTS.ovs_iisid = STAKEHOLDER_ID
WHERE
  ACCOUNTS.customertypecode <> 948010000;


--IIS ACTIVITY TYPE TO ROM ACTIVITY MAPPING EXCEL SHEET VALUES
DROP TABLE IF EXISTS #ACTIVITY_TYPE_MAPPINGS;
SELECT
  * INTO #ACTIVITY_TYPE_MAPPINGS
FROM
  (
    SELECT
      20                       IIS_ACTIVITY_TYPE_ID,
      'Site visit'             IIS_ACTIVITY_TYPE_ENM,
      NULL                     IIS_ACTIVITY_SUB_TYPE_ID,
      'n/a'                    IIS_ACTIVITY_SUB_TYPE_ENM,
      'SITE_VISIT'             ROM_OVERSIGHT_TYPE_ID,
      'SITE_VISIT'             ROM_OVERSIGHT_TYPE_ENM,
      @CONST_RATIONALE_PLANNED ROM_RATIONALE_ID,
      'Planned'                ROM_RATIONALE_ENM
    UNION
    SELECT
      21,
      'General Compliance Inspection',
      26,
      'Compliance Estimation Program (CEP)',
      @CONST_OVERSIGHTTYPE_GCTARGETED,
      'GC Targeted',
      @CONST_RATIONALE_PLANNED,
      'Planned'
    UNION
    SELECT
      21,
      'General Compliance Inspection',
      28,
      'Follow-up Inspection (Discretionary)',
      @CONST_OVERSIGHTTYPE_GCTARGETED,
      'GC Targeted',
      @CONST_RATIONALE_PLANNED,
      'Planned'
    UNION
    SELECT
      21,
      'General Compliance Inspection',
      27,
      'Follow-up Inspection (Indicated)',
      @CONST_OVERSIGHTTYPE_GCTARGETED,
      'GC Targeted',
      @CONST_RATIONALE_PLANNED,
      'Planned'
    UNION
    SELECT
      21,
      'General Compliance Inspection',
      33,
      'Opportunity',
      @CONST_OVERSIGHTTYPE_GC_OPPORTUNITY,
      'GC Opportunity',
      @CONST_RATIONALE_UNPLANNED,
      'Unplanned'
    UNION
    SELECT
      21,
      'General Compliance Inspection',
      25,
      'Scheduled (Workplan / Risk Based - excluding others)',
      @CONST_OVERSIGHTTYPE_GCIPT,
      'GC IPT',
      @CONST_RATIONALE_PLANNED,
      'Planned'
    UNION
    SELECT
      21,
      'General Compliance Inspection',
      32,
      'Triggered',
      @CONST_OVERSIGHTTYPE_GC_TRIGGERED,
      'GC Triggered',
      @CONST_RATIONALE_UNPLANNED,
      'Unplanned'
    UNION
    SELECT
      22,
      'MOC Facility Inspection (Planned)',
      NULL,
      'all subcategory types',
      @CONST_OVERSIGHTTYPE_MOC_FACILITY_IPT,
      'MOC Facility IPT',
      @CONST_RATIONALE_PLANNED,
      'Planned'
    UNION
    SELECT
      23,
      'Consignment',
      NULL,
      'all subcategory types',
      @CONST_OVERSIGHTTYPE_GCCONSIGNMENT,
      'GC Consignment',
      @CONST_RATIONALE_UNPLANNED,
      'Unplanned'
    UNION
    SELECT
      24,
      'Document Review',
      NULL,
      'n/a',
      @CONST_OVERSIGHTTYPE_CIVDOCREVIEW,
      'Civil Aviation Document Review',
      @CONST_RATIONALE_UNPLANNED,
      'Unplanned'
    UNION
    SELECT
      59,
      'MOC Facility Inspection - (Unplanned)',
      NULL,
      'all subcategory types',
      @CONST_OVERSIGHTTYPE_MOCOPPORTUNITY,
      'MOC Facility Opportunity',
      @CONST_RATIONALE_UNPLANNED,
      'Unplanned'
    UNION
    SELECT
      NULL,
      'NULL',
      NULL,
      'NULL',
      @CONST_OVERSIGHTTYPE_GC_UNDECLARED,
      'GC Undeclared / Misdeclared',
      @CONST_RATIONALE_UNPLANNED,
      'Unplanned'
    UNION
    SELECT
      NULL,
      'NULL',
      NULL,
      'NULL',
      @CONST_OVERSIGHTTYPE_MOC_FACILITY_FOLLOWUP,
      'MOC Facility Follow-up',
      @CONST_RATIONALE_UNPLANNED,
      'Unplanned'
    UNION
    SELECT
      NULL,
      'NULL',
      NULL,
      'NULL',
      @CONST_OVERSIGHTTYPE_MOCTARGETED,
      'MOC Facility Targeted',
      @CONST_RATIONALE_PLANNED,
      'Planned'
    UNION
    SELECT
      NULL,
      'NULL',
      NULL,
      'NULL',
      @CONST_OVERSIGHTTYPE_MOC_FACILITY_TRIGGERED,
      'MOC Facility Triggered',
      @CONST_RATIONALE_UNPLANNED,
      'Unplanned'
  ) T;


--only convert activities that have a mapping defined
DELETE FROM
  #ACTIVITY_TYPE_MAPPINGS WHERE IIS_ACTIVITY_TYPE_ID IS NULL;
SELECT
  *
FROM
  #ACTIVITY_TYPE_MAPPINGS;
  --create values for fiscal data
  DROP TABLE IF EXISTS #T2;
SELECT
  T.*,
  FY.tc_tcfiscalyearid,
  FQ.tc_tcfiscalquarterid INTO #T2
FROM
  (
    SELECT
      newid() ID,
      --WORK ORDER ID
      CONVERT(
        uniqueidentifier,
        @CONST_WORKORDERTYPE_INSPECTION
      ) WORK_ORDER_TYPE,
      --work order type "Inspection"
      REPLACE(
        STR(
          ROW_NUMBER() OVER (
            ORDER BY
              ACTIVITY_ID
          ),
          6
        ),
        ' ',
        '0'
      ) WORK_ORDER_NUMBER,                                                          --WO name, auto incremented number 1...x
      CONVERT(uniqueidentifier, @CONST_PRICELISTID) PRICE_LIST,                     --default price list
      id accountid,                                                                 --account id for service account linked by the iis id
      [ovs_iisid],                                                                  --IIS STAKEHOLDER_ID
      @CONST_WORKORDER_STATUS_CLOSED_POSTED WORK_ORDER_STATUS,                                                --"Closed - Posted"
      FILE_STATUS_ETXT,
      PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,                                       --PRIMARY INSPECTOR
      SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,                                     --SECONDARY INSPECTOR
      PRIMARY_INSPECTOR_USER_ID owner,                                              --@CONST_TDGCORE_USERID [OWNER] --OWNER = primary inspector
      @CONST_OWNERIDTYPE_SYSTEMUSER [OWNER_TYPE],                                                    --OWNER TYPE = systemuser
      CONVERT(uniqueidentifier, @CONST_TDG_BUSINESSUNITID) [OWNING_BUSINESS_UNIT],  --TDG Business Unit
      PRIMARY_INSPECTOR_USER_ID [owning_user],                                      --,@CONST_TDGCORE_USERID [OWNING_TEAM]         --OWNING TEAM = TDG Team
      CAST(ACTIVITY_ID AS nvarchar(500)) [WORK_ORDER_SUMMARY],
      --WORK ORDER SUMMARY
      CASE
        WHEN (
          [MONTH] >= 1
          AND [MONTH] <= 3
        ) THEN 'Q4'
        WHEN (
          [MONTH] >= 4
          AND [MONTH] <= 6
        ) THEN 'Q1'
        WHEN (
          [MONTH] >= 7
          AND [MONTH] <= 9
        ) THEN 'Q2'
        WHEN (
          [MONTH] >= 10
          AND [MONTH] <= 12
        ) THEN 'Q3'
      END FISCAL_QUARTER,
      CASE
        WHEN (
          [MONTH] >= 1
          AND [MONTH] <= 3
        ) THEN CONCAT(
          CONVERT(NVARCHAR(4), [YEAR] - 1),
          '-',
          CONVERT(NVARCHAR(4), [YEAR])
        )
        ELSE CONCAT(
          CONVERT(NVARCHAR(4), [YEAR]),
          '-',
          CONVERT(NVARCHAR(4), [YEAR] + 1)
        )
      END FISCAL_YEAR,
      T1.ACTIVITY_TYPE_CD,
      T2.IIS_ACTIVITY_TYPE_ID,
      T2.IIS_ACTIVITY_SUB_TYPE_ID,
      T1.ACTIVITY_TYPE_ENM,
      IIS_ACTIVITY_TYPE_ENM,
      ROM_OVERSIGHT_TYPE_ID,
      ROM_RATIONALE_ID,
      SUBACTIVITY_TYPE_CDS SUBACTIVITY_TYPE_CDS
    FROM
      SOURCE__IIS_INSPECTIONS T1,
      #ACTIVITY_TYPE_MAPPINGS T2
      --JOIN #ACTIVITY_TYPE_MAPPINGS T2 ON  (T1.ACTIVITY_TYPE_CD  = CAST(T2.IIS_ACTIVITY_TYPE_ID as varchar(10))) AND
      --(T1.SUBACTIVITY_TYPE_CDS = CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID as varchar(10)))
    WHERE
      ROM_OVERSIGHT_TYPE_ID <> 'SITE_VISIT'
      AND (
        (T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID)
        AND IIS_ACTIVITY_SUB_TYPE_ID IS NULL
      )
      OR (
        T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID
        AND T1.SUBACTIVITY_TYPE_CDS = CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10))
      )
      OR (
        T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID
        AND CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10)) IS NULL
      )
      OR (
        T1.ACTIVITY_TYPE_CD = t2.IIS_ACTIVITY_TYPE_ID
        AND CHARINDEX(
          CAST(T2.IIS_ACTIVITY_SUB_TYPE_ID AS varchar(10)),
          T1.SUBACTIVITY_TYPE_CDS
        ) > 0
      )
      AND id IS NOT NULL
  ) T
  JOIN [dbo].SOURCE__FISCAL_YEAR FY ON FY.TC_NAME = T.FISCAL_YEAR
  JOIN [dbo].SOURCE__FISCAL_QUARTER FQ ON FQ.TC_NAME = T.FISCAL_QUARTER
  AND FY.tc_tcfiscalyearid = FQ.tc_tcfiscalyearid
WHERE
  accountid IS NOT NULL;


--create staging values
INSERT INTO
  [dbo].STAGING__WORK_ORDERS (
    [msdyn_workorderid],
    [msdyn_workordertype],
    [msdyn_name],
    [msdyn_pricelist],
    [msdyn_serviceaccount],
    [ovs_iisid],
    [msdyn_systemstatus],
    [ovs_primaryinspector],
    [ovs_secondaryinspector],
    [ownerid],
    [owneridtype],
    [owningbusinessunit],
    owninguser,
    [msdyn_workordersummary],
    [ovs_fiscalquarter],
    [ovs_fiscalyear],
    [ovs_oversighttype],
    [ovs_rational] --,[qm_reportcontactid]
    --,[statecode]
    --,[statuscode]
  )
SELECT
  ID,
  WORK_ORDER_TYPE,
  WORK_ORDER_NUMBER,
  PRICE_LIST,
  accountid,
  ovs_iisid,
  WORK_ORDER_STATUS,
  PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
  SECONDARY_INSPECTOR_BOOKABLE_RESOURCE_ID,
  owner,
  OWNER_TYPE,
  OWNING_BUSINESS_UNIT,
  owning_user,
  WORK_ORDER_SUMMARY,
  tc_tcfiscalquarterid,
  tc_tcfiscalyearid --,ACTIVITY_TYPE_CD
  --,IIS_ACTIVITY_TYPE_ID
  --,IIS_ACTIVITY_SUB_TYPE_ID
  --,ACTIVITY_TYPE_ENM
  --,IIS_ACTIVITY_TYPE_ENM
  --,SUBACTIVITY_TYPE_CDS
,
  CONVERT(uniqueidentifier, ROM_OVERSIGHT_TYPE_ID) ROM_OVERSIGHT_TYPE_ID,
  CONVERT(uniqueidentifier, ROM_RATIONALE_ID) ROM_RATIONALE_ID
FROM
  (
    SELECT
      *
    FROM
      #T2
    WHERE
      ROM_OVERSIGHT_TYPE_ID <> 'SITE_VISIT'
  ) T;


--load the fiscal year, quarter and inspector names into the staging table, easier to look at the data
UPDATE
  STAGING__WORK_ORDERS
SET
  [ovs_primaryinspectorname] = BR.name,
  [ovs_secondaryinspectorname] = BR2.name,
  [ovs_fiscalquartername] = FQ.tc_name,
  [ovs_fiscalyearname] = FY.tc_name --SELECT
  --BR.name
  --,BR2.name
  --,FQ.tc_name
  --,FY.tc_name
FROM
  STAGING__WORK_ORDERS T1
  JOIN [dbo].SOURCE__FISCAL_YEAR FY ON T1.ovs_fiscalyear = FY.tc_tcfiscalyearid
  JOIN [dbo].SOURCE__FISCAL_QUARTER FQ ON T1.ovs_fiscalquarter = FQ.tc_tcfiscalquarterid
  JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR ON T1.ovs_primaryinspector = BR.bookableresourceid
  LEFT JOIN [dbo].STAGING__BOOKABLE_RESOURCE BR2 ON T1.ovs_secondaryinspector = BR2.bookableresourceid --UPDATE WORK ORDER ADDRESSES WITH ACCOUNT ADDRESSES
UPDATE
  STAGING__WORK_ORDERS
SET
  msdyn_serviceterritory = A.territoryid,
  msdyn_address1 = A.address1_line1,
  msdyn_address2 = A.address1_line2,
  msdyn_address3 = A.address1_line3,
  msdyn_city = A.address1_city,
  msdyn_country = A.address1_country,
  msdyn_postalcode = A.address1_postalcode,
  msdyn_stateorprovince = A.address1_stateorprovince
FROM
  STAGING__WORK_ORDERS WO
  JOIN STAGING__ACCOUNT A ON WO.msdyn_serviceaccount = A.id;


--WHERE THE PRIMARY HASNT BEEN SET BECAUSE THE INSPECTOR DOES NOT HAVE AN ACCOUNT YET, THEN SET IT TO THE "TDG.CORE" user so we can at least get them in
UPDATE
  STAGING__WORK_ORDERS
SET
  [ovs_primaryinspector] = @CONST_TDGCORE_BOOKABLE_RESOURCE_ID, --TDG CORE BOOKABLE RESOURCE ID
  ownerid = @CONST_TDGCORE_USERID,                              -- tdg core system user
  owninguser = @CONST_TDGCORE_USERID                            -- tdg core system user
FROM
  STAGING__WORK_ORDERS WO
WHERE
  WO.ovs_primaryinspector IS NULL;


--set the status of inspections from this years workplan that have already been started in IIS to Open-Completed====
--SELECT * FROM STAGING__WORK_ORDERS WHERE ovs_fiscalyearname = '2021-2022'
--Open - Unscheduled 690970000
--Open - Scheduled  690970001
--Open - In Progress 690970002
--Open - Completed  690970003
--Closed - Posted  690970004
--Closed - Canceled  690970005
--ANY Inspections from this years workplan that exist in IIS lets set to Open-Completed, hard to know if they're fully done or not
UPDATE
  STAGING__WORK_ORDERS
SET
  [msdyn_systemstatus] = '690970003' --Open-Completed
WHERE
  ovs_fiscalyearname = '2021-2022';


--INSERT planned inspections for this fiscal year that havnt been started in IIS
INSERT INTO
  [dbo].STAGING__WORK_ORDERS (
    [msdyn_workorderid],
    [msdyn_workordertype],
    [msdyn_name],
    [msdyn_pricelist],
    [msdyn_serviceaccount],
    [ovs_iisid],
    [msdyn_systemstatus],
    [ovs_primaryinspector], --,[ovs_secondaryinspector]
    [ownerid],
    [owneridtype],
    [owningbusinessunit],
    owninguser,
    [msdyn_workordersummary],
    [ovs_fiscalquarter],
    [ovs_fiscalquartername],      
    [ovs_fiscalyear],
    [ovs_fiscalyearname],
    [ovs_oversighttype],
    [ovs_rational]
  )
SELECT
  newid()                         [msdyn_workorderid],    --WORK ORDER ID
  @CONST_WORKORDERTYPE_INSPECTION [WORK_ORDER_TYPE],      --work order type "Inspection"
  CONCAT(
    [YEAR],
    REPLACE(
      STR(
        ROW_NUMBER() OVER (
          ORDER BY
            import_number
        ),
        6
      ),
      ' ',
      '0'
    )
  )                               [WORK_ORDER_NUMBER],    --WO name, 2021 + auto incremented number 1...x
  @CONST_PRICELISTID              [PRICE_LIST],           --default price list
  accountid                       [accountid],            --account id for service account linked by the iis id
  IIS_ID                          [IIS_ID],               --IIS STAKEHOLDER_ID
  '690970000'                     [WORK_ORDER_STATUS],    --"Unscheduled"
  BOOKABLE_RESOURCE_ID            [PRIMARY INSPECTOR],    --PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID
  OWNER_ID                        [OWNER],                --OWNER = primary inspector
  OWNER_TYPE                      [OWNER_TYPE],           --OWNER TYPE = systemuser
  @CONST_TDG_BUSINESSUNITID       [OWNING_BUSINESS_UNIT], --TDG Business Unit
  OWNING_USER                     [owning_user],          --owning user is the primary inspector
  CONCAT(
    'Work Order converted from 2021/2022 Workplan for IIS_ID = ',
    IIS_ID
  ) [WORK_ORDER_SUMMARY],                           --WORK ORDER SUMMARY
  [tc_tcfiscalquarterid],
  [ovs_fiscalquartername],
  [tc_tcfiscalyearid],
  [ovs_fiscalyearname],
  CASE
    WHEN [TYPE] = 'MOC' THEN @CONST_OVERSIGHTTYPE_MOCTARGETED
    WHEN [TYPE] = 'GC' THEN @CONST_OVERSIGHTTYPE_GCTARGETED
    WHEN [TYPE] = 'HUBS' THEN @CONST_OVERSIGHTTYPE_GCTARGETED
  END OVERSIGHT_TYPE,
  @CONST_RATIONALE_PLANNED RATIONALE                --ALL WORK PLAN INSPECTIONS ARE PLANNED
FROM
  (
    SELECT
      CASE
        WHEN BR.userid IS NULL THEN @CONST_TDGCORE_USERID
        ELSE BR.userid
      END OWNER_ID,
      CASE
        WHEN BR.bookableresourceid IS NULL THEN @CONST_TDGCORE_BOOKABLE_RESOURCE_ID
        ELSE BR.bookableresourceid
      END BOOKABLE_RESOURCE_ID,
      CASE
        WHEN BR.userid IS NULL THEN @CONST_OWNERIDTYPE_SYSTEMUSER
        ELSE @CONST_OWNERIDTYPE_SYSTEMUSER
      END OWNER_TYPE,
      CASE
        WHEN BR.userid IS NULL THEN NULL
        ELSE BR.userid
      END OWNING_USER,
      WP.*,
      ACCOUNTS.ID accountid,
      FQ.[tc_tcfiscalquarterid],
      FQ.[tc_name] [ovs_fiscalquartername],
      FY.[tc_tcfiscalyearid],
      FY.[tc_name] [ovs_fiscalyearname]
    FROM
      (
        SELECT
          CASE
            WHEN QUARTER_1 = '1' THEN 'Q1'
            WHEN QUARTER_2 = '1' THEN 'Q2'
            WHEN QUARTER_3 = '1' THEN 'Q3'
            WHEN QUARTER_4 = '1' THEN 'Q4'
          END [QUARTER],
          CASE
            WHEN QUARTER_1 = '1'
            OR QUARTER_2 = '1'
            OR QUARTER_3 = '1' THEN '2021'
            WHEN QUARTER_4 = '1' THEN '2022'
          END [YEAR],
CASE
            WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'TDG'
            ELSE Substring(
              CURRENT_INSPECTOR,
              1,
              Charindex(',', CURRENT_INSPECTOR) -1
            )
          END [InspectorLastName],
          CASE
            WHEN Charindex(',', CURRENT_INSPECTOR) = 0 THEN 'CORE'
            ELSE Substring(
              CURRENT_INSPECTOR,
              Charindex(',', CURRENT_INSPECTOR) + 1,
              LEN(CURRENT_INSPECTOR)
            )
          END [InspectorFirstName],
          *
        FROM
          SOURCE__WORKPLAN_IMPORT WP
        WHERE
          CURRENTLY_PLANNED = '1'
          AND fiscal_year = '2021-2022'
      ) WP
      JOIN STAGING__ACCOUNT ACCOUNTS ON WP.IIS_ID = ACCOUNTS.ovs_iisid
      JOIN [dbo].SOURCE__FISCAL_YEAR FY ON WP.[YEAR] = FY.tc_fiscalyearnum
      JOIN [dbo].SOURCE__FISCAL_QUARTER FQ ON FQ.tc_name = WP.[QUARTER]
      AND FQ.tc_tcfiscalyearidname = WP.fiscal_year
      LEFT JOIN [dbo].tdgdata__bookableresource BR ON UPPER(
        TRIM(
          CONCAT(
            CONCAT(WP.InspectorFirstName, ' '),
            WP.InspectorLastName
          )
        )
      ) = UPPER(BR.name)
      AND import_number NOT IN (
        --WORKPLAN INSPECTIONS CREATED IN IIS ALREADY
        --IGNORE TO PREVENT DOUBLES
        SELECT
          import_number
        FROM
          (
            SELECT
              *,
              CASE
                WHEN QUARTER_1 = '1' THEN 'Q1'
                WHEN QUARTER_2 = '1' THEN 'Q2'
                WHEN QUARTER_3 = '1' THEN 'Q3'
                WHEN QUARTER_4 = '1' THEN 'Q4'
              END [QUARTER]
            FROM
              [dbo].SOURCE__WORKPLAN_IMPORT
          ) WP
          JOIN STAGING__WORK_ORDERS WO ON WP.IIS_ID = WO.ovs_iisid
          AND WP.fiscal_year = WO.ovs_fiscalyearname
          AND WP.QUARTER = WO.ovs_fiscalquartername
        WHERE
          WP.fiscal_year = '2021-2022'
      )
  ) CURRENT_WORKPLAN;


--TODO: BOOKABLE RESOURCE BOOKINGS
--CONTACT
INSERT INTO
  [dbo].STAGING__CONTACT (
    [Id],
    [contactid],            --owner
    [owningbusinessunit],
    [owninguser],
    [ownerid],
    [owneridtype],          --contact
    [emailaddress1],
    [telephone1],
    [telephone2],
    [telephone3],           --account
    [accountid],
    [company],
    [parentcustomeridtype], --identifiaction
    [firstname],
    [lastname],
    [fullname]
    --,[jobtitle]
  )
SELECT
  contactid,                                        --id
  contactid,                                        --owner
  @CONST_TDG_BUSINESSUNITID [OWNING_BUSINESS_UNIT], --TDG Business Unit
  @CONST_TDGCORE_USERID         [OWNING_TEAM],          --OWNING TEAM = TDG Team
  @CONST_TDGCORE_USERID         [OWNER],                --OWNER = primary inspector
  @CONST_OWNERIDTYPE_SYSTEMUSER   [OWNER_TYPE],           --OWNER TYPE = systemuser
  CONTACT_EMAIL,
  CONTACT_BUSINESS_PHONE,
  CONTACT_TFH,
  CONTACT_PHONE,                                    --account
  accountid,
  accountid company,
  'account' parentcustomeridtype,                   --identification
  CONTACT_FIRST_NAME,
  LEFT(CONTACT_LAST_NAME, 50) CONTACT_LAST_NAME,
  USER_CONTACT              [fullname]
FROM
  (
    SELECT
      NEWID() contactid,
      ACCOUNTS.accountid,
      ACCOUNTS.name,
      IIS.CONTACT_BUSINESS_PHONE,
      IIS.CONTACT_EMAIL,
      IIS.CONTACT_PHONE,
      IIS.CONTACT_TFH,
      IIS.USER_CONTACT,
CASE
        WHEN Charindex(' ', USER_CONTACT) = 0 THEN 'TDG'
        ELSE TRIM(
          Substring(USER_CONTACT, 1, Charindex(' ', USER_CONTACT) -1)
        )
      END CONTACT_FIRST_NAME,
      CASE
        WHEN Charindex(' ', USER_CONTACT) = 0 THEN 'CORE'
        ELSE TRIM(
          Substring(
            USER_CONTACT,
            Charindex(' ', USER_CONTACT) + 1,
            LEN(USER_CONTACT)
          )
        )
      END CONTACT_LAST_NAME
    FROM
      [dbo].STAGING__ACCOUNT ACCOUNTS
      JOIN [dbo].SOURCE__IIS_EXPORT IIS ON ACCOUNTS.ovs_iisid = IIS.STAKEHOLDER_ID
    WHERE
      IIS.USER_CONTACT <> ''
      AND IIS.USER_CONTACT IS NOT NULL
  ) T;


UPDATE
  STAGING__CONTACT
SET
  parentcustomeridtype = 'account';


--Set contacts to primary contact of the account
--SELECT * FROM STAGING__ACCOUNT;
UPDATE
  STAGING__ACCOUNT
SET
  primarycontactid = t1.contactid,
  ovs_primarycontactemail = t1.emailaddress1,
  ovs_primarycontactphone = t1.telephone1
FROM
  STAGING__CONTACT t1
  JOIN STAGING__ACCOUNT t2 ON t1.accountid = t2.accountid --set the parent company of the contact records;
UPDATE
  STAGING__CONTACT
SET
  accountid = T1.Id,
  company = t1.Id
FROM
  STAGING__ACCOUNT t1
  JOIN STAGING__CONTACT t2 ON t1.Id = t2.accountid
  AND t1.Id = T2.accountid

  --Violations (qm_syresults)
  --not all legislation from IIS are mapped to ROM, but migrate the matches we do have
  --SELECT * FROM [20_LEGISLATION_MATCHING];
  --=========================================================================================================
  --=========================================================================================================
  DROP TABLE IF EXISTS #TEMP_INSPECTIONS;

  --get violations into temp table
SELECT
  YD095.FILE_NUMBER_NUM,
  TD001.FILE_STATUS_ETXT,
  TD001.FILE_STATUS_FTXT,
  TD045.ACTIVITY_TYPE_ENM,
  TD045.ACTIVITY_TYPE_FNM,
  YD040.INSPECTION_DATE_DTE,
  YD040.ACTIVITY_ID,
  YD040.STAKEHOLDER_ID,
  TD045.ACTIVITY_TYPE_CD,
  TD038.INSPECTION_REASON_ETXT,
  TD038.INSPECTION_REASON_FTXT,
  VIOLATIONS.VIOLATION_CD,
  VIOLATIONS.VIOLATION_COMMENTS_TXT,
  VIOLATIONS.MOC_SERIAL_NUMBER_NUM,
  VIOLATIONS.MOC_TYPE_CD,
  VIOLATIONS.MOC_VIOLATION_COMMENTS_TXT,
  VIOLATIONS.TDG_SPECIFICATION_CD,
  VIOLATIONS.UN_NUMBER_ID --,ENFORCEMENT_ACTIONS.ENFORCEMENT_ACTION_TYPE_CD
  INTO #TEMP_INSPECTIONS
FROM
  YD040_ACTIVITY YD040
  INNER JOIN YD095_STAKEHOLDER_FILE YD095 ON YD040.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM
  INNER JOIN YD101_FILE_ACTIVITY_TYPE YD101 ON YD101.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM
  AND YD101.DATE_DELETED_DTE IS NULL
  INNER JOIN TD045_ACTIVITY_TYPE TD045 ON YD101.ACTIVITY_TYPE_CD = TD045.ACTIVITY_TYPE_CD
  INNER JOIN TD001_FILE_STATUS TD001 ON YD095.FILE_STATUS_CD = TD001.FILE_STATUS_CD
  LEFT JOIN YD041_INSPECTION YD041 ON YD040.ACTIVITY_ID = YD041.ACTIVITY_ID
  LEFT JOIN TD038_INSPECTION_REASON TD038 ON YD041.INSPECTION_REASON_CD = TD038.INSPECTION_REASON_CD
  LEFT JOIN (
    SELECT
      YD020.ACTIVITY_ID,
      YD020.VIOLATION_CD,
      YD020.VIOLATION_COMMENTS_TXT,
      YD021.MOC_SERIAL_NUMBER_NUM,
      YD021.MOC_TYPE_CD,
      YD021.MOC_VIOLATION_COMMENTS_TXT,
      YD021.TDG_SPECIFICATION_CD,
      YD021.UN_NUMBER_ID
    FROM
      YD020_INSPECTION_VIOLATION YD020
      LEFT JOIN YD021_MOCLIST YD021 ON YD020.ACTIVITY_ID = YD021.ACTIVITY_ID
      AND YD020.VIOLATION_CD = YD021.VIOLATION_CD
    WHERE
      YD020.DATE_DELETED_DTE IS NULL
  ) VIOLATIONS ON VIOLATIONS.ACTIVITY_ID = YD040.ACTIVITY_ID --LEFT JOIN
  --(
  --    SELECT YD023.ACTIVITY_ID,
  --    YD023.ENFORCEMENT_ACTION_TYPE_CD
  --    FROM YD023_VIOL_ENFORCEMENT_ACTION YD023
  --    WHERE YD023.DATE_DELETED_DTE IS NULL
  --    GROUP BY YD023.ACTIVITY_ID, YD023.ENFORCEMENT_ACTION_TYPE_CD
  --) ENFORCEMENT_ACTIONS ON ENFORCEMENT_ACTIONS.ACTIVITY_ID = YD040.ACTIVITY_ID
WHERE
  YD040.DATE_DELETED_DTE IS NULL
  AND YD095.DATE_DELETED_DTE IS NULL
  AND YD041.DATE_DELETED_DTE IS NULL
  AND YD101.DATE_DELETED_DTE IS NULL --AND TD045.ACTIVITY_TYPE_PARENT_CD IS NULL
GROUP BY
  YD095.FILE_NUMBER_NUM,
  TD001.FILE_STATUS_ETXT,
  TD001.FILE_STATUS_FTXT,
  TD045.ACTIVITY_TYPE_ENM,
  TD045.ACTIVITY_TYPE_FNM,
  YD040.INSPECTION_DATE_DTE,
  YD040.ACTIVITY_ID,
  YD040.STAKEHOLDER_ID,
  TD045.ACTIVITY_TYPE_CD,
  TD038.INSPECTION_REASON_ETXT,
  TD038.INSPECTION_REASON_FTXT,
  VIOLATIONS.VIOLATION_CD,
  VIOLATIONS.VIOLATION_COMMENTS_TXT,
  VIOLATIONS.MOC_SERIAL_NUMBER_NUM,
  VIOLATIONS.MOC_TYPE_CD,
  VIOLATIONS.MOC_VIOLATION_COMMENTS_TXT,
  VIOLATIONS.TDG_SPECIFICATION_CD,
  VIOLATIONS.UN_NUMBER_ID;


DROP TABLE IF EXISTS #TEMP_VIOLATIONS;
SELECT
  ACTIVITY_ID,
  STAKEHOLDER_ID,
  T3.LegislationId,
  T3.Label,
  T3.Name,
  T3.[English Text],
  T1.VIOLATION_CD,
  T1.VIOLATION_COMMENTS_TXT,
  T1.MOC_SERIAL_NUMBER_NUM,
  T1.MOC_TYPE_CD,
  T1.MOC_VIOLATION_COMMENTS_TXT,
  T1.TDG_SPECIFICATION_CD,
  T1.UN_NUMBER_ID,
  T2.VIOLATION_REFERENCE_CD,
  T4.msdyn_workorderid,
  CAST(T4.msdyn_workordersummary AS nvarchar(4000)) msdyn_workordersummary,
  T4.msdyn_address1,
  T4.msdyn_address2,
  T4.msdyn_address3,
  T4.msdyn_addressname,
  T4.msdyn_name,
  T4.msdyn_postalcode,
  T4.msdyn_serviceaccount,
  T4.msdyn_serviceterritory,
  T4.ovs_iisid,
  T4.qm_reportcontactid INTO #TEMP_VIOLATIONS
FROM
  #TEMP_INSPECTIONS T1
  JOIN [dbo].[TD070_VIOLATION] T2 ON T1.VIOLATION_CD = T2.VIOLATION_CD
  JOIN SOURCE__LEGISLATION_MATCHING T3 ON T2.VIOLATION_CD = T3.VIOLATION_CD
  JOIN STAGING__WORK_ORDERS T4 ON CAST(T4.msdyn_workordersummary AS nvarchar(MAX)) = CAST(T1.ACTIVITY_ID AS nvarchar(MAX));


INSERT INTO
  [dbo].STAGING__VIOLATIONS (
    [qm_syresultid],
    [qm_externalcomments],
    [qm_internalcomments],
    [qm_isviolation],
    [qm_name],
    [qm_rclegislationid],
    [qm_referenceid],
    [qm_violationcount],
    [qm_workorderid],
    [ownerid],
    [owneridtype],
    [owningbusinessunit],
    [owninguser]
  )
SELECT
  newid(),
  CASE
    WHEN MOC_VIOLATION_COMMENTS_TXT IS NULL
    OR TRIM(MOC_VIOLATION_COMMENTS_TXT) = '' THEN VIOLATION_COMMENTS_TXT
    ELSE CONCAT(
      T1.VIOLATION_COMMENTS_TXT,
      CHAR(13) + CHAR(10),
      'MOC',
      CHAR(13) + CHAR(10),
      T1.MOC_VIOLATION_COMMENTS_TXT
    )
  END,
  CONCAT(
    CASE
      WHEN MOC_SERIAL_NUMBER_NUM IS NULL THEN ''
      ELSE CONCAT(
        'MOC_SERIAL_NUMBER_NUM=',
        MOC_SERIAL_NUMBER_NUM,
        ';'
      )
    END,
    CASE
      WHEN MOC_TYPE_CD IS NULL THEN ''
      ELSE CONCAT('MOC_TYPE_CD=', MOC_TYPE_CD, ';')
    END,
    CASE
      WHEN TDG_SPECIFICATION_CD IS NULL THEN ''
      ELSE CONCAT(
        'TDG_SPECIFICATION_CD=',
        TDG_SPECIFICATION_CD,
        ';'
      )
    END,
    CASE
      WHEN UN_NUMBER_ID IS NULL THEN ''
      ELSE CONCAT('UN_NUMBER_ID=', UN_NUMBER_ID, ';')
    END
  ),
  1,
  CASE
    WHEN MOC_SERIAL_NUMBER_NUM IS NULL
    OR TRIM(MOC_SERIAL_NUMBER_NUM) = '' THEN TRIM([Label])
    ELSE CONCAT(TRIM([Label]), ' - ', MOC_SERIAL_NUMBER_NUM)
  END,
  LegislationId,
  MOC_SERIAL_NUMBER_NUM,
  1,
  msdyn_workorderid,
  @CONST_TDGCORE_USERID [ownerid],
  @CONST_OWNERIDTYPE_SYSTEMUSER [owneridtype],
  @CONST_TDG_BUSINESSUNITID [owningbusinessunit],
  @CONST_TDGCORE_USERID [owninguser]
FROM
  (
    SELECT
      DISTINCT *
    FROM
      #TEMP_VIOLATIONS
  ) T1