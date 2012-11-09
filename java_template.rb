require 'FileUtils'
require 'find'
class JavaTemplate
  attr_accessor :parser, :class_name
  @@output_dir = 'au/com/suncorp/crmservices/html/'


  def initialize(fileName)
    @class_name = createClassName fileName
    #@parser = Parser.new fileName
  end

  def createClassName fileName
    File.basename(fileName, '.*')
  end


  def generate
    abc = "" "
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
      class #{@class_name} extends PageTestCase {
        @Test
        publict void test#{@class_name}(){

        #{
        #@parser.method_body
        } }
      }
      " ""

    File.open("#{@@output_dir+@class_name}.java", 'w') { |f| f.write(abc) }
  end

end

FileUtils.rmtree 'au'
FileUtils.makedirs 'au/com/suncorp/crmservices/html/'

Find.find('html') do |f|
  if f.match(/\.html\Z/)
    template = JavaTemplate.new f
    template.generate
  end
end
