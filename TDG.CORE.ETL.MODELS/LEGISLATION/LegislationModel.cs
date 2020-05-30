using System;

namespace TDG.CORE.ETL.MODELS.LEGISLATION
{
    public class LegislationModel : BaseLegislationModel
    {
        public string LegislationType { get; set; }
        public string LegislationReference { get; set; }
        public string LegislationTextEnglish { get; set; }

        public string LegislationTextFrench { get; set; }
        public int Order { get; set; }

        public DateTime? DateEffective { get; set; }
        public DateTime? DateRevoked { get; set; }

    }
}