require 'slim/translator'

Dir.glob('source/locales/*.yml') do |path|
  I18n.load_path << path
end

I18n.locale = :ja
