class PayloadParser
  attr_accessor :data, :message, :status_code

  def initialize(data={})
    @data = data
    @message = ""
    @status_code = ""
  end

  def valid?
    if data.empty?
      message = "Payload is missing or empty"
      status_code = 400
    end
  end

  def parse_payload(data)

    conversion(JSON.parse(data[:payload]))
    #conversion(JSON.parse(params[data.key]))
  end

  def conversion(data)
    new_data = data.keys.map do |key|
      key.chars.map do |char|
        if char == char.upcase
          char = "_" + char.downcase
        else
          char
        end
      end.join.to_sym
    end
    data_keys = new_data
    data_values = data.values
    new_table_names = Hash[data_keys.zip(data_values)]
  end
end
