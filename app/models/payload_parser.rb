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
      [message, status_code]
    end
  end

  def parse(data)
    conversion(JSON.parse(data[:payload]))
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

        #if PayloadPars
          #status 400
          #body identifier.errors.full_messages
        #elsif
          #payload = Payload.new(payload_data)
          #status 200
          #body "success"
        ##elsif identifier.title.nil?
          ##status 400
          ##body identifier.errors.full_messages
        #else
          #status 403
          #body payload.errors.full_messages
        #end

end
