require 'nokogiri'
require 'open-uri'


class Action
  attr_reader :action, :parameter, :result
  
  def initialize(action, parameter, result)
    @action = action
    @parameter = parameter
    @result = result
  end
  
  def generate
      send("#{@action}", @parameter, @result  )
  end
  
  def store parameter, result
    "int #{result} = #{parameter};"
  end 
  
  def open parameter, result
    "int #{result} = #{parameter};"
  end
  
  def type parameter, result

    end


    def clickAndWait parameter, result

    end


    def verifyTitle parameter, result

    end


    def verifyText parameter, result

    end


    def verifyElementNotPresent parameter, result

    end


    def verifyTextNotPresent parameter, result

    end


    def click parameter, result

    end


    def selectWindowWithWait parameter, result

    end


    def waitForCondition parameter, result

    end


    def close parameter, result

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
      #       puts "Parameter: #{tds[2].text}"
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
  # def #{action} parameter, result
  # 
  # end
  # """
  # 
end


def store( key, value)
  
end  



