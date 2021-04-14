DROP TABLE IF EXISTS TD038_INSPECTION_REASON;
CREATE TABLE TD038_INSPECTION_REASON (
    [DATE_CREATED_DTE] DATETIME,
    [DATE_CURRENT_DTE] DATETIME,
    [DATE_DELETED_DTE] DATETIME,
    [DATE_LAST_UPDATE_DTE] DATETIME,
    [INSPECTION_REASON_CD] VARCHAR(20),
    [INSPECTION_REASON_ETXT] VARCHAR(250),
    [INSPECTION_REASON_FTXT] VARCHAR(250),
    [USER_STAKEHOLDER_ID] DECIMAL(29, 0)
)

DROP TABLE IF EXISTS TD045_ACTIVITY_TYPE;
CREATE TABLE TD045_ACTIVITY_TYPE (
    [ACTIVITY_TYPE_CD] VARCHAR(20),
    [ACTIVITY_TYPE_ENM] VARCHAR(250),
    [ACTIVITY_TYPE_ETXT] VARCHAR(250),
    [ACTIVITY_TYPE_FILE_PREFIX_TXT] VARCHAR(20),
    [ACTIVITY_TYPE_FNM] VARCHAR(250),
    [ACTIVITY_TYPE_FXT] VARCHAR(250),
    [ACTIVITY_TYPE_PARENT_CD] VARCHAR(20),
    [DATE_CREATED_DTE] DATETIME,
    [DATE_CURRENT_DTE] DATETIME,
    [DATE_DELETED_DTE] DATETIME,
    [DATE_LAST_UPDATE_DTE] DATETIME,
    [MULTIPLE_SUBCATEGORIES_IND] SMALLINT,
    [USER_STAKEHOLDER_ID] DECIMAL(29, 0)
)

DROP TABLE IF EXISTS "TD001_FILE_STATUS";
CREATE TABLE "TD001_FILE_STATUS" (
    [DATE_CREATED_DTE] DATETIME,
    [DATE_CURRENT_DTE] DATETIME,
    [DATE_DELETED_DTE] DATETIME,
    [DATE_LAST_UPDATE_DTE] DATETIME,
    [FILE_STATUS_CD] VARCHAR(20),
    [FILE_STATUS_ETXT] VARCHAR(50),
    [FILE_STATUS_FTXT] VARCHAR(50),
    [USER_STAKEHOLDER_ID] DECIMAL(29, 0)
)

--------------------------------------------------------
--  DDL for Table TD070_VIOLATION
--------------------------------------------------------
  DROP TABLE IF EXISTS "TD070_VIOLATION";
  CREATE TABLE "TD070_VIOLATION" 
   (	
    "VIOLATION_CD" NUMERIC, 
	"VIOLATION_SOURCE_CD" NVARCHAR(10), 
	"VIOLATION_REFERENCE_CD" NVARCHAR(20), 
	"VIOLATION_ETXT" NVARCHAR(550), 
	"VIOLATION_FTXT" NVARCHAR(550), 
	"ORDER_VIOLATION_CD" NUMERIC, 
	"AVERAGE_VIOLATION_NBR" NUMERIC, 
	"DATE_EFFECTIVE_DTE" DATETIME , 
	"DATE_REVOCATION_DTE" DATETIME, 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );


--------------------------------------------------------
--  DDL for Table TD071_ACT_REFERENCE
--------------------------------------------------------
  DROP TABLE IF EXISTS "TD071_ACT_REFERENCE";
  CREATE TABLE "TD071_ACT_REFERENCE" 
   (	
    "VIOLATION_CD" NUMERIC, 
	"ACT_REFERENCE_CD" NVARCHAR(20), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );


   --------------------------------------------------------
--  DDL for Table YD020_INSPECTION_VIOLATION
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD020_INSPECTION_VIOLATION";
  CREATE TABLE "YD020_INSPECTION_VIOLATION" 
   (	
    "ACTIVITY_ID" NUMERIC, 
	"VIOLATION_CD" NUMERIC, 
	"VIOLATION_COMMENTS_TXT" NVARCHAR(4000), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );


   --------------------------------------------------------
--  DDL for Table YD021_MOCLIST
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD021_MOCLIST";
  CREATE TABLE "YD021_MOCLIST" 
   (	
    "ACTIVITY_ID" NUMERIC, 
	"MOCLIST_ORDINAL_SEQ_NUM" NUMERIC, 
	"MOC_TYPE_CD" NVARCHAR(20), 
	"MOC_FILL_CONDITION_CD" NVARCHAR(20), 
	"ITEM_INITIAL_CD" NVARCHAR(50), 
	"MOC_SERIAL_NUMBER_NUM" NVARCHAR(50), 
	"UN_NUMBER_ID" NVARCHAR(7), 
	"UN_SEQ_NUM" NUMERIC, 
	"TDG_SPECIFICATION_CD" NVARCHAR(20), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC, 
	"VIOLATION_CD" NUMERIC, 
	"MOC_VIOLATION_COMMENTS_TXT" NVARCHAR(4000)
   );


   --------------------------------------------------------
--  DDL for Table YD023_VIOL_ENFORCEMENT_ACTION
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD023_VIOL_ENFORCEMENT_ACTION";
  CREATE TABLE "YD023_VIOL_ENFORCEMENT_ACTION" 
   (	
    "ACTIVITY_ID" NUMERIC, 
	"VIOLATION_CD" NUMERIC, 
	"ENFORCEMENT_ACTION_TYPE_CD" NVARCHAR(20), 
	"DATE_ACTION_TAKEN_DTE" DATETIME, 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC, 
	"DATE_ACTION_CLOSED_DTE" DATETIME
   );


--------------------------------------------------------
--  DDL for Table YD030_STAKEHOLDER_HOTI
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD030_STAKEHOLDER_HOTI";
  CREATE TABLE "YD030_STAKEHOLDER_HOTI" 
   (	
    "STAKEHOLDER_ID" NUMERIC, 
	"STKHLDR_HOTI_SEQ_NUM" NUMERIC, 
	"PRIORITY_CHANGE_REASON_TXT" NVARCHAR(4000), 
	"SITE_PRIORITY_CD" NUMERIC(18,0), 
	"HOTI_ON_SITE_IND" BIT, 
	"HOTI_OUT_IND" BIT, 
	"LARGE_MOC_ON_SITE_IND" BIT, 
	"DATE_CREATED_DTE" DATETIME, 
	"DATE_CURRENT_DTE" DATETIME, 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC, 
	"OHS_COMMENT_TXT" NVARCHAR(4000), 
	"OHS_CHECKLIST_RDIMS_NUM" NUMERIC(20,0)
   );



--------------------------------------------------------
--  DDL for Table YD032_STAKEHOLDER_MODE_PROFILE
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD032_STAKEHOLDER_MODE_PROFILE";
  CREATE TABLE "YD032_STAKEHOLDER_MODE_PROFILE" 
   (	
    "TRANSPORT_MODE_CD" NVARCHAR(20), 
	"STAKEHOLDER_ID" NUMERIC, 
	"STKHLDR_MODE_PROFILE_SEQ_NUM" NUMERIC, 
	"DATE_CREATED_DTE" DATETIME, 
	"DATE_CURRENT_DTE" DATETIME, 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );



--------------------------------------------------------
--  DDL for Table YD033_STAKEHOLDER_CLASS_PROFIL
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD033_STAKEHOLDER_CLASS_PROFIL";
  CREATE TABLE "YD033_STAKEHOLDER_CLASS_PROFIL" 
   (	
    "HAZARD_CLASS_DIVISION_CD" NVARCHAR(4), 
	"DG_PKG_TRANS_DIR_CD" NVARCHAR(20), 
	"STAKEHOLDER_ID" NUMERIC, 
	"STKHLDR_CLASS_PROFIL_SEQ_NUM" NUMERIC, 
	"DATE_CREATED_DTE" DATETIME, 
	"DATE_CURRENT_DTE" DATETIME, 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );


--------------------------------------------------------
--  DDL for Table YD034_STAKEHOLDER_BUSINESS
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD034_STAKEHOLDER_BUSINESS";
  CREATE TABLE "YD034_STAKEHOLDER_BUSINESS" 
   (	
    "BUSINESS_CATEGORY_CD" NVARCHAR(200), 
	"STAKEHOLDER_ID" NUMERIC, 
	"STKHLDR_BUSINESS_SEQ_NUM" NUMERIC, 
	"BUSINESS_REMARKS_TXT" NVARCHAR(4000), 
	"DATE_CREATED_DTE" DATETIME, 
	"DATE_CURRENT_DTE" DATETIME, 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME, 
	"USER_STAKEHOLDER_ID" NUMERIC
   );
   

--------------------------------------------------------
--  DDL for Table YD039_ACTIVITY_ADDRESS
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD039_ACTIVITY_ADDRESS";
  CREATE TABLE "YD039_ACTIVITY_ADDRESS" 
   (	
    "ACTIVITY_SEQ_NUM" NUMERIC(10,0) DEFAULT 1, 
	"ACTIVITY_ID" NUMERIC, 
	"SUITE_APARTMENT_NUMBER_NUM" NVARCHAR(10), 
	"FLOOR_SECTION_NUMBER_NUM" NVARCHAR(20), 
	"STREET_NAME_NM" NVARCHAR(35), 
	"STREET_ADDRESS_NUMBER_NUM" NUMERIC(10,0), 
	"POSTAL_ZIP_CODE_TXT" NVARCHAR(10), 
	"STREET_ADDR_NUMBER_SUFFIX_TXT" NVARCHAR(20), 
	"BUILDING_NAME_NM" NVARCHAR(255), 
	"COUNTRY_CD" NUMERIC(4,0), 
	"CITY_TOWN_NAME_NM" NVARCHAR(75), 
	"ROUTE_SERVICE_NUMBER_NUM" NUMERIC, 
	"BOX_NUMBER_NUM" NUMERIC, 
	"DELIVERY_INSTALLATION_AREA_NM" NVARCHAR(20), 
	"DELIVERY_INSTALL_QUALIFIER_NM" NVARCHAR(20), 
	"GEN_DELIVERY_CATEGORY_CD" NVARCHAR(20), 
	"LATTITUE_DEGREE_NBR" NUMERIC(8,6), 
	"LATITUDE_MINUTE_NBR" NUMERIC(8,6), 
	"LONGITUDE_DEGREE_NBR" NUMERIC(9,6), 
	"LONGITUDE_MINUTE_NBR" NUMERIC(9,6), 
	"UNREGISTERED_CITY_TOWN_NM" NVARCHAR(20), 
	"STREET_TYPE_CD" NVARCHAR(20), 
	"STREET_DIRECTION_CD" NVARCHAR(20), 
	"COUNTRY_SUBDIVISION_CD" NVARCHAR(10), 
	"ROUTE_SERVICE_TYPE_CD" NVARCHAR(20), 
	"DATE_CREATED_DTE" DATETIME, 
	"DATE_CURRENT_DTE" DATETIME, 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME, 
	"USER_STAKEHOLDER_ID" NUMERIC
   );


--------------------------------------------------------
--  DDL for Table YD040_ACTIVITY
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD040_ACTIVITY";
  CREATE TABLE "YD040_ACTIVITY" 
   (	
    "ACTIVITY_ID" NUMERIC, 
	"STAKEHOLDER_ID" NUMERIC, 
	"DATE_COMPLETE_DTE" DATETIME, 
	"LANGUAGE_CD" NVARCHAR(20), 
	"JONUMERIC_PARTICIPANT_TXT" NVARCHAR(4000), 
	"ORIGIN_KEY_TXT" NVARCHAR(20), 
	"JONUMERIC_ACTIVITY_IND" BIT, 
	"ACTIVITY_DATE_DTE" DATETIME, 
	"INSPECTION_DATE_DTE" DATETIME, 
	"MANAGER_USER_ID" NUMERIC(10,0), 
	"VERIFICATION_IND" BIT, 
	"DATE_VERIFICATION_DTE" DATETIME, 
	"MANAGER_COMMENT_TXT" NVARCHAR(4000), 
	"FILE_NUMBER_NUM" NVARCHAR(100), 
	"DATE_CREATED_DTE" DATETIME, 
	"DATE_CURRENT_DTE" DATETIME, 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME, 
	"USER_STAKEHOLDER_ID" NUMERIC, 
	"STKHLDR_HOTI_SEQ_NUM" NUMERIC, 
	"DELETE_REASON_TXT" NVARCHAR(4000)
   );


--------------------------------------------------------
--  DDL for Table YD041_INSPECTION
--------------------------------------------------------
DROP TABLE IF EXISTS "YD041_INSPECTION";
CREATE TABLE "YD041_INSPECTION" (
    [ACTIVITY_ID] DECIMAL(29, 0),
    [CONSIGNMENT_IND] NUMERIC(38, 0),
    [DATE_CREATED_DTE] DATETIME,
    [DATE_CURRENT_DTE] DATETIME,
    [DATE_DELETED_DTE] DATETIME,
    [DATE_LAST_UPDATE_DTE] DATETIME,
    [ESTIMATED_ANNUAL_VOL_CD] VARCHAR(20),
    [ESTIMATED_ANNUAL_VOL_NBR] DECIMAL(29, 0),
    [FOLLOW_UP_SCORE_NUM] DECIMAL(29, 0),
    [INSPECTION_COMMENT_LOB] TEXT,
    [INSPECTION_REASON_CD] VARCHAR(20),
    [INSPECTOR_COMMENTS_TXT] TEXT,
    [INSPECTOR_NOTES_TXT] TEXT,
    [PCT_DG_HOTI_RTE] DECIMAL(29, 0),
    [USER_STAKEHOLDER_ID] DECIMAL(29, 0)
)



   --------------------------------------------------------
--  DDL for Table YD042_SITE_VISIT
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD042_SITE_VISIT";
  CREATE TABLE "YD042_SITE_VISIT" 
   (	
    "ACTIVITY_ID" NUMERIC, 
	"INSPECTOR_COMMENTS_TXT" NVARCHAR(4000), 
	"SITE_VISIT_REASON_CD" NVARCHAR(20), 
	"CLOSE_SITE_IND" BIT, 
	"SITE_VISIT_LOCATION_TXT" NVARCHAR(250), 
	"LOCATION_SUPERVISOR_TXT" NVARCHAR(250), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );




--------------------------------------------------------
--  DDL for Table YD048_ACTIVITY_ASSIGNMENT
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD048_ACTIVITY_ASSIGNMENT";
  CREATE TABLE "YD048_ACTIVITY_ASSIGNMENT" 
   (	
    "ACTIVITY_ID" NUMERIC, 
	"STAKEHOLDER_ID" NUMERIC, 
	"ASSIGN_ROLE_CD" NVARCHAR(20), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );


--------------------------------------------------------
--  DDL for Table YD070_STAKEHOLDER
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD070_STAKEHOLDER";
  CREATE TABLE "YD070_STAKEHOLDER" 
   (	
    "STAKEHOLDER_ID" NUMERIC, 
	"STAKEHOLDER_TYPE_CD" NVARCHAR(20), 
	"ORIGIN_KEY_TXT" NVARCHAR(20), 
	"DGAIS_ID" NVARCHAR(100), 
	"CANUTEC_ID" NVARCHAR(100), 
	"ERAP_ID" NVARCHAR(100), 
	"MOC_ID" NVARCHAR(100), 
	"FILE_STATUS_CD" NVARCHAR(20), 
	"DATE_STOP_DTE" DATETIME, 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );


--------------------------------------------------------
--  DDL for Table YD074_INSPECTOR
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD074_INSPECTOR";
  CREATE TABLE "YD074_INSPECTOR" 
   (	
    "STAKEHOLDER_ID" NUMERIC, 
	"INSPECTOR_CERT_NUM" NVARCHAR(30), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC, 
	"INSPECTOR_BADGE_NUM" NVARCHAR(20)
   );


--------------------------------------------------------
--  DDL for Table YD075_INDIVIDUAL
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD075_INDIVIDUAL";
  CREATE TABLE "YD075_INDIVIDUAL" 
   (	
    "STAKEHOLDER_ID" NUMERIC, 
	"LANGUAGE_CD" NVARCHAR(20), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );



--------------------------------------------------------
--  DDL for Table YD082_INSPECTION_VIOLATION
--------------------------------------------------------
DROP TABLE IF EXISTS "YD082_INSPECTION_VIOLATION";
CREATE TABLE "YD082_INSPECTION_VIOLATION" (
    [ACTIVITY_ID] DECIMAL(29, 0),
    [COMMENT_TXT] TEXT,
    [DATE_CREATED_DTE] DATETIME,
    [DATE_CURRENT_DTE] DATETIME,
    [DATE_DELETED_DTE] DATETIME,
    [DATE_FOLLOW_UP_DTE] DATETIME,
    [DATE_LAST_UPDATE_DTE] DATETIME,
    [FOLLOW_UP_COMMENT_TXT] VARCHAR(4000),
    [FOLLOW_UP_TYPE_CD] VARCHAR(20),
    [INSPECTION_FOLLOW_UP_SEQ_NUM] DECIMAL(29, 0),
    [INSPECTION_JUSTIFICATION_TXT] TEXT,
    [USER_STAKEHOLDER_ID] DECIMAL(29, 0),
    [VIOLATION_CD] DECIMAL(29, 0)
)


--------------------------------------------------------
--  DDL for Table YD083_INDIVIDUAL_INFORMATION
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD083_INDIVIDUAL_INFORMATION";
  CREATE TABLE "YD083_INDIVIDUAL_INFORMATION" 
   (	
    "STAKEHOLDER_ID" NUMERIC, 
	"INDIVIDUAL_SEQ_NUM" NUMERIC, 
	"STAKEHOLDER_NAME_FAMILY_NM" NVARCHAR(50), 
	"STAKEHOLDER_NAME_SECOND_NM" NVARCHAR(30), 
	"STAKEHOLDER_NAME_FIRST_NM" NVARCHAR(30), 
	"STAKEHOLDER_COMP_FAMILY_NM" NVARCHAR(50), 
	"STAKEHOLDER_COMP_FIRST_NM" NVARCHAR(30), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );



--------------------------------------------------------
--  DDL for Table YD091_STAKEHOLDER_CONTACT
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD091_STAKEHOLDER_CONTACT";
  CREATE TABLE "YD091_STAKEHOLDER_CONTACT" 
   (	
    "CONTACT_SEQ_NUM" NUMERIC, 
	"CONTACT_TYPE_CD" NVARCHAR(20), 
	"STAKEHOLDER_ID" NUMERIC, 
	"CONTACT_TXT" NVARCHAR(255), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC, 
	"CONTACT_EXTENSION_NUM" NUMERIC(5,0)
   );
   
--------------------------------------------------------
--  DDL for Table YD092_STAKEHOLDER_ORG_PERS
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD092_STAKEHOLDER_ORG_PERS";
  CREATE TABLE "YD092_STAKEHOLDER_ORG_PERS" 
   (	
    "STAKEHOLDER_ID" NUMERIC, 
	"STAKEHOLDER_CONTACT_ID" NUMERIC, 
	"CONTACT_TITLE_NM" NVARCHAR(500), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );
   
   
--------------------------------------------------------
--  DDL for Table YD093_STAKEHOLDER_ORG_NAME
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD093_STAKEHOLDER_ORG_NAME";
  CREATE TABLE "YD093_STAKEHOLDER_ORG_NAME" 
   (	
    "STAKEHOLDER_ID" NUMERIC, 
	"ORG_NAME_TYPE_CD" NVARCHAR(20), 
	"STKHLDR_ORG_NAME_SEQ_NUM" NUMERIC, 
	"STAKEHOLDER_ENM" NVARCHAR(120), 
	"STAKEHOLDER_FNM" NVARCHAR(120), 
	"STAKEHOLDER_COMP_ENM" NVARCHAR(120), 
	"STAKEHOLDER_COMP_FNM" NVARCHAR(120), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );

--------------------------------------------------------
--  DDL for Table YD095_STAKEHOLDER_FILE
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD095_STAKEHOLDER_FILE";
  CREATE TABLE "YD095_STAKEHOLDER_FILE" 
   (	
    "FILE_NUMBER_NUM" NVARCHAR(100), 
	"STAKEHOLDER_ID" NUMERIC, 
	"FILE_REMARKS_TXT" NVARCHAR(500), 
	"FILE_STATUS_CD" NVARCHAR(20), 
	"FILE_PREFIX_CD" NVARCHAR(20), 
	"INSPECTION_REGION_CD" NVARCHAR(20), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC
   );
   
   
--------------------------------------------------------
--  DDL for Table YD099_ACTIVITY_SITE_CONTACT
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD099_ACTIVITY_SITE_CONTACT";
  CREATE TABLE "YD099_ACTIVITY_SITE_CONTACT" 
   (	
    "ACTIVITY_ID" NUMERIC, 
	"STAKEHOLDER_ID" NUMERIC, 
	"CONTACT_ROLE_CD" NVARCHAR(20), 
	"CONTACT_POSITION_TITLE_TXT" NVARCHAR(250), 
	"DATE_CREATED_DTE" DATETIME , 
	"DATE_CURRENT_DTE" DATETIME , 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME , 
	"USER_STAKEHOLDER_ID" NUMERIC, 
	"SHOW_CONTACT_IN_REPORT_IND" BIT DEFAULT 0
   );
   
   
--------------------------------------------------------
--  DDL for Table YD100_ACTIVITY_REPORT
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD100_ACTIVITY_REPORT";
  CREATE TABLE "YD100_ACTIVITY_REPORT" 
   (	
    "ACTIVITY_ID" NUMERIC, 
	"USER_STAKEHOLDER_ID" NUMERIC, 
	"DATE_ACTIVITY_REPORT_DTE" DATETIME, 
	"ACTIVITY_REPORT_LOB" VARBINARY(MAX), 
	"REPORT_UNLOCKED_USER_ID" NUMERIC, 
	"REPORT_CREATOR_USER_ID" NUMERIC, 
	"MANAGER_USER_ID" NUMERIC, 
	"DATE_UNLOCKED_DTE" DATETIME, 
	"DATE_VERIFICATION_DTE" DATETIME, 
	"MANAGER_COMMENT_TXT" NVARCHAR(4000), 
	"MANAGER_VERIFICATION_IND" BIT DEFAULT 0, 
	"REPORT_UNLOCKED_REASON_TXT" NVARCHAR(4000), 
	"DATE_CREATED_DTE" DATETIME, 
	"DATE_CURRENT_DTE" DATETIME, 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME
   );
   
   
--------------------------------------------------------
--  DDL for Table YD101_FILE_ACTIVITY_TYPE
--------------------------------------------------------
  DROP TABLE IF EXISTS "YD101_FILE_ACTIVITY_TYPE";
  CREATE TABLE "YD101_FILE_ACTIVITY_TYPE" 
   (	
    "FILE_NUMBER_NUM" NVARCHAR(100), 
	"ACTIVITY_TYPE_CD" NVARCHAR(20), 
	"DATE_CREATED_DTE" DATETIME, 
	"DATE_CURRENT_DTE" DATETIME, 
	"DATE_DELETED_DTE" DATETIME, 
	"DATE_LAST_UPDATE_DTE" DATETIME, 
	"USER_STAKEHOLDER_ID" NUMERIC
   );