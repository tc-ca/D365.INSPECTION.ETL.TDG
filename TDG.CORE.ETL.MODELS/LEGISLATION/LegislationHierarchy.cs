namespace TDG.CORE.ETL.MODELS.LEGISLATION
{
    public class LegislationHierarchy : BaseLegislationModel
    {
        public LegislationModel child { get;set;}
        public LegislationModel parent { get;set; }
    }
}
