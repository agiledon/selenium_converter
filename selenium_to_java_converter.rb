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

    java_class_header = IO.read("java_class_header.txt")
    File.open("#{@@output_dir+@class_name}.java", 'w') { |f| f.write(java_class_header + javaCode) }
  end

end

FileUtils.rmtree 'au'
FileUtils.makedirs 'au/com/suncorp/crmservices/html/'

Find.find('html') do |f|
  (SeleniumToJavaConverter.new f).convert if f.match(/\.html\Z/)
end
