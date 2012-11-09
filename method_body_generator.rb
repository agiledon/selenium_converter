require "./parser"

class MethodBodyGenerator
  def initialize html_file
    @parser = Parser.new
    @html_file = html_file
  end

  def method_body
    actions = @parser.parse @html_file
    action_strings = []
    actions.each do |action|
      action_strings << action.generate
    end
    action_strings.join("\n")
  end
end