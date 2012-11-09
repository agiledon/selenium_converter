require 'nokogiri'
require 'open-uri'
require "./action"

class Parser
  def parse html
    actions = []
    doc = Nokogiri::HTML(open(html))
    doc.xpath('//table/tbody/tr').each do |tr|
      tds = tr.children
      if tds.length == 2 then
        next;
      end
      action = Action.new(tds[0].text, tds[2].text, tds[4].text)
      actions << action
    end
    actions
  end
end