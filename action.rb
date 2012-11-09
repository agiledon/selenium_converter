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
    if application_error_element?
      return "assertThat(page.getError(#{application_error_index}), is(\"#{@second_param}\"));"
    end
    if table_cell_text?
      matches = @first_param.scan(/document.getElementById\(\'(.*)\'\).cells\[\$\{(.*)\}\]/)[0]
      return "assertThat(page.getCellText(\"#{matches[0]}\", #{matches[1]}), is(\"#{@second_param}\"));"
    end

    #assertTrue(page.getText("errorMessage").matches("^The following error\\(s\\) occurred:[\\s\\S]*$"));
    if regexp?
      return "assertTrue(page.getText(\"#{@first_param}\").matches(\"^#{@second_param}$\"));"
    end


    "assertThat(page.getText(\"#{@first_param}\"), is(\"#{@second_param}\"));"
  end


  def table_cell_text?
    @first_param.match(/document.getElementById\(\'(.*)\'\).cells\[\$\{(.*)\}\]/)
  end


  def verifyElementNotPresent
    if application_error_element?
      return "assertFalse(page.hasError(#{application_error_index}));"
    end
  end


  def verifyTextNotPresent
    "assertFalse(page.isTextPresent(\"#{@first_param}\"));"
  end


  def click
    if is_link?
      return "page.click(linkText(\"#{link_text}\"));"
    end
    "page.click(id(\"#{@first_param}\"));"
  end


  def selectWindowWithWait
    "page.selectPopUpWindow(\"#{@first_param}\");"
  end


  def waitForCondition
    "//TODO waitForCondition(#{tr_element_id})"
  end


  def close

  end

  def verifyAttribute
    return "assertThat(page.isElementPresent(#{@first_param}));"
  end

  def verifyElementPresent
    return "assertTrue(page.isElementPresent(#{@first_param}));"
  end

  private

  def regexp?
    @first_param.match(/.*\*$/)[0][0]
  end

  def tr_element_id
    @first_param.scan(/findElementAttempt\(.*tr\[@id='(.*)'.*/)[0][0]
  end

  def is_link?
    @first_param.match(/.*link=.*/)
  end

  def link_text
    @first_param.scan(/.*link=(.*)/)[0][0]
  end

  def application_error_index
    @first_param.scan(/.*'applicationErrors'.*\[(\d*?)\].*/)[0][0]
  end

  def application_error_element?
    @first_param.match(/.*'applicationErrors'.*\[(\d*?)\].*/)
  end

end
