require 'FileUtils'
require 'find'
require './method_body_generator'
class SeleniumToJavaConverter
  attr_accessor :parser, :class_name
  @@output_dir = 'au/com/suncorp/crmservices/html/'

  def initialize(fileName)
    puts "Converting #{fileName}"
    @class_name = createClassName fileName
    @parser = MethodBodyGenerator.new fileName
  end

  def createClassName fileName
    File.basename(fileName, '.*')
  end


  def convert
    javaCode = "" "
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2011, Suncorp Metway Limited. All rights reserved.
//
// This is unpublished proprietary source code of Suncorp Metway Limited.
// The copyright notice above does not evidence any actual or intended
// publication of such source code.
//
////////////////////////////////////////////////////////////////////////////////
package au.com.suncorp.crmservices.html;
import au.com.suncorp.crmservices.webdriver.PageTestCase;
import org.junit.Ignore;
import org.junit.Test;
import org.openqa.selenium.By;

import static java.net.URLEncoder.encode;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;
import static org.openqa.selenium.By.id;
import static org.openqa.selenium.By.name;
import static org.openqa.selenium.By.xpath;

public  class #{@class_name} extends PageTestCase {

    private EditContactDetailsPage page;

    protected void onSetUpInBrowser() {
        page = new EditContactDetailsPage(browser);
    }

    @Test
    public void test#{@class_name}(){
        #{@parser.method_body}
    }
}
      " ""

    File.open("#{@@output_dir+@class_name}.java", 'w') { |f| f.write(javaCode) }
  end

end

FileUtils.rmtree 'au'
FileUtils.makedirs 'au/com/suncorp/crmservices/html/'

Find.find('html') do |f|
  (SeleniumToJavaConverter.new f).convert if f.match(/\.html\Z/)
end
