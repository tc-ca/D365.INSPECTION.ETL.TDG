using TC.Legislation.EarlyBound;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TDG.CORE.ETL.EXTENSIONS;
using CrmWebApiEarlyBoundGenerator;

namespace TDG.CORE.ETL.MODELS.LEGISLATION
{
    public static class JusticeToTCModel
    {
        public static qm_rclegislation ConvertToTCModel (this Regulation justiceModel)
        {
            var newTcModel = new qm_rclegislation();

            newTcModel.qm_LegislationLbl               = justiceModel.Label;
            newTcModel.qm_rcParentLegislationId        = new EntityReference ("qm_rclegislation", justiceModel.CrmId);
            newTcModel.qm_InforceDte                   = justiceModel.InforceStartDate.ToDateTime("yyyy-M-d"); //TODO: ensure format is consistent on read
            newTcModel.qm_LastAmendedDte               = justiceModel.LastAmendedDate.ToDateTime("yyyy-M-d");
            newTcModel.qm_JusticeId                    = justiceModel.JusticeId.ToInt();
            newTcModel.qm_LegislationEtxt              = justiceModel.TextEnglish;
            newTcModel.qm_LegislationFtxt              = justiceModel.TextFrench;
            //newTcModel.qm_TYLegislationSourceCd      = justiceModel.Type;
            newTcModel.qm_OrderNbr                     = justiceModel.Order;
            newTcModel.qm_JusticeFId                   = justiceModel.JusticeFId.ToInt();
            //newTcModel.qm_TYLegislationSectionTypeCd = justiceModel.RegulationType;
            newTcModel.qm_HistoricalNoteEtxt           = justiceModel.HistoricalNote;
            newTcModel.qm_HistoricalNoteFtxt           = justiceModel.HistoricalNote;
            newTcModel.qm_AdditionalMetadataEtxt        = justiceModel.AdditionalMetadata;
            newTcModel.qm_AdditionalMetadataFtxt       = justiceModel.AdditionalMetadata;
            newTcModel.qm_rcParentLegislationId        = justiceModel.ParentCrmId == null || !justiceModel.ParentCrmId.HasValue ? null : new EntityReference("qm_rclegislation", justiceModel.ParentCrmId.Value);
            newTcModel.qm_name                         = justiceModel.UniqueId;

            return newTcModel;
        }
    }
}
