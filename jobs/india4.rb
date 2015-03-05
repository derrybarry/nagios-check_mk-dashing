require 'open-uri'
require 'nokogiri'

SCHEDULER.every '90s' do

doc = Nokogiri::XML(open("http://+++/pnp4nagios/xport/xml?host=juliet&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
root = doc.root		#mark the top of the xml data
cpu = root.xpath("//row/v[1]")# search for tags that match "act" there is only one set
cpu = cpu.to_a()
times = root.xpath("//row/t")# search for tags that match "act" there is only one set
times = times.to_a()

data = [
    { "x" => times[-34].inner_text().to_f .round(1), "y" => cpu[-34].inner_text().to_f .round(1) },
    { "x" => times[-33].inner_text().to_f .round(1), "y" => cpu[-33].inner_text().to_f .round(1) },
    { "x" => times[-32].inner_text().to_f .round(1), "y" => cpu[-32].inner_text().to_f .round(1) },
    { "x" => times[-31].inner_text().to_f .round(1), "y" => cpu[-31].inner_text().to_f .round(1) },
    { "x" => times[-30].inner_text().to_f .round(1), "y" => cpu[-30].inner_text().to_f .round(1) },
    { "x" => times[-29].inner_text().to_f .round(1), "y" => cpu[-39].inner_text().to_f .round(1) },
    { "x" => times[-28].inner_text().to_f .round(1), "y" => cpu[-28].inner_text().to_f .round(1) },
    { "x" => times[-27].inner_text().to_f .round(1), "y" => cpu[-27].inner_text().to_f .round(1) },
    { "x" => times[-26].inner_text().to_f .round(1), "y" => cpu[-26].inner_text().to_f .round(1) },
    { "x" => times[-25].inner_text().to_f .round(1), "y" => cpu[-25].inner_text().to_f .round(1) },
    { "x" => times[-24].inner_text().to_f .round(1), "y" => cpu[-24].inner_text().to_f .round(1) },
    { "x" => times[-23].inner_text().to_f .round(1), "y" => cpu[-23].inner_text().to_f .round(1) },
    { "x" => times[-22].inner_text().to_f .round(1), "y" => cpu[-22].inner_text().to_f .round(1) },
    { "x" => times[-21].inner_text().to_f .round(1), "y" => cpu[-21].inner_text().to_f .round(1) },
    { "x" => times[-20].inner_text().to_f .round(1), "y" => cpu[-20].inner_text().to_f .round(1) },
    { "x" => times[-19].inner_text().to_f .round(1), "y" => cpu[-19].inner_text().to_f .round(1) },
    { "x" => times[-18].inner_text().to_f .round(1), "y" => cpu[-18].inner_text().to_f .round(1) },
    { "x" => times[-17].inner_text().to_f .round(1), "y" => cpu[-17].inner_text().to_f .round(1) },
    { "x" => times[-16].inner_text().to_f .round(1), "y" => cpu[-16].inner_text().to_f .round(1) },
    { "x" => times[-15].inner_text().to_f .round(1), "y" => cpu[-15].inner_text().to_f .round(1) },
    { "x" => times[-14].inner_text().to_f .round(1), "y" => cpu[-14].inner_text().to_f .round(1) },
    { "x" => times[-13].inner_text().to_f .round(1), "y" => cpu[-13].inner_text().to_f .round(1) },
    { "x" => times[-12].inner_text().to_f .round(1), "y" => cpu[-12].inner_text().to_f .round(1) },
    { "x" => times[-11].inner_text().to_f .round(1), "y" => cpu[-11].inner_text().to_f .round(1) },
    { "x" => times[-10].inner_text().to_f .round(1), "y" => cpu[-10].inner_text().to_f .round(1) },
    { "x" => times[-9].inner_text().to_f .round(1), "y" => cpu[-9].inner_text().to_f .round(1) },
    { "x" => times[-8].inner_text().to_f .round(1), "y" => cpu[-8].inner_text().to_f .round(1) },
    { "x" => times[-7].inner_text().to_f .round(1), "y" => cpu[-7].inner_text().to_f .round(1) },
    { "x" => times[-6].inner_text().to_f .round(1), "y" => cpu[-6].inner_text().to_f .round(1) },
    { "x" => times[-5].inner_text().to_f .round(1), "y" => cpu[-5].inner_text().to_f .round(1) },
    { "x" => times[-4].inner_text().to_f .round(1), "y" => cpu[-4].inner_text().to_f .round(1) }
        ]


if data[-1].values_at("y") == "0"

	data3 = data[0..-2]

elseif data[-2].values_at("y") == "0"
    
	data3 = data[0..-3]	
else

data3 = data[0..-1]


  send_event('graph4', points: data3)

 end
 end
