class Sagyoushiji < ActiveRecord::Base
  belongs_to :itakuhaken
  has_one :sagyouhoukoku

def self.docx(sagyoushiji)
    input_file = "./tmp/template.docx"
    data = {
      key: "日本語でようこそ",
      hello: "hello world",
      students: [
        {name: "おぱ", score: 88},
        {name: "富夫", score: 50},
        {name: "久子", score: 40}
      ]
    }
    new_doc = DocxTemplater::DocxCreator.new(input_file, data)
    #new_doc.generate_docx_file('./tmp/output.docx')
    return new_doc.generate_docx_bytes
    
    
    
end  

end
