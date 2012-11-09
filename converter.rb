require 'nokogiri'
require 'open-uri'


class Action
  attr_reader :action, :first_param, :result
  
  def initialize(action, first_param, second_param)
    @action = action
    @first_param = first_param
    @second_param = second_param
  end
  
  def generate
      send("#{@action}")
  end
  
  def store 
    "int #{@second_param} = #{@first_param};"
  end 
  
  def open
    "page.open(\"#{@first_param}\");"
  end
  
  def type
    "page.type(id(\"#{@first_param}\"), \"#{@second_param}\")"
  end


    def clickAndWait
      "page.click(id(\"#{@first_param}\"))"
    end


    def verifyTitle
      "assertThat(page.getTitle(), is(\"#{@first_param}\"))"
    end


    def verifyText
      
    end


    def verifyElementNotPresent

    end


    def verifyTextNotPresent

    end


    def click

    end


    def selectWindowWithWait

    end


    def waitForCondition

    end


    def close

    end
end

def parse(html)
  result = []
  doc = Nokogiri::HTML(open(html))
  doc.xpath('//table/tbody/tr').each do |tr|
      tds = tr.children
      if tds.length == 2 then
        next;
      end
      action = Action.new(tds[0].text, tds[2].text, tds[4].text)
      result << action
      # puts "Action: #{tds[0].text}"
      #       puts "first_param: #{tds[2].text}"
      #       puts "Result: #{tds[4].text}" 
      #       puts "=========================="
  end
  result
end

actions = parse('a.html')
actions.each do |action|
  puts action.generate
# actions.collect(&:action).uniq.each do |action|
  # puts """
  # def #{action}
  # 
  # end
  # """
  # 
end


def store( key, value)
  
end  



