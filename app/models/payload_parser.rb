module PayloadParser
  extend self

  def parser(params)
    JSON.parse(params)
  end
end
