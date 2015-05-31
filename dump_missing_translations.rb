require 'yaml'

class DumpMissingTranslations
  def self.missing_translations
    @missing_translations ||= {}
  end

  def self.tr(text)
    I18n.t!(text)
  rescue I18n::MissingTranslationData => e
    keys = e.keys.dup
    key = keys.pop
    missing_translations = keys.inject(self.missing_translations) {|missing_translations, key|
      missing_translations.has_key?(key) ? missing_translations[key] : missing_translations[key] = {}
    }
    missing_translations[key] = text
    text
  end
end

Slim::Engine.set_options tr: true, tr_fn: '::DumpMissingTranslations.tr'

at_exit do
  yaml_path = File.expand_path(File.join('source', 'locales', "missing_translations-#{I18n.locale}.yml"), __dir__)
  File.write(yaml_path, YAML.dump(DumpMissingTranslations.missing_translations))
end
