/****** Script for SelectTopNRows command from SSMS  ******/

TRUNCATE TABLE [11_CONTACT];
INSERT INTO [dbo].[11_CONTACT]
	   (
	   --id
	   [Id]
      ,[contactid]
      ,[accountid]
	  
	  --owner
	  ,[owningbusinessunit]
      ,[owningteam]
      ,[ownerid]
      ,[owneridtype]

      ,[emailaddress1]
      
	  --contact
      ,[telephone1]
      ,[telephone2]
      ,[telephone3]

	  --account
      ,[company]
	  ,[parentcustomeridtype]

	  --identifiaction
	  ,[firstname]
      ,[lastname]
      ,[fullname]
      --,[jobtitle]
)
SELECT 
	
	--id
	contactid id, contactid, id accountid, 
	
	--owner
	'4E122E0C-73F3-EA11-A815-000D3AF3AC0D'												[OWNING_BUSINESS_UNIT]	--TDG Business Unit
	--,PRIMARY_INSPECTOR_BOOKABLE_RESOURCE_ID											[owning_user]			--owning user is the primary inspector
	,'D0483132-B964-EB11-A812-000D3AF38846'												[OWNING_TEAM]			--OWNING TEAM = TDG Team
	,'D0483132-B964-EB11-A812-000D3AF38846'												[OWNER]					--OWNER = primary inspector
	,'team'																				[OWNER_TYPE]			--OWNER TYPE = systemuser
	
	--contact
	,CONTACT_EMAIL
	
	--phones
	,CONTACT_BUSINESS_PHONE
	,CONTACT_TFH
	,CONTACT_PHONE

	--account
	,id accountname
	,'account' parentcustomeridtype
	
	--identification
	,CONTACT_FIRST_NAME, 
	LEFT(CONTACT_LAST_NAME, 50) CONTACT_LAST_NAME,  
	USER_CONTACT [fullname]
FROM
(
	SELECT NEWID() contactid, ACCOUNTS.id, ACCOUNTS.name, IIS.CONTACT_BUSINESS_PHONE, IIS.CONTACT_EMAIL, IIS.CONTACT_PHONE, IIS.CONTACT_TFH, IIS.USER_CONTACT

	,CASE 
		WHEN Charindex(' ', USER_CONTACT) = 0 THEN 'TDG'
		ELSE TRIM(Substring(USER_CONTACT, 1,Charindex(' ', USER_CONTACT)-1))
	END CONTACT_FIRST_NAME,
		
	CASE 
		WHEN Charindex(' ', USER_CONTACT) = 0 THEN 'CORE'
		ELSE TRIM(Substring(USER_CONTACT, Charindex(' ', USER_CONTACT)+1, LEN(USER_CONTACT)))
	END CONTACT_LAST_NAME


	FROM [dbo].[04_ACCOUNT] ACCOUNTS
	JOIN [dbo].[10_IIS_EXPORT] IIS ON ACCOUNTS.ovs_iisid = IIS.STAKEHOLDER_ID
	WHERE IIS.USER_CONTACT <> '' and IIS.USER_CONTACT IS NOT NULL
) T;


UPDATE [11_CONTACT] 
SET parentcustomeridtype = 'account';


--Set contacts to primary contact of the account
update [04_ACCOUNT]
SET primarycontactid = t1.Id
FROM [11_CONTACT] t1
JOIN [04_ACCOUNT] t2 on t1.accountid = t2.id;