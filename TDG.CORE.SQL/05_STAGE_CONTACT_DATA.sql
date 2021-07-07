IF EXISTS (
	SELECT
		*
	FROM
		sys.objects
	WHERE
		object_id = OBJECT_ID( '[dbo].[STAGING__CONTACT]')
		AND TYPE IN ('U')
) DROP TABLE [dbo].[STAGING__CONTACT];
GO

	CREATE TABLE [dbo].[STAGING__CONTACT](
		[accountid] [uniqueidentifier] NULL,
		[accountrolecode] [int] NULL,
		[address1_addresstypecode] [int] NULL,
		[address1_city] [nvarchar](80) NULL,
		[address1_country] [nvarchar](80) NULL,
		[address1_latitude] [decimal](38, 5) NULL,
		[address1_line1] [nvarchar](250) NULL,
		[address1_line2] [nvarchar](250) NULL,
		[address1_line3] [nvarchar](250) NULL,
		[address1_postalcode] [nvarchar](20) NULL,
		[address1_postofficebox] [nvarchar](20) NULL,
		[address1_primarycontactname] [nvarchar](100) NULL,
		[address1_stateorprovince] [nvarchar](50) NULL,
		[address1_telephone1] [nvarchar](50) NULL,
		[company] [nvarchar](50) NULL,
		[contactid] [uniqueidentifier] NULL,
		[customertypecode] [int] NULL,
		[emailaddress1] [nvarchar](100) NULL,
		[firstname] [nvarchar](50) NULL,
		[fullname] [nvarchar](160) NULL,
		[Id] [uniqueidentifier] NOT NULL,
		[jobtitle] [nvarchar](100) NULL,
		[lastname] [nvarchar](50) NULL,
		[mobilephone] [nvarchar](50) NULL,
		[ownerid] [uniqueidentifier] NULL,
		[owneridtype] [nvarchar](4000) NULL,
		[owningbusinessunit] [uniqueidentifier] NULL,
		[owningteam] [uniqueidentifier] NULL,
		[owninguser] [uniqueidentifier] NULL,
		parentcustomeridtype nvarchar(4000) NULL,
		[statecode] [int] NULL,
		[statuscode] [int] NULL,
		[telephone1] [nvarchar](50) NULL,
		[telephone2] [nvarchar](50) NULL,
		[telephone3] [nvarchar](50) NULL
	) ON [PRIMARY];
	GO
	
	
	--DECLARE CONSTANTS
--===================================================================================================

	--=============================================DYNAMIC VALUES===========================================
	DECLARE @CONST_TDGCORE_DOMAINNAME  VARCHAR(50)  = 'tdg.core@034gc.onmicrosoft.com';
	DECLARE @CONST_TDGCORE_USERID      VARCHAR(50)  = (SELECT systemuserid FROM CRM__SYSTEMUSER  where domainname = 'tdg.core@034gc.onmicrosoft.com');
	DECLARE @CONST_TEAM_TDG_ID          VARCHAR(500) = (SELECT teamid FROM CRM__TEAM WHERE name = 'Transportation of Dangerous Goods');
	DECLARE @CONST_BUSINESSUNIT_TDG_ID VARCHAR(50)  = (SELECT businessunitid FROM CRM__BUSINESSUNIT WHERE name = 'Transportation of Dangerous Goods');
	

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

	--TERRITORIES / REGIONS
	DECLARE @CONST_TERRITORY_HQ_ES                       VARCHAR(50) = '2e7b2f75-989c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_TERRITORY_HQ_CR                       VARCHAR(50) = '52c72783-989c-eb11-b1ac-000d3ae92708';
	DECLARE @CONST_TERRITORY_ATLANTIC                    VARCHAR(50) = 'FAB76E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_QUEBEC                      VARCHAR(50) = 'FCB76E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_PACIFIQUE                   VARCHAR(50) = 'FEB76E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_PNR                         VARCHAR(50) = '02B86E9E-1707-EB11-A813-000D3AF3A0D7';
	DECLARE @CONST_TERRITORY_ONTARIO                     VARCHAR(50) = '50B21A84-DB04-EB11-A813-000D3AF3AC0D';
--===================================================================================================

DROP TABLE IF EXISTS #TEMP_CONTACT_LIST;
SELECT 
YD092.STAKEHOLDER_ID,
YD092.STAKEHOLDER_CONTACT_ID,
CONCAT(YD083.STAKEHOLDER_NAME_FIRST_NM,' ',YD083.STAKEHOLDER_NAME_FAMILY_NM) USER_CONTACT,
YD091.CONTACT_TYPE_CD,
YD091.CONTACT_TXT,
YD099.CONTACT_POSITION_TITLE_TXT,
YD099.CONTACT_ROLE_CD,
YD099.SHOW_CONTACT_IN_REPORT_IND,
YD099.ACTIVITY_ID
INTO #TEMP_CONTACT_LIST
FROM YD092_STAKEHOLDER_ORG_PERS YD092
JOIN YD075_INDIVIDUAL YD075 ON YD092.STAKEHOLDER_CONTACT_ID = YD075.STAKEHOLDER_ID
JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON YD075.STAKEHOLDER_ID = YD083.STAKEHOLDER_ID
JOIN YD091_STAKEHOLDER_CONTACT YD091 ON YD091.STAKEHOLDER_ID = YD075.STAKEHOLDER_ID
LEFT JOIN YD099_ACTIVITY_SITE_CONTACT YD099 ON YD075.STAKEHOLDER_ID = YD099.STAKEHOLDER_ID
WHERE 
YD075.DATE_DELETED_DTE     IS NULL
AND YD083.DATE_DELETED_DTE IS NULL
AND YD091.DATE_DELETED_DTE IS NULL
AND YD092.DATE_DELETED_DTE IS NULL;



SELECT STAKEHOLDER_CONTACT_ID, CONTACT_TXT INTO #PEXT FROM #TEMP_CONTACT_LIST WHERE CONTACT_TYPE_CD = 'PEXT';
SELECT STAKEHOLDER_CONTACT_ID, CONTACT_TXT INTO #PHONE FROM #TEMP_CONTACT_LIST WHERE CONTACT_TYPE_CD = 'PHONE';
SELECT STAKEHOLDER_CONTACT_ID, CONTACT_TXT INTO #EMAIL FROM #TEMP_CONTACT_LIST WHERE CONTACT_TYPE_CD = 'EMAIL';
SELECT STAKEHOLDER_CONTACT_ID, CONTACT_TXT INTO #TFH FROM #TEMP_CONTACT_LIST WHERE CONTACT_TYPE_CD = '24H';
SELECT STAKEHOLDER_CONTACT_ID, CONTACT_TXT INTO #BUSINESS FROM #TEMP_CONTACT_LIST WHERE CONTACT_TYPE_CD = 'BUSINESS';
SELECT STAKEHOLDER_CONTACT_ID, CONTACT_TXT INTO #MOBILE FROM #TEMP_CONTACT_LIST WHERE CONTACT_TYPE_CD = 'MOBILE';
SELECT STAKEHOLDER_CONTACT_ID, CONTACT_TXT INTO #URL FROM #TEMP_CONTACT_LIST WHERE CONTACT_TYPE_CD = 'URL';

SELECT * FROM #TEMP_CONTACT_LIST T1
LEFT JOIN #PEXT ON T1.STAKEHOLDER_CONTACT_ID = #PEXT.STAKEHOLDER_CONTACT_ID
LEFT JOIN #PHONE ON T1.STAKEHOLDER_CONTACT_ID = #PHONE.STAKEHOLDER_CONTACT_ID
LEFT JOIN #EMAIL ON T1.STAKEHOLDER_CONTACT_ID = #EMAIL.STAKEHOLDER_CONTACT_ID
LEFT JOIN #TFH ON T1.STAKEHOLDER_CONTACT_ID = #TFH.STAKEHOLDER_CONTACT_ID
LEFT JOIN #BUSINESS ON T1.STAKEHOLDER_CONTACT_ID = #BUSINESS.STAKEHOLDER_CONTACT_ID
LEFT JOIN #MOBILE ON T1.STAKEHOLDER_CONTACT_ID = #MOBILE.STAKEHOLDER_CONTACT_ID
LEFT JOIN #URL ON T1.STAKEHOLDER_CONTACT_ID = #URL.STAKEHOLDER_CONTACT_ID



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
    ,[jobtitle]
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
  AND t1.Id = T2.accountid;


  select count(*) COUNTOF_STAGING__CONTACT from STAGING__CONTACT;
