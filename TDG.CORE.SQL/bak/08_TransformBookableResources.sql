TRUNCATE TABLE [dbo].[bookableresource];


INSERT INTO [dbo].[bookableresource]
           ([userid]
           ,[name]
           ,[msdyn_primaryemail]
           ,[id]
           ,[ovs_registeredinspectornumberrin]
           ,[ovs_badgenumber])

SELECT SYSUSER.systemuserid, SYSUSER.fullname, domainname, newid() bookableresourceid, RIN, BADGE FROM [dbo].systemuser SYSUSER 
JOIN [16_IIS_INSPECTORS] INSP ON lower(INSP.Account_name) = lower(SYSUSER.domainname);



UPDATE [dbo].[bookableresource]
SET 
owningbusinessunit = '4e122e0c-73f3-ea11-a815-000d3af3ac0d',
owneridtype = 'team',
ownerid = 'd0483132-b964-eb11-a812-000d3af38846',
owningteam = 'd0483132-b964-eb11-a812-000d3af38846',
resourcetype = 3,
statecode = 0,
statuscode = 1,
msdyn_derivecapacity = 0,
msdyn_displayonscheduleassistant = 1,
msdyn_displayonscheduleboard = 1,
msdyn_enabledforfieldservicemobile = 1,
msdyn_enabledripscheduling = 0,
msdyn_endlocation = 690970002, --location agnostic
msdyn_startlocation = 690970002, --location agnostic
msdyn_timeoffapprovalrequired = 0;


---ADD "INSPECTOR" category to all inspectors
TRUNCATE TABLE [18_BOOKABLE_RESOURCE_CATEGORY_ASSN];

INSERT INTO [18_BOOKABLE_RESOURCE_CATEGORY_ASSN]
(resource, resourcecategory, statecode, statuscode, owningbusinessunit, owneridtype, ownerid , owningteam)

SELECT 
bookableresourceid, 
resourcecategory = '06DB6E56-01F9-EA11-A815-000D3AF3AC0D', --INSPECTOR 
statecode = 0, 
statuscode = 1, 
owningbusinessunit = '4e122e0c-73f3-ea11-a815-000d3af3ac0d',
owneridtype = 'team',
ownerid = 'd0483132-b964-eb11-a812-000d3af38846',
owningteam = 'd0483132-b964-eb11-a812-000d3af38846' FROM [dbo].[bookableresource]; 

