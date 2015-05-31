require 'slim/translator'
require_relative 'dump_missing_translations'

Dir.glob('source/locales/*.yml') do |path|
  I18n.load_path << path
end
