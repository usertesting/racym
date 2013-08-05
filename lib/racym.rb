require "racym/version"

def racym(*args)
  value = args.map(&:to_s).join('.').split('.').inject(Rails.application.config) { |r, m| r = r.send(m); r }

  if value.is_a?(Proc)
    value.call
  else
    value
  end
end

def racym_set(*args)
  Rails.application.config.racym_cache ||= {}
  after = args.pop
  before = racym(*args)
  token = args.map(&:to_s).join('.').split('.').join('.')

  if Rails.application.config.racym_cache[token]
    before = Rails.application.config.racym_cache[token].first
  end

  config_methods = token.split('.')

  config_methods.inject([config_methods.last, Rails.application.config]) do |last_and_rails_config, current_method|
    last, rails_config = last_and_rails_config

    rails_config = if last == current_method
      rails_config.send("#{current_method}=", after)
    else
      rails_config = rails_config.send(current_method)
    end

    [last, rails_config]
  end

  Rails.application.config.racym_cache[token] = [before, after]
end

def racym_undo!
  return unless Rails.application.config.racym_cache.is_a? Hash

  Rails.application.config.racym_cache.each do |key, changes|
    config_methods = key.split('.')
    racym_set(key, changes.first)
  end
  
  Rails.application.config.racym_cache = nil
end
