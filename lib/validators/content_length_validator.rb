class ContentLengthValidator < ActiveModel::Validator
  def validate(record)
    minimum = options[:minimum]
    maximum = options[:maximum]
    word_count = options[:word_count] || 6

    if max_length_is_eligible(record.pure_text, maximum)
      record.errors.add :body, "should have text count less than #{maximum}."
    end
    if min_length_is_eligible(record.pure_text, minimum)
      record.errors.add :body, "should have text count less than #{minimum}."
    end
    if zero_length_is_eligible(record.pure_text)
      record.errors.add :body, "show not by empty."
    end

    if word_count_is_less(record.pure_text, word_count)
      record.errors.add :body, "should have more than #{word_count} words."
    end
  end

  private
  def max_length_is_eligible(pure_text, max)
    not pure_text.length <= max
  end

  def min_length_is_eligible(pure_text, min)
    not pure_text.length >= min
  end

  def zero_length_is_eligible(pure_text)
    pure_text.length == 0
  end

  def word_count_is_less(pure_text, word_count)
    pure_text.split(' ').count <= word_count
  end
end