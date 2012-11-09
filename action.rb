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
    "page.type(id(\"#{@first_param}\"), \"#{@second_param}\");"
  end


  def clickAndWait
    "page.click(id(\"#{@first_param}\"));"
  end

  def verifyTitle
    "assertThat(page.getTitle(), is(\"#{@first_param}\"));"
  end

  def verifyText
    if is_application_error_element?
      return "assertThat(page.getError(#{application_error_index}), is(\"#{@second_param}\"));"
    end
    if @first_param.match(/document.getElementById\(\'(.*)\'\).cells\[\$\{(.*)\}\]/)
      matches = @first_param.scan(/document.getElementById\(\'(.*)\'\).cells\[\$\{(.*)\}\]/)[0]
      return "assertThat(page.getCellText(id(\"#{matches[0]}\"), #{matches[1]}), is(\"#{@second_param}\"));"
    end


    "assertThat(page.getText(\"#{@first_param}\")), is(\"#{@second_param}\")"
  end


  def verifyElementNotPresent
    if is_application_error_element?
      return "assertFalse(page.hasError(#{application_error_index}));"
    end
  end


  def verifyTextNotPresent
    "assertThat(page.isTextPresent(\"#{@first_param}\"));"
  end


  def click
    "page.click(id(\"#{@first_param}\"))"
  end


  def selectWindowWithWait

  end


  def waitForCondition

  end


  def close

  end

  private
  def is_link?

  end

  def application_error_index
    @first_param.scan(/.*'applicationErrors'.*\[(\d*?)\].*/)[0][0]
  end

  def is_application_error_element?
    @first_param.match(/.*'applicationErrors'.*\[(\d*?)\].*/)
  end

end