#!/usr/bin/ruby -W0
#encoding: utf-8

require 'nokogiri'
require 'json'

class Extractor
    def initialize(args)
        puts args[0]
        data = Hash.new
        if File::exists?("../data.json")
            str = File.read('../data.json')
            if str.length == 0
                str = "{}"
            end
            data = JSON.parse(str)
        end
        count = data.length
        
        index = 0
        newCnt = 0
        args.each do |path|
            File::exists?(path) && File.open(path,'r:gbk') do |file|
                lines = Array.new
                file.lines.each do |line|
                    begin
                        lines.push(line.encode("utf-8"))
                    rescue
                        puts $!
                        puts line
                    end
                end
                lines = lines.join("")
                Nokogiri::HTML(lines).css("#page .st_cont").each do |node|
                    topicid = node.css("td[width=8]").text.scan(/【([\s\S]+?)】/)[0]
                    if topicid.instance_of? Array
                        topicid = topicid[0]
                    end
                    index = index+1
                    if args[0].start_with?("PracDeal.asp") || args[0].start_with?("showSubject.asp")
                        topic = data[topicid]
                        if !topic.nil?()
                            oldAnswer = topic['answer']
                        end
                        puts "#{index}.匹配答案【#{topicid}】\033[32m#{oldAnswer}\033[0m"
                        next
                    end

                    newAnswer = node.css("#answer .MsoNormal").text.lstrip.rstrip
                    if newAnswer.length == 0                        
                        newAnswer = node.css("#answer").text.lstrip.rstrip
                        t = newAnswer.scan(/(正确|错误)/)[0]
                        if !t.nil?()
                            newAnswer = t[0]
                        end
                    end

                    if data.key?(topicid)
                        oldAnswer = data[topicid]['answer']
                        data[topicid]['answer'] = newAnswer
                        if newAnswer.length > 0 &&  !newAnswer.eql?(oldAnswer)
                            newCnt = newCnt+1
                        end
                    else
                        newCnt = newCnt+1
                        data[topicid] = {'answer' => newAnswer}
                    end
                    
                    puts "#{index}.提取答案【#{topicid}】\033[33m#{newAnswer}\033[0m"
                end
              end
        end

        puts "合计: #{data.count} 本次：#{index} \033[32m新增题目: #{newCnt}\033[0m"        

        topic_json_file = File.new("../data.json", 'w+')
        topic_json_file.write(JSON.pretty_generate(data))
        topic_json_file.close

    end
end

Extractor::new(ARGV)