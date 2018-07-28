module DashboardHelper
  def make_word(word)
    word.split('_').map(&:capitalize).join(' ')
  end

  def add_sign(object, field)
    if field.include?('price') or field.include?('cost') or field.include?('charge')
      return "$#{object[field]}"
    end

    if field.include?('discount')
      return "#{object[field]}%"
    end

    if field.include?('hours')
      return pluralize(object[field], 'hour')
    end

    if field.include?('people')
      return pluralize(object[field], 'person')
    else
      return object[field]
    end
    
  end
end
