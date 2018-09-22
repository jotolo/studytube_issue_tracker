Apipie.configure do |config|
  config.app_name                = 'StudytubeIssueTracker'
  config.api_base_url            = ''
  config.doc_base_url            = '/documentation'
  config.validate                = false
  config.translate               = false
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
