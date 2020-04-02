Rails.application.configure do
  #form_with のリモートフォームを無効化する
  config.action_view.form_with_generates_remote_forms = false
end