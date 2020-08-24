#!/usr/bin/ruby -W0
#encoding: utf-8

require 'nokogiri'
require 'json'

class RegexTest
    def initialize(args)
        data = Hash.new
        if File::exists?("../data.json")
            str = File.read('../data.json')
            if str.length == 0
                str = "{}"
            end
            data = JSON.parse(str)
        end
        count = data.length
        File::exists?(args[0]) && File.open(args[0],'r:gbk') do |file|
            # 编码转换
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
                puts node.css("td[width=8]").text
                puts node.css("#answer .MsoNormal").text
            end
        end
    end
end
RegexTest::new(ARGV)