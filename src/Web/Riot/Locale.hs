module Web.Riot.Locale where

data Locale 
    = CS_CZ
    | EL_GR
    | PL_PL
    | RO_RO
    | HU_HU
    | EN_GB
    | DE_DE
    | ES_ES
    | IT_IT
    | FR_FR
    | JA_JP
    | KO_KR
    | ES_MX
    | ES_AR
    | PT_BR
    | EN_US
    | EN_AU
    | RU_RU
    | TR_TR
    | MS_MY
    | EN_PH
    | EN_SG
    | TH_TH
    | VN_VN
    | ID_ID
    | ZH_MY
    | ZH_CH
    | ZH_TW

instance Show Locale where
    show CS_CZ = "cs_CZ"
    show EL_GR = "el_GR"
    show PL_PL = "pl_PL"
    show RO_RO = "ro_RO"
    show HU_HU = "hu_HU"
    show EN_GB = "en_GB"
    show DE_DE = "de_DE"
    show ES_ES = "es_ES"
    show IT_IT = "it_IT"
    show FR_FR = "fr_FR"
    show JA_JP = "ja_JP"
    show KO_KR = "ko_KR"
    show ES_MX = "es_MX"
    show ES_AR = "es_AR"
    show PT_BR = "pt_BR"
    show EN_US = "en_US"
    show EN_AU = "en_AU"
    show RU_RU = "ru_RU"
    show TR_TR = "tr_TR"
    show MS_MY = "ms_MY"
    show EN_PH = "en_PH"
    show EN_SG = "en_SG"
    show TH_TH = "th_TH"
    show VN_VN = "vn_VN"
    show ID_ID = "id_ID"
    show ZH_MY = "zh_MY"
    show ZH_CH = "zh_CH"
    show ZH_TW = "zh_TW"