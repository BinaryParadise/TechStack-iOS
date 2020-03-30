#!/usr/bin/ruby -W0
#encoding: utf-8

require 'json'

class Extractor
    def initialize(args)
        data = Hash.new
        if File::exists?("../data.json")
            data = JSON.parse(File.read('../data.json'))
        end
        count = data.length

        args.each do |path|
            File::exists?(path) && File.open(path,'r:gb2312') do |file|
                lines = Array.new
                file.lines.each do |line|
                    begin
                        lines.push(line.encode("utf-8"))
                    rescue
                        puts line
                    end
                end
                lines = lines.join("")
                lines.scan(/<div class="st_cont">[\s\S]+?\n([\s\S]+?)<\/div>/) do |match|
                    topic = Hash.new
                    str = match[0]
                    topicid = str.scan(/<td width=8>【([\s\S]+?)】<\/td>/)[0].first
                    if topicid.eql?("230286")
                        puts "???????????????????????????????????"
                    end
                    # 选择题
                    answer = str.scan(/答案：\s+<span class=MsoNormal align=left style='text—align:left;text—autospace:none'><span lang=EN—US style='font—family:宋体'>(\S{1,2})<\/span>/).first                    
                    if answer.nil?
                        # 解析题
                        answer = str.scan(/<span id="answer">[\s\S]+>(\S+)<\/span>/).first
                        if answer.nil?
                            # 判断题
                            answer = str.scan(/<span id="answer">答案：\s{3,}(\S+)<\/span>/).first
                        end
                    end
                    if !answer.nil?
                        topic['answer'] = answer.first
                    else
                        puts "\033[35m#{topicid}可能识别到了图片\033[0m"
                        answer = str.scan(/src="(\S+)"><\/span>/).first
                        if !answer.nil?
                            topic['answer'] = answer.first
                        end
                    end

                    if !data.key?(topicid)
                        data[topicid] = topic
                    end
                end
              end
        end

        puts "合计: #{data.count} 》》》\033[32m新增题目: #{data.count - count}\033[0m"        

        topic_json_file = File.new("../data.json", 'w+')
        topic_json_file.write(JSON.pretty_generate(data))
        topic_json_file.close

    end
end

Extractor::new(ARGV)