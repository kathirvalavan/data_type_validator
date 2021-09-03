module CommonHelper
  def get_sample_value(type)
    case type
    when :string
      ['sample1', 'sample2', 'sample3', 'sample4'].sample
    when :integer
      [1, 2, 3, 4].sample
    when :float
      [1.12, 2.12, 3.12, 4.12].sample
    when :boolean
      [true, false].sample
    end
  end
end
