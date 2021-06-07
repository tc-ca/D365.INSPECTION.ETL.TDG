--DECLARE CONSTANTS
--===================================================================================================
--===================================================================================================
BEGIN 

	--=============================================DYNAMIC VALUES===========================================
	--these variables can change with the environment, so double check these match the environment you're syncing to

	--DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
	--DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = (SELECT ID FROM tdgdata__systemuser  where domainname = 'tdg.core@034gc.onmicrosoft.com');
	--DECLARE @CONST_TEAM_QUEBEC_ID      VARCHAR(50)  = (SELECT teamid FROM tdgdata__team    WHERE name = 'Quebec');
	--DECLARE @CONST_TEAM_TDG_NAME       VARCHAR(500) = (SELECT teamid FROM tdgdata__team    WHERE name = 'Transportation of Dangerous Goods');
	--DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = (SELECT ID FROM TDGDATA__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
	--DECLARE @CONST_PRICELISTID         VARCHAR(50)  = (SELECT ID FROM tdgdata__pricelevel  WHERE NAME = 'Base Prices');

	--SELECT @CONST_TDGCORE_DOMAINNAME TDGCORE_DOMAINNAME, @CONST_TDGCORE_USERID TDGCORE_USERID, @CONST_TEAM_QUEBEC_ID TEAM_QUEBEC_ID, @CONST_TEAM_TDG_NAME TEAM_TDG_NAME, @CONST_BUSINESSUNIT_TDG_ID BUSINESSUNIT_TDG_ID, @CONST_PRICELISTID PRICELISTID;
	
	
	--RUN THIS IN XRMTOOLBOX SQL4CDS TO GET VALUES FOR ENVIRONMENT
	--===================================================================================================
	--SELECT 'systemuserid' field, systemuserid id FROM systemuser where domainname = 'tdg.core@034gc.onmicrosoft.com';
	--SELECT 'teamid' field, teamid id FROM team    WHERE name = 'Transportation of Dangerous Goods';
	--SELECT 'BUSINESSUNITID' field, BUSINESSUNITID id FROM BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods';
	--SELECT 'pricelevelid' field, pricelevelid id FROM pricelevel  WHERE NAME = 'Base Prices';
	--===================================================================================================

	DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = '15abdd9e-8edd-ea11-a814-000d3af3afe0';
	DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = '4e122e0c-73f3-ea11-a815-000d3af3ac0d';
	DECLARE @CONST_PRICELISTID         VARCHAR(50)  = 'b92b6a16-7cf7-ea11-a815-000d3af3a7a7';

	--CRM CONSTANTS
	DECLARE @CONST_OWNERIDTYPE_TEAM VARCHAR(50)			= 'team';
	DECLARE @CONST_OWNERIDTYPE_SYSTEMUSER VARCHAR(50)	= 'systemuser';
	--===================================================================================================


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
	

END
--===================================================================================================
--===================================================================================================



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
  @CONST_BUSINESSUNIT_TDG_ID [OWNING_BUSINESS_UNIT], --TDG Business Unit
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