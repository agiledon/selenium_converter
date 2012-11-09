require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('a.html'))
doc.xpath('//table/tbody/tr').each do |tr|
    tds = tr.children
    if tds.length == 2 then
      next;
    end
    puts "Action: #{tds[0].text}"
    puts "Parameter: #{tds[2].text}"
    puts "Result: #{tds[4].text}" 
    puts "=========================="
end


def store( key, value)
  
end  



