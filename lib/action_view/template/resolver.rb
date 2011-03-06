module ActionView
  class Resolver
    def initialize
      @cache = Hash.new { |h1,k1| h1[k1] = Hash.new { |h2,k2| h2[k2] = Hash.new { |h3,k3| h3[k3] = {} } } }
    end
    
    def clear_cache
      @cache.clear
    end
    
    def find_all
      cached(key, prefix, name, partial) do
        find_templates(name, prefix, partial, details)
      end
    end
    
    private
    
    def caching?
      @caching ||= Rails.application.config.cache_classes
    end
    
    def find_templates(name, prefix, partial, details)
      raise NotImplementedError
    end
    
    def cached(key, prefix, name, partial)
      return yield unless key && caching?
      @cached[key][prefix][name][partial] ||= yield
    end
  end
end