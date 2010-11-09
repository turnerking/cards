class Fixnum
  def ordinal
    case
    when self % 10 == 1
      "#{self}st"
    when self % 10 == 2
      "#{self}nd"
    when self % 10 == 3
      "#{self}rd"
    else
      "#{self}th"
    end
  end
end
