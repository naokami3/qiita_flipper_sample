require 'flipper'
require 'flipper/adapters/active_record'

if ActiveRecord::Base.connection.data_source_exists? 'flipper_features'
  feature_toggles = %i[
    sample_flag_1
    sample_flag_2
  ]
  feature_toggles.each do |feature|
    next if Flipper[feature].exist?

    Flipper.enable(feature)
  end
end

Flipper::UI.configure do |config|
  # flag未設定時に出る動画広告を非表示にする
  config.fun = false
  # バナー表示を追加
  config.banner_text = "#{Rails.env}画面です"
  config.banner_class = 'info'
  # 説明文を追加
  config.descriptions_source = ->(keys) do
    {
      "sample_flag_1" => "サンプルフラグ1",
      "sample_flag_2" => "サンプルフラグ2"
    }
  end
  # features, settings,のタブに別ページへのリンクを設定
  config.nav_items << { title: "top", href: "/" }
  # 戻り先のリンクを設定
  config.application_href = "https://www.google.co.jp/"
  # 閲覧専用
  config.read_only = false
  config.feature_creation_enabled = true
  config.feature_removal_enabled = true
  config.show_feature_description_in_list = true
  config.confirm_fully_enable = false
  config.confirm_disable = false
end
