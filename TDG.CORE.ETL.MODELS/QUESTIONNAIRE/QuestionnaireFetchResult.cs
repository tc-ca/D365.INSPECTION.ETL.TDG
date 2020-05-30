namespace TDG.CORE.ETL.MODELS.QUESTIONNAIRE
{
    public class QuestionnaireFetchResult
    {
        public string template_name                                    { get; set; }
        public string template_title_english                           { get; set; }
        public string template_description_english                     { get; set; }
        public string group_name                                       { get; set; }
        // public string group_html_element_id                            { get; set; }
        public string group_is_repeatable                              { get; set; }
        public string group_visible                                    { get; set; }
        public string group_title_english                              { get; set; }
        public string group_order                                      { get; set; }
        public string question_text_english                            { get; set; }
        public string question_name                                    { get; set; }
        // public string question_html_element_id                         { get; set; }
        public string question_order                                   { get; set; }
        public string question_visible                                 { get; set; }
        public response_control_input_type response_control_input_type { get; set; }
        public string response_control_label_text_english              { get; set; }
        public string response_control_input_name                      { get; set; }
        //public string response_control_input_id                        { get; set; }
        public string response_name                                    { get; set; }
        public string response_internal_comment                        { get; set; }
        public string response_is_problem                              { get; set; }
        public string response_external_comment                        { get; set; }
        public string response_picture                                 { get; set; }
        public string response_is_safety_concern                       { get; set; }
        public string response_emit_value                              {get; set; }
        public string response_order                                   { get; set; }
        public string question_show_key { get; set; }
        public string question_hide_key { get; set; }
        public string group_response_delimiter { get; set; }
        public string response_display_in_group_header { get; set; }
    }
}

public class response_control_input_type
{
    public string entityName   { get; set; }
    public string id           { get; set; }
    public string isNew        { get; set; }
    public string primaryName  { get; set; }
}