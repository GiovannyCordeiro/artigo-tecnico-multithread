require 'net/http'
require 'uri'

woodpicker_pictures = %w[
  https://pbs.twimg.com/media/EzJcIh9UYAMXyvA?format=jpg&name=360x360
  https://pbs.twimg.com/media/EzJcMAvVoAY5ayR?format=jpg&name=900x900
  https://pbs.twimg.com/media/EzJcRobUcBIFIxC?format=jpg&name=360x360
  https://pbs.twimg.com/media/EzJdQKSVgAI99_B?format=jpg&name=small
  https://pbs.twimg.com/media/EzJdTwxVoAkZaRB?format=jpg&name=240x240
  https://pbs.twimg.com/media/EzJeAr3VUAY7k4o?format=jpg&name=small
  https://pbs.twimg.com/media/EzJeAsAUcAEXAxe?format=jpg&name=240x240
  https://pbs.twimg.com/media/EzJeHm2UUAIfhiV?format=jpg&name=small
  https://pbs.twimg.com/media/EzJeHmnVIAM7cDI?format=jpg&name=small
  https://pbs.twimg.com/media/EzJePe1VkAga8p5?format=jpg&name=small
  https://pbs.twimg.com/media/EzJeKVdVIAsEu0h?format=jpg&name=small
  https://pbs.twimg.com/media/EzJeKVeVUAo6ieG?format=jpg&name=medium
]

start_time = Time.now

woodpicker_pictures.each_with_index do |uri, idx|
  file_name = "pica-pau-#{idx}.jpg"
  url = URI.parse(uri)
  response = Net::HTTP.get_response(url)

  if response.is_a?(Net::HTTPSuccess)
    File.open(file_name, 'wb') do |file|
      file.write(response.body)
    end
  else
    puts "Falha no momento da requisição #{response.code}: #{response.message}"
  end
end

end_time = Time.now

puts "Tempo do algoritmo tradicional: #{end_time - start_time}"
