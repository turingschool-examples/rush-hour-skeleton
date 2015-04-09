class InputConverter

  def self.conversion(data)
    data_keys = data.keys.map do |key|
      key.chars.map do |char|
        if char == char.upcase
          char = "_" + char.downcase
        else
          char
        end
      end.join.to_sym
    end
    new_table_names = Hash[data_keys.zip(data.values)]
  end

end
