SELECT * FROM 
(
    SELECT DISTINCT 
    COMPANY.STAKEHOLDER_ID,
    COMPANY.FILE_STATUS_CD,
    COMPANY.INVESTIGATION_IND,
    COMPANY.PROSECUTION_IND,
    COMPANY.BUSINESS_CATEGORY_CD,
    
    LEGAL_NAME.STAKEHOLDER_ENM LEGAL_NAME_ENM,
    
    OPERATING_NAME.STAKEHOLDER_ENM OPERATING_NAME_ENM,
    
    AKA_NAME.STAKEHOLDER_ENM AKA_NAME_ENM,
    
    ADDRESS.STREET_NUMBER_NUM,
    ADDRESS.STREET_NAME_NM,
    ADDRESS.CITY_TOWN_NAME_NM,
    ADDRESS.COUNTRY_SUBDIVISION_CD,
    ADDRESS.POSTAL_CODE_TXT,
    
    UNREGISTERED_ADDRESS.STREET_NUMBER_NUM PHYS_STREET_NUMBER_NUM,
    UNREGISTERED_ADDRESS.STREET_NAME_NM PHYS_STREET_NAME_NM,
    UNREGISTERED_ADDRESS.CITY_TOWN_NAME_NM PHYS_CITY_TOWN_NAME_NM,
    UNREGISTERED_ADDRESS.COUNTRY_CD PHYS_COUNTRY_CD,
    UNREGISTERED_ADDRESS.COUNTRY_SHORT_ENM PHYS_COUNTRY_ENM,
    UNREGISTERED_ADDRESS.COUNTRY_SHORT_FNM PHYS_COUNTRY_FNM,
    UNREGISTERED_ADDRESS.COUNTRY_SUBDIVISION_CD PHYS_COUNTRY_SUBDIVISION_CD,
    UNREGISTERED_ADDRESS.COUNTRY_SUBDIVISION_ENM PHYS_COUNTRY_SUBDIVISION_ENM,
    UNREGISTERED_ADDRESS.COUNTRY_SUBDIVISION_FNM PHYS_COUNTRY_SUBDIVISION_FNM,
    UNREGISTERED_ADDRESS.POSTAL_CODE_TXT PHYS_POSTAL_CODE_TXT,
    
    CONTACT.USER_CONTACT,
    CONTACT.CONTACT_TXT,
    
    ACTIVITY.LAST_ACTIVITY_DATE,
    
    TRANSPORT_MODE.TRANSPORT_MODE_ETXT,
    TRANSPORT_MODE.TRANSPORT_MODE_FTXT,
    TRANSPORT_MODE.TRANSPORT_MODE_CD,
    
    DG_CLASS.DG_CLASS,
    
    UN_NUMBERS.UN_NUMBER
    
    FROM
    (
        SELECT YD070.STAKEHOLDER_ID,
        YD070.FILE_STATUS_CD,
        YD081.INVESTIGATION_IND,
        YD081.PROSECUTION_IND,
        YD034.BUSINESS_CATEGORY_CD
        FROM YD070_STAKEHOLDER YD070,
        YD076_ORGANIZATION YD076,
        YD081_ORGANIZATION_LEGAL_STATU YD081,
        (
            SELECT STAKEHOLDER_ID, LISTAGG (BUSINESS_CATEGORY_CD, ', ') WITHIN GROUP (ORDER BY STAKEHOLDER_ID) BUSINESS_CATEGORY_CD
            FROM (
                SELECT DISTINCT STAKEHOLDER_ID, BUSINESS_CATEGORY_CD 
                FROM YD034_STAKEHOLDER_BUSINESS
                WHERE DATE_DELETED_DTE IS NULL
            )
            GROUP BY STAKEHOLDER_ID
        ) YD034
        WHERE YD070.STAKEHOLDER_ID    = YD076.STAKEHOLDER_ID
        AND YD076.STAKEHOLDER_ID      = YD081.STAKEHOLDER_ID(+)
        AND YD076.STAKEHOLDER_ID      = YD034.STAKEHOLDER_ID(+)
        AND YD070.STAKEHOLDER_ID NOT IN ('100000000','72519', '72520', '72521', '72522', '72523', '72524', '72525', '72526', '72527', '72528', '1', '2', '3', '4')
        AND YD081.DATE_DELETED_DTE   IS NULL
        AND YD070.DATE_DELETED_DTE IS NULL
        GROUP BY YD070.STAKEHOLDER_ID,
        YD070.FILE_STATUS_CD,
        YD081.INVESTIGATION_IND,
        YD081.PROSECUTION_IND,
        YD034.BUSINESS_CATEGORY_CD
    ) COMPANY,
    
    (
        SELECT STAKEHOLDER_ID, 
        BUSINESS_CATEGORY_CD,
        BUSINESS_REMARKS_TXT
        FROM YD034_STAKEHOLDER_BUSINESS 
        WHERE DATE_DELETED_DTE IS NULL 
        GROUP BY STAKEHOLDER_ID, BUSINESS_CATEGORY_CD, BUSINESS_REMARKS_TXT
    ) BUSINESS_CATEGORY,
    
    (
        SELECT AD050.STAKEHOLDER_ID,
        STREET_NUMBER_NUM,
        AD050.STREET_NAME_NM,
        AD050.CITY_TOWN_NAME_NM,
        AD050.COUNTRY_SUBDIVISION_CD,
        AD050.POSTAL_CODE_TXT
        FROM AD050_ADDRESS AD050
        WHERE (AD050.STAKEHOLDER_ID, AD050.ACTIVE_ADDRESS_DTE, ADDRESS_TYPE_CD) IN
        (
            SELECT DISTINCT STAKEHOLDER_ID,
            MAX (ACTIVE_ADDRESS_DTE) ACTIVE_ADDRESS_DTE,
            MIN (ADDRESS_TYPE_CD) ADDRESS_TYPE_CD
            FROM AD050_ADDRESS AD050
            WHERE ACTIVE_ADDRESS_DTE = TO_DATE ('31/12/9999', 'DD/MM/YYYY')
            GROUP BY STAKEHOLDER_ID
        )
        
        AND ACTIVE_ADDRESS_DTE = TO_DATE ('31/12/9999', 'DD/MM/YYYY')
        
        UNION
        
        SELECT AD050.STAKEHOLDER_ID,
        TO_NUMBER ( DECODE (AD050.STREET_NUMBER_NUM, 9999, '', STREET_NUMBER_NUM)) STREET_NUMBER_NUM,
        AD050.ADDRESS_REMARKS_TXT,
        AD050.CITY_TOWN_NAME_NM,
        AD050.COUNTRY_SUBDIVISION_CD,
        AD050.POSTAL_CODE_TXT
        FROM AD050_ADDRESS AD050
        WHERE AD050.STAKEHOLDER_ID NOT IN
        (
            SELECT AD050.STAKEHOLDER_ID
            FROM AD050_ADDRESS AD050
            WHERE (AD050.STAKEHOLDER_ID, AD050.ACTIVE_ADDRESS_DTE) IN
            (
                SELECT DISTINCT STAKEHOLDER_ID,
                MAX (ACTIVE_ADDRESS_DTE) OVER (PARTITION BY STAKEHOLDER_ID) ACTIVE_ADDRESS_DTE
                FROM AD050_ADDRESS AD050
                WHERE ACTIVE_ADDRESS_DTE = TO_DATE ('31/12/9999', 'DD/MM/YYYY')
            )
        )
        
        AND ACTIVE_ADDRESS_DTE = TO_DATE ('31/12/9999', 'DD/MM/YYYY')
          
    ) ADDRESS,
    
    
    (
        SELECT STAKEHOLDER_ID,
        STREET_NUMBER_NUM,
        STREET_NAME_NM,
        CITY_TOWN_NAME_NM,
        AD051.COUNTRY_SUBDIVISION_CD,
        TC006.COUNTRY_SUBDIVISION_ENM,
        TC006.COUNTRY_SUBDIVISION_FNM,
        AD051.COUNTRY_CD,
        TC005.COUNTRY_SHORT_ENM,
        TC005.COUNTRY_SHORT_FNM, 
        POSTAL_CODE_TXT
        FROM AD051_UNREGISTERED_ADDRESS AD051
        INNER JOIN TC006_COUNTRY_SUBDIVISION TC006 ON TC006.COUNTRY_CD = AD051.COUNTRY_CD AND TC006.COUNTRY_SUBDIVISION_CD = AD051.COUNTRY_SUBDIVISION_CD
        INNER JOIN TC005_COUNTRY TC005 ON TC005.COUNTRY_CD = AD051.COUNTRY_CD
        WHERE ACTIVE_ADDRESS_DTE = TO_DATE ('31/12/9999', 'DD/MM/YYYY')
    ) UNREGISTERED_ADDRESS,
    
    
    (
        SELECT YD092.STAKEHOLDER_ID,
        YD083.STAKEHOLDER_NAME_FIRST_NM || ' ' || YD083.STAKEHOLDER_NAME_FAMILY_NM USER_CONTACT,
        YD091.CONTACT_TXT
        FROM YD092_STAKEHOLDER_ORG_PERS YD092,
        YD075_INDIVIDUAL YD075,
        YD083_INDIVIDUAL_INFORMATION YD083,
        YD091_STAKEHOLDER_CONTACT YD091
        WHERE YD092.STAKEHOLDER_CONTACT_ID = YD075.STAKEHOLDER_ID
        AND YD075.STAKEHOLDER_ID           = YD083.STAKEHOLDER_ID(+)
        AND YD075.STAKEHOLDER_ID           = YD091.STAKEHOLDER_ID(+)
        AND YD075.DATE_DELETED_DTE        IS NULL
        AND YD083.DATE_DELETED_DTE        IS NULL
        AND YD091.DATE_DELETED_DTE        IS NULL
        AND YD092.DATE_DELETED_DTE        IS NULL
        AND (YD091.CONTACT_TYPE_CD         = 'PHONE' OR YD091.CONTACT_TYPE_CD          IS NULL)
    ) CONTACT,
    
    (
        SELECT YD040.STAKEHOLDER_ID,
        MAX (YD040.ACTIVITY_DATE_DTE) OVER (PARTITION BY YD040.STAKEHOLDER_ID) LAST_ACTIVITY_DATE
        FROM YD040_ACTIVITY YD040
    ) ACTIVITY,
    
    (
        SELECT STAKEHOLDER_ID,
        STAKEHOLDER_ENM
        FROM YD093_STAKEHOLDER_ORG_NAME YD093
        WHERE YD093.STAKEHOLDER_ID NOT IN ('100000000','72519', '72520', '72521', '72522', '72523', '72524', '72525', '72526', '72527', '72528', '1', '2', '3', '4')
        AND YD093.DATE_DELETED_DTE     IS NULL
        AND ORG_NAME_TYPE_CD = 'LEGAL'
    ) LEGAL_NAME,
    
    (
        SELECT STAKEHOLDER_ID,
        STAKEHOLDER_ENM
        FROM YD093_STAKEHOLDER_ORG_NAME YD093
        WHERE YD093.STAKEHOLDER_ID NOT IN ('100000000','72519', '72520', '72521', '72522', '72523', '72524', '72525', '72526', '72527', '72528', '1', '2', '3', '4')
        AND YD093.DATE_DELETED_DTE     IS NULL
        AND ORG_NAME_TYPE_CD = 'OPERATING'
    ) OPERATING_NAME,
    
    (
        SELECT STAKEHOLDER_ID,
        LISTAGG (STAKEHOLDER_ENM, ', ') WITHIN GROUP (ORDER BY YD093.STAKEHOLDER_ID) STAKEHOLDER_ENM
        FROM YD093_STAKEHOLDER_ORG_NAME YD093
        WHERE YD093.STAKEHOLDER_ID NOT IN ('100000000','72519', '72520', '72521', '72522', '72523', '72524', '72525', '72526', '72527', '72528', '1', '2', '3', '4')
        AND YD093.DATE_DELETED_DTE     IS NULL
        AND ORG_NAME_TYPE_CD = 'AKA'
        GROUP BY STAKEHOLDER_ID
    ) AKA_NAME,
    
    (
        SELECT UNIQUE STAKEHOLDER_ID,
        LISTAGG(TD033.TRANSPORT_MODE_CD, ',') WITHIN GROUP (ORDER BY STAKEHOLDER_ID) AS TRANSPORT_MODE_CD,
        LISTAGG(TD033.TRANSPORT_MODE_ETXT, ',') WITHIN GROUP (ORDER BY STAKEHOLDER_ID) AS TRANSPORT_MODE_ETXT,
        LISTAGG(TD033.TRANSPORT_MODE_FTXT, ',') WITHIN GROUP (ORDER BY STAKEHOLDER_ID) AS TRANSPORT_MODE_FTXT
        FROM YD032_STAKEHOLDER_MODE_PROFILE YD032 
        JOIN TD033_TRANSPORT_MODE TD033 ON TD033.TRANSPORT_MODE_CD = YD032.TRANSPORT_MODE_CD
        WHERE YD032.DATE_DELETED_DTE IS NULL
        GROUP BY YD032.STAKEHOLDER_ID
    ) TRANSPORT_MODE,
    
    (
        SELECT STAKEHOLDER_ID, 
        LISTAGG(YD033.HAZARD_CLASS_DIVISION_CD, ',') WITHIN GROUP (ORDER BY YD033.STAKEHOLDER_ID) DG_CLASS 
        FROM 
        (
            SELECT DISTINCT STAKEHOLDER_ID, HAZARD_CLASS_DIVISION_CD
            FROM YD033_STAKEHOLDER_CLASS_PROFIL 
            WHERE HAZARD_CLASS_DIVISION_CD IS NOT NULL AND DATE_DELETED_DTE IS NULL 
            GROUP BY STAKEHOLDER_ID, HAZARD_CLASS_DIVISION_CD 
        ) YD033 
        GROUP BY YD033.STAKEHOLDER_ID
    ) DG_CLASS,
    
    (
        SELECT STAKEHOLDER_ID, 
        HAZARD_CLASS_DIVISION_CD
        FROM YD033_STAKEHOLDER_CLASS_PROFIL 
        WHERE HAZARD_CLASS_DIVISION_CD IS NOT NULL AND DATE_DELETED_DTE IS NULL 
        GROUP BY STAKEHOLDER_ID, HAZARD_CLASS_DIVISION_CD
    ) DG_CLASS_SEARCH,
    
    (
        SELECT UNIQUE STAKEHOLDER_ID, 
        LISTAGG(YD031.UN_NUMBER_ID, ',') WITHIN GROUP (ORDER BY STAKEHOLDER_ID) AS UN_NUMBER 
        FROM YD031_STAKEHOLDER_DG_PROFILE YD031
        WHERE EXTRACT(YEAR FROM YD031.DATE_DELETED_DTE) = 9999
        GROUP BY YD031.STAKEHOLDER_ID
    ) UN_NUMBERS,
    
    (
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
        PRIMARY_INSPECTOR.PRIMARY_INSPECTOR,
        PRIMARY_INSPECTOR.STAKEHOLDER_ID INSPECTOR_ID, 
        SECONDARY_INSPECTOR.SECONDARY_INSPECTOR,
        SECONDARY_INSPECTOR.STAKEHOLDER_ID SECONDARY_INSPECTOR_ID,
        VIOLATIONS.VIOLATION_CD,
        ENFORCEMENT_ACTIONS.ENFORCEMENT_ACTION_TYPE_CD
        FROM YD040_ACTIVITY YD040
        INNER JOIN YD095_STAKEHOLDER_FILE YD095 ON  YD040.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM  
        INNER JOIN YD101_FILE_ACTIVITY_TYPE YD101 ON YD101.FILE_NUMBER_NUM = YD095.FILE_NUMBER_NUM AND YD101.DATE_DELETED_DTE IS NULL
        INNER JOIN TD045_ACTIVITY_TYPE TD045 ON YD101.ACTIVITY_TYPE_CD = TD045.ACTIVITY_TYPE_CD 
        INNER JOIN TD001_FILE_STATUS TD001 ON YD095.FILE_STATUS_CD = TD001.FILE_STATUS_CD  
        LEFT JOIN YD041_INSPECTION YD041 ON YD040.ACTIVITY_ID = YD041.ACTIVITY_ID 
        LEFT JOIN TD038_INSPECTION_REASON TD038 ON YD041.INSPECTION_REASON_CD = TD038.INSPECTION_REASON_CD 
        
        LEFT JOIN
        (
            SELECT YD048.ACTIVITY_ID,
            YD048.STAKEHOLDER_ID,
            CONCAT(CONCAT(YD083.STAKEHOLDER_NAME_FAMILY_NM, ' '), YD083.STAKEHOLDER_NAME_FIRST_NM) PRIMARY_INSPECTOR
            FROM YD048_ACTIVITY_ASSIGNMENT YD048 
            JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON  YD048.STAKEHOLDER_ID = YD083.STAKEHOLDER_ID 
            WHERE YD083.DATE_DELETED_DTE IS NULL AND YD048.DATE_DELETED_DTE IS NULL AND ASSIGN_ROLE_CD = '1'
        ) PRIMARY_INSPECTOR ON PRIMARY_INSPECTOR.ACTIVITY_ID = YD040.ACTIVITY_ID
        
        LEFT JOIN
        (
            SELECT YD048.ACTIVITY_ID,
            YD048.STAKEHOLDER_ID,
            CONCAT(CONCAT(YD083.STAKEHOLDER_NAME_FAMILY_NM, ' '), YD083.STAKEHOLDER_NAME_FIRST_NM) SECONDARY_INSPECTOR
            FROM YD048_ACTIVITY_ASSIGNMENT YD048 
            JOIN YD083_INDIVIDUAL_INFORMATION YD083 ON  YD048.STAKEHOLDER_ID = YD083.STAKEHOLDER_ID 
            WHERE YD083.DATE_DELETED_DTE IS NULL AND YD048.DATE_DELETED_DTE IS NULL AND ASSIGN_ROLE_CD = '2'
        ) SECONDARY_INSPECTOR ON SECONDARY_INSPECTOR.ACTIVITY_ID = YD040.ACTIVITY_ID
        
        LEFT JOIN
        (
            SELECT YD020.ACTIVITY_ID,
            YD020.VIOLATION_CD
            FROM YD020_INSPECTION_VIOLATION YD020
            WHERE YD020.DATE_DELETED_DTE IS NULL
            GROUP BY YD020.ACTIVITY_ID, YD020.VIOLATION_CD
        ) VIOLATIONS ON VIOLATIONS.ACTIVITY_ID = YD040.ACTIVITY_ID
        
        
        LEFT JOIN
        (
            SELECT YD023.ACTIVITY_ID,
            YD023.ENFORCEMENT_ACTION_TYPE_CD
            FROM YD023_VIOL_ENFORCEMENT_ACTION YD023 
            WHERE YD023.DATE_DELETED_DTE IS NULL
            GROUP BY YD023.ACTIVITY_ID, YD023.ENFORCEMENT_ACTION_TYPE_CD
        ) ENFORCEMENT_ACTIONS ON ENFORCEMENT_ACTIONS.ACTIVITY_ID = YD040.ACTIVITY_ID
        
        WHERE 
        YD040.DATE_DELETED_DTE IS NULL AND 
        YD095.DATE_DELETED_DTE IS NULL AND 
        YD041.DATE_DELETED_DTE IS NULL AND 
        YD101.DATE_DELETED_DTE IS NULL 
        --AND TD045.ACTIVITY_TYPE_PARENT_CD IS NULL 
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
        PRIMARY_INSPECTOR.PRIMARY_INSPECTOR,
        SECONDARY_INSPECTOR.SECONDARY_INSPECTOR,
        VIOLATIONS.VIOLATION_CD,
        ENFORCEMENT_ACTIONS.ENFORCEMENT_ACTION_TYPE_CD, 
        PRIMARY_INSPECTOR.STAKEHOLDER_ID, 
        SECONDARY_INSPECTOR.STAKEHOLDER_ID
    ) ACTIVITY_LIST
    
    WHERE COMPANY.STAKEHOLDER_ID = UNREGISTERED_ADDRESS.STAKEHOLDER_ID(+)
    AND COMPANY.STAKEHOLDER_ID   = ADDRESS.STAKEHOLDER_ID (+)
    AND COMPANY.STAKEHOLDER_ID   = CONTACT.STAKEHOLDER_ID(+)
    AND COMPANY.STAKEHOLDER_ID   = ACTIVITY.STAKEHOLDER_ID(+)
    AND COMPANY.STAKEHOLDER_ID   = LEGAL_NAME.STAKEHOLDER_ID(+)
    AND COMPANY.STAKEHOLDER_ID   = OPERATING_NAME.STAKEHOLDER_ID(+)
    AND COMPANY.STAKEHOLDER_ID   = AKA_NAME.STAKEHOLDER_ID(+)
    AND COMPANY.STAKEHOLDER_ID   = TRANSPORT_MODE.STAKEHOLDER_ID(+)
    AND COMPANY.STAKEHOLDER_ID   = DG_CLASS.STAKEHOLDER_ID(+)
    AND COMPANY.STAKEHOLDER_ID   = UN_NUMBERS.STAKEHOLDER_ID(+)
    AND COMPANY.STAKEHOLDER_ID   = ACTIVITY_LIST.STAKEHOLDER_ID(+)
    AND COMPANY.STAKEHOLDER_ID   = DG_CLASS_SEARCH.STAKEHOLDER_ID(+)
    AND COMPANY.STAKEHOLDER_ID   = BUSINESS_CATEGORY.STAKEHOLDER_ID(+)
) 
ORDER BY LEGAL_NAME_ENM, OPERATING_NAME_ENM, AKA_NAME_ENM
