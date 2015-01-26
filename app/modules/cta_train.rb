module CTATrainParser

  def self.generate_arrivals_objects(stop_id)
    xml_page = CTATrainParser.arrivals_build_uri(stop_id)
    doc = Nokogiri::XML(open(xml_page))
    arrivals = doc.xpath('//eta')
    arguments_array = CTATrainParser.argument_array(arrivals)
    CTATrainParser.arguments_to_objects(arguments_array)
  end

  private

  def self.arrivals_build_uri(stop_id)
    host = 'lapi.transitchicago.com'
    path = "/api/1.0/ttarrivals.aspx"
    arrivals_query = {
      key:  ENV["CTA_TRAIN_API_KEY"],
      stpid: stop_id,
      max: 3
    }
    uri_string = URI::HTTPS.build(host: host, path: path, query: URI.encode_www_form(arrivals_query)).to_s

    CTATrainParser.cut_https(uri_string)
  end

  def self.cut_https(uri_string)
    uri_string.gsub(/https:\/\//, "http://")
  end

  def self.arguments_to_objects(arguments_set)
    arguments_set.map do |arguments|
      Arrival.new(arguments)
    end
  end

  def self.argument_array(noko_node_set)
    arguments_array = []
    noko_node_set.each do |arrival|
      arrival_hash = CTATrainParser.create_argument_hash(arrival)
      arguments_array << arrival_hash
    end
    arguments_array
  end

  def self.create_argument_hash(node)
    arrivals_hash = { arrival_time: node.search('arrT').inner_text,
      delay_status: node.search('isDly').inner_text,
      prediction_status: node.search('isSch').inner_text
    }
    arrivals_hash
  end

end

class Arrival
  attr_reader :arrival_time

  def initialize(args)
    @arrival_time = args[:arrival_time]
    @arrival_time = time_object
    @delay_status = args[:delay_status]
    @prediction_status = args[:prediction_status]
  end

  def is_delayed?
    @delay_status == "0"
  end

  def is_live_prediction?
    @prediction_status == "0"
  end

  private

  def format_date
    date = @arrival_time[/\d{8}/]
    formatted_date = Date.strptime(date, "%Y%m%d").to_s
    split = formatted_date.split("-")
    Hash[year: split[0], mon: split[1], date: split[2]]
  end

  def format_time
    time = @arrival_time[/\d{2}:\d{2}:\d{2}/]
    split = time.split(":")
    Hash[hour: split[0], min: split[1], sec: split[2]]
  end

  def time_object
    date = format_date
    time = format_time
    Time.new(date[:year], date[:mon], date[:date], time[:hour], time[:min], time[:sec])
  end
end
