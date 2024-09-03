require 'net/http'
require 'uri'

pictures = %w[
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

parts_list = pictures.each_slice(3).to_a

threads = parts_list.each_with_index.map do |part_list, group_index|
  Thread.new(part_list) do |arr_url|
    arr_url.each_with_index do |uri, image_index|
      total_index = group_index * 3 + image_index
      file_name = "pica-pau-#{total_index}.jpg"
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
  end
end

threads.each(&:join)

end_time = Time.now

puts "Tempo do algoritmo com multithreading: #{end_time - start_time}"
